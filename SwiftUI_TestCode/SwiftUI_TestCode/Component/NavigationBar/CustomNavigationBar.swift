//
//  CustomNavigationBar.swift
//  SwiftUI_TestCode
//
//  Created by kimsoomin_mac2022 on 2/28/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    let hasLeftBtn: Bool //back
    let hasRightBtn: Bool
    let leftBtnAction: () -> Void
    let rightBtnAction: () -> Void
    let naviType: NavigationBtnType
    
    init(hasLeftBtn: Bool = true, hasRightBtn: Bool = true , leftBtnAction: @escaping () -> Void = {}, rightBtnAction: @escaping () -> Void = {}, naviType: NavigationBtnType = .close) {
        self.hasLeftBtn = hasLeftBtn
        self.hasRightBtn = hasRightBtn
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
        self.naviType = naviType
    }
    
    var body: some View {
        HStack{
            if hasLeftBtn {
                Button(action: leftBtnAction, label: {
                    Image("leftArrow")
                })
            }
            Spacer()
            
            if hasRightBtn {
                Button(action: rightBtnAction, label: {
                    if naviType == .close {
                        Image("close")
                    }else {
                        Text(naviType.rawValue)
                            .foregroundColor(.black)
                    }
                })
            }
        }.padding(.horizontal,20)
            .frame(height: 20)
    }
}

#Preview {
    CustomNavigationBar()
}
