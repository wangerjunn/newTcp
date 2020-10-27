//
//  UILabel+Extension.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/7/13.
//  Copyright © 2017年 柴进. All rights reserved.
//

import Foundation

extension UILabel {

    func changeLineSpace(text: String, space: CGFloat){
    
        let attributedString = NSMutableAttributedString.init(string: text)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.count))
        self.attributedText = attributedString
        self.sizeToFit()
    }

}
