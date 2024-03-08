//
//  MemoView.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/28/24.
//

import SwiftUI

struct MemoView: View {
    
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @StateObject var memoViewModel: MemoViewModel
    @State var isCreateMode: Bool = true
         
    
    var body: some View {
    
        ZStack{
            //navi
            VStack{
                CustomNavigationBar(leftBtnAction: {
                    pathModel.paths.removeLast()
                }, rightBtnAction: {
                    if isCreateMode {
                        memoListViewModel.addMemo(memoViewModel.memo)
                    }else{
                        memoListViewModel.updateMemo(memoViewModel.memo)
                    }
                    pathModel.paths.removeLast()
                }, naviType: isCreateMode ? .create : .complete )
                
                //title
                
                Titleview(memoViewModel: memoViewModel, isCreateMode: $isCreateMode)
                    .padding(.top, 20)
                //input
                
                MemoInputView(memoViewModel: memoViewModel)
                    .padding(.top, 10)
            }
            
            if !isCreateMode {
                RemoveMemoBtnView(memoViewModel: memoViewModel)
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
            }
        }
    }
}

// MARK: SubView
// MARK: title
private struct Titleview: View {
    @ObservedObject private var memoViewModel: MemoViewModel
    @FocusState private var isTitleFieldFocused: Bool
    @Binding private var isCreateMode: Bool
    

    fileprivate init(memoViewModel: MemoViewModel, isCreateMode: Binding<Bool>) {
        self.memoViewModel = memoViewModel
        self._isCreateMode = isCreateMode
    }
    
    fileprivate var body: some View {
        TextField("제목을 입력하세요.",text: $memoViewModel.memo.title)
            .font(.system(size: 20))
            .padding(.horizontal, 20)
            .focused($isTitleFieldFocused)
            .onAppear{
                if isCreateMode {
                    isTitleFieldFocused = true
                }
            }
    }
}


// MARK: input
private struct MemoInputView: View {
    @ObservedObject private var memoViewModel: MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
        
        ZStack(alignment: .topLeading) {
            TextEditor(text: $memoViewModel.memo.content)
                .font(.system(size: 20))
            
            if memoViewModel.memo.content.isEmpty {
                Text("메모를 입력하세요.")
                    .font(.system(size: 16))
                    .padding(.top, 10)
                    .padding(.leading, 5)
                    .allowsHitTesting(false) //터치 안먹음, 텍스터 에디터가 터치를 받을 수 있도록
                    .foregroundColor(.gray1)
            }
        }.padding(.horizontal, 20)
        
    }
}

// MARK: memo delete

private struct RemoveMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @ObservedObject private var memoViewModel: MemoViewModel
    
    fileprivate init( memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    var body: some View {
    
        VStack{
            Spacer()
            
            HStack{
                Spacer()
                
                Button(action: {
                    memoListViewModel.removeMemo(memoViewModel.memo)
                    pathModel.paths.removeLast()
                }, label: {
                    Image("trash")
                        .resizable()
                        .frame(width: 40, height: 40)
                })
            }
        }
    }
}

#Preview {
    MemoView(memoViewModel: MemoViewModel(memo: Memo(title: "", content: "", date: Date())))
}
