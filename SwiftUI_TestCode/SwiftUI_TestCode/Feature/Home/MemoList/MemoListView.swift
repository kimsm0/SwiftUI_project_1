//
//  MemoListView.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 3/8/24.
//

import SwiftUI

struct MemoListView: View {
    
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    
    //zstack으로 쌓이는 1 : vstack
    //zstack으로 쌓이는 2 : floating btn
    var body: some View {
        ZStack{
            //zstack 1번
            VStack{
                //vstack으로 쌓이는 1 : 커스텀 네비게이션
                if !memoListViewModel.memos.isEmpty {
                    CustomNavigationBar(hasRightBtn: true, rightBtnAction: {
                        memoListViewModel.navigationRightBtnTabbed()
                    }, naviType: memoListViewModel.navigationBarRightBtnMode)
                }else{
                    Spacer()
                        .frame(height: 30)
                }
                //vstack으로 쌓이는 2: 타이틀 뷰
                TitleView()
                    .padding(.top, 20)
                
                if memoListViewModel.memos.isEmpty {
                    GuideView()
                }else {
                    MemoListContentView()
                        .padding(.top, 20)
                }
                
                //vstack으로 쌓이는 3: 케이스에 따라 안내뷰 or 메모 리스트
                WriteMemoBtnView()
                    .padding(.trailing, 20)
                    .padding(.bottom, 50)
            }
            .alert("선택한 메모 \(memoListViewModel.removeMemoCount)개를 삭제하시겠습니까?",
                   isPresented: $memoListViewModel.isDisplayMemoAlert) {
                Button("삭제", role: .destructive, action: {
                    memoListViewModel.removeBtnTabbed()
                })
                Button("취소",role: .cancel, action: {
                    
                })
            }
        }        
    }
}

// MARK: Sub View
// MARK: 1 - TitleView

private struct TitleView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        HStack {
            if memoListViewModel.memos.isEmpty {
                Text("메모를\n추가해 보세요.")
            }else{
                Text("메모 \(memoListViewModel.memos.count)개가\n있습니다.")
            }
            
            Spacer()
        }.font(.system(size: 30, weight: .bold))
            .padding(.leading, 20)
        
    }
}

// MARK: 메모 없을 때, 안내 뷰
private struct GuideView: View {
    fileprivate var body: some View {
        VStack(spacing: 15) {
            
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            
            Text("\"퇴근 9시간 전 메모\"")
            Text("\"기획서 작성 후 퇴근하기 메모\"")
            Text("\"밀린 집안일 하기 메모\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.gray2)
    }
}

// MARK: memo list content view
private struct MemoListContentView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    var body: some View {
        
        VStack{
            HStack{
                Text("메모 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            ScrollView(.vertical, content: {
                VStack(spacing: 0){
                    Rectangle()
                        .fill(.gray0)
                        .frame(height: 1)
                    
                    ForEach(memoListViewModel.memos, id: \.self ) { memo in
                        //memo cell view
                        MemoCellView(memo: memo)
                    }
                }
            })
        }
    }
}


// MARK: Memo Cell View
private struct MemoCellView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @State private var isRemoveSelected: Bool
    private var memo: Memo
    
    fileprivate init(isRemoveSelected: Bool = false, memo: Memo) {
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.memo = memo
    }
    
    fileprivate var body: some View {
        //전체가 클릭 가능 영역
        Button(
            action: {
                //todo - 이동 로직 추가 필요
                pathModel.paths.append(.memoView(isCreatedMode: false, memo: memo))
            }, label: {
                VStack(spacing: 10) {
                    HStack {
                        VStack(alignment: .leading){
                            Text(memo.title)
                                .lineLimit(1)
                                .font(.system(size: 16))
                                .foregroundColor(.black)

                            Text(memo.convertedDate)
                                .font(.system(size: 12))
                                .foregroundColor(.gray2)
                        }
                        
                        Spacer()
                        
                        if memoListViewModel.isEditMemoMode {
                            Button(action: {
                                isRemoveSelected.toggle()
                                memoListViewModel.memoRemoveSelectedBoxTabbed(memo)
                            }, label: {
                                isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
                            })
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    
                    Rectangle()
                        .fill(.gray1)
                        .frame(height: 1)
                }
            }
        )
    }
}


// MARK: memo

private struct WriteMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel

    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack{
                Spacer()
                
                Button(action: {
                    //todo
                    pathModel.paths.append(.memoView(isCreatedMode: true, memo: nil))
                }, label: {
                    Image("floatingMemoWriteBtn")
                })
            }
        }
    }
}

#Preview {
    MemoListView()
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
}
