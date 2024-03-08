//
//  Memo.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 3/8/24.
//

import Foundation

struct Memo: Hashable {
    var title: String
    var content: String
    var date: Date
    var id = UUID()
    
    var convertedDate: String {
        String("\(date.formattedDay) - \(date.formattedTime)")
    }
}
