//
//  MemoListViewModel.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 3/8/24.
//

import Foundation

class MemoListViewModel: ObservableObject {
    
    @Published var memos: [Memo]
    @Published var isEditMemoMode: Bool
    @Published var removeMemos: [Memo]
    @Published var isDisplayMemoAlert: Bool
    
    var removeMemoCount: Int {
        removeMemos.count
    }
    
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditMemoMode ? .complete : .edit
    }
    
    init(memos: [Memo] = [], isEditMemoMode: Bool = false, removeMemos: [Memo] = [], isDisplayMemoAlert: Bool = false) {
        self.memos = memos
        self.isEditMemoMode = isEditMemoMode
        self.removeMemos = removeMemos
        self.isDisplayMemoAlert = isDisplayMemoAlert
    }
}

extension MemoListViewModel {
    func addMemo(_ memo: Memo){
        memos.append(memo)
    }
    
    func updateMemo(_ memo: Memo) {
        if let idx = memos.firstIndex(where: { $0.id == memo.id }) {
            memos[idx] = memo
        }
    }
    
    func removeMemo(_ memo: Memo){
        if let idx = memos.firstIndex(where: { $0.id == memo.id }) {
            memos.remove(at: idx)
        }
    }
    
    func navigationRightBtnTabbed(){
        if isEditMemoMode {
            if removeMemos.isEmpty {
                isEditMemoMode = false
            }else {
                setIsDisplayMemoAlert(true)
            }
        }else {
            isEditMemoMode = true
        }
    }
    
    func setIsDisplayMemoAlert(_ isDisplay: Bool){
        isDisplayMemoAlert = isDisplay
    }
    
    func memoRemoveSelectedBoxTabbed(_ memo: Memo) {
        if let idx = removeMemos.firstIndex(where: { $0.id == memo.id }) {
            removeMemos.remove(at: idx)
        }else{
            removeMemos.append(memo)
        }
    }
    
    func removeBtnTabbed(){
        memos.removeAll(where: {
            removeMemos.contains($0)
        })
        removeMemos = []
        isEditMemoMode = false 
    }
}
