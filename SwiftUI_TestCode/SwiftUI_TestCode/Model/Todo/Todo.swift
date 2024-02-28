//
//  Todo.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/28/24.
//

import Foundation

struct Todo: Hashable {
    var title: String
    var time: Date
    var day: Date
    var selected: Bool
    var convertedDayAndTime: String {
        String("\(day.formattedDay) - \(time.formattedTime)에 알림")
    }
}
