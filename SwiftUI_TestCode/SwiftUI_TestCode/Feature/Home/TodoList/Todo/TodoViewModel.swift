//
//  TodoViewModel.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/28/24.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var title: String
    @Published var time: Date
    @Published var day: Date
    @Published var isDislayCalendar: Bool
    
    init(title: String = "", time: Date = Date(), day: Date = Date(), isDislayCalendar: Bool = false) {
        self.title = title
        self.time = time
        self.day = day
        self.isDislayCalendar = isDislayCalendar
    }
}

extension TodoViewModel {
    func setIsDisplayCalendar(_ isDisplay: Bool) {
        isDislayCalendar = isDisplay
    }
}
