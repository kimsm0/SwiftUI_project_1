//
//  OnboardingViewModel.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/26/24.
//

import Foundation

//view - viewmodel 구현 순서는 스타일 차이
//데이터 구조는 나왔으나 통신이 준비 안된 상태에서는
//stub 데이터로 넣어서 사용하기도 함.
//네트워크 통신으로 받아오는 데이터가 아니므로, view onAppear에서 뷰모델에 넣어서 사용해도 되고,
//뷰모델에서 초기값으로 할당할 수도 있고.
//모델 stub으로 넣을 수도 있다.
//온보딩 화면에서는 데이터 노출만 있음. 비지니스 로직이 없다. 
class OnboardingViewModel: ObservableObject {
    @Published var onboardingContents: [OnboardingContent]
    
    
    init(onboardingContents: [OnboardingContent] = [
        .init(imageFileName: "onboarding_1", title: "오늘의 할일", subTitle: "To do list로 언제 어디서든 해야할일을 한눈에"),
        .init(imageFileName: "onboarding_2", title: "똑똑한 나만의 기록장", subTitle: "메모장으로 생각나는 기록은 언제든지"),
        .init(imageFileName: "onboarding_3", title: "하나라도 놓치지 않도록", subTitle: "음성메모 기능으로 놓치고 싶지않은 기록까지"),
            .init(imageFileName: "onboarding_4", title: "정확한 시간의 경과", subTitle: "타이머 기능으로 원하는 시간을 확인")]) {
        self.onboardingContents = onboardingContents
    }
}
