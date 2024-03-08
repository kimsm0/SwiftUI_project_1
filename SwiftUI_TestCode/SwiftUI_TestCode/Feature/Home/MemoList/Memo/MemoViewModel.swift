//
//  MemoViewModel.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 3/8/24.
//

import Foundation

class MemoViewModel: ObservableObject{
    
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}
