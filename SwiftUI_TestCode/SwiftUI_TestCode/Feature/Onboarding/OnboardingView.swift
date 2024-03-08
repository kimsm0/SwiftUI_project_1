//
//  OnboardingView.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/26/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var pathModel = PathModel()
    @StateObject private var todoListViewModel = TodoListViewModel()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths, root: {
            //OnboardingContentView(onboardingViewModel: onboardingViewModel)
            TodoListView()
                .environmentObject(todoListViewModel)
                .navigationDestination(for: PathType.self, destination: { pathType in
                    switch pathType {
                    case .homeView:
                        HomeView()
                            .navigationBarBackButtonHidden(true)
                    case .todoView:
                        TodoView()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(todoListViewModel)
                    case .memoView(_):
                        MemoView()
                            .navigationBarBackButtonHidden(true)
                    }
                })
        })
        .environmentObject(pathModel)
    }
}

// MARK: - 온보딩 컨첸츠 뷰
private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    fileprivate var body: some View {
        VStack {
            OnboardingTopTabView(onboardingViewModel: onboardingViewModel)
            
            Spacer()
            
            StartButtonView()
        }
        .edgesIgnoringSafeArea(.top) //상단 safe area 무시.
    }
}


// MARK: - 온보딩 셀 리스트 뷰.
//상단 이미지+텍스트 영역 뷰
private struct OnboardingTopTabView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex: Int
    
    fileprivate init(onboardingViewModel: OnboardingViewModel, selectedIndex: Int = 0) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        TabView(selection: $selectedIndex,
                content:  {
                //각각의 셀
                ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element){
                    index, onboardingContent in
                    OnboardingTabContentsView(onboardingContent: onboardingContent)
                        .tag(index)
                }
        })
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
        .background(selectedIndex % 2 == 0 ?
                    Color.customBgSky: Color.customBgGreen)
    }
}

// MARK: - 온보딩 셀 탭뷰안에 들어갈 뷰
// 하위컨텐츠를 나누는것에 이점이 있음.
// SwiftUI는 블럭 쌓는것이 핵심. 버벅임이 있을 수 있고, 빌드 안될 수 있음.
// 가독성을 해치지 않는 선에서 하위 컨텐츠를 나누는 것이 좋음.

private struct OnboardingTabContentsView: View {
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }
    var body: some View {
        VStack{
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()
            HStack{
                Spacer()
                
                VStack{
                    Spacer()
                        .frame(height: 40)
                    
                    Text(onboardingContent.title)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text(onboardingContent.subTitle)
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(0)
        }
        .shadow(radius: 10)
    }
}

private struct StartButtonView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        Button(action: {
            pathModel.paths.append(.homeView)
        }, label: {
            HStack{
                Text("시작하기")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.green)
                
                Image("startHome")
                    .renderingMode(.template)
                    .foregroundColor(.green)
            }
        })
        .padding(.bottom, 50)
    }
}

// MARK: - Preview

#Preview {
    OnboardingView()
}
