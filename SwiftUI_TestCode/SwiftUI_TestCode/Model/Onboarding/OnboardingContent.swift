//
//  OnboardingContent.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/26/24.
//

import Foundation

//모델 객체
struct OnboardingContent: Hashable {
    
    var imageFileName: String //온보딩 화면 상단 이미지 영역에 들어갈 이미지 파일 명
    var title: String //온보딩 화면 하단 타이틀
    var subTitle: String //온보딩 화면 타이틀 아래 서브 타이틀
    
    
    init(imageFileName: String, title: String, subTitle: String) {
        self.imageFileName = imageFileName
        self.title = title
        self.subTitle = subTitle
    }
    
    
}
