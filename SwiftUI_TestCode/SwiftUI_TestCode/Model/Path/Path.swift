//
//  Path.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/28/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
