//
//  ApplyJoinGroupTextView.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/16.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class ApplyJoinGroupTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
        self.font = FONT_14
        self.textColor = UIColor.black
        self.layer.cornerRadius = 3
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.textContainerInset = UIEdgeInsets(top: 12, left: 5, bottom: 0, right: 0)
        self.addSubview(placeholderLabel)
        self.addSubview(textLengthLabel)
        placeholderLabel.text = placeholder
        placeholderLabel.mas_makeConstraints { (make) in
            make!.top.equalTo()(12)
            make!.left.equalTo()(10)
        }
        textLengthLabel.mas_makeConstraints { (make) in
            make!.top.equalTo()(inputTV_height_MAX - 20)
            make!.left.equalTo()(frame.size.width - 40 - 10)
            make!.width.equalTo()(40)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var placeholder : String?{
    
        didSet{
            placeholderLabel.text = placeholder
            if (placeholder?.contains("附加信息"))! {
                textLengthLabel.isHidden = false
                textLengthLabel.text = "0/30"
            }else{
                textLengthLabel.isHidden = true
            }
        }
    }
    
    lazy var placeholderLabel: UILabel = {
        var placeholderLabel = UILabel.init()
        placeholderLabel.font = FONT_14
        placeholderLabel.textColor = UIColor.lightGray
        return placeholderLabel
    }()
    
    lazy var textLengthLabel: UILabel = {
        var textLengthLabel = UILabel.init()
        textLengthLabel.font = FONT_14
        textLengthLabel.textColor = UIColor.lightGray
        textLengthLabel.textAlignment = .right
        textLengthLabel.text = "0/30"
        return textLengthLabel
    }()
}

extension ApplyJoinGroupTextView : UITextViewDelegate{

    func textViewDidChange(_ textView: UITextView) {
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var str = textView.text?.replacingCharacters(in: (textView.text?.changeToRange(from: range)!)!, with: text)
        if (str?.count)! > 0 {
            placeholderLabel.isHidden = true
        }else{
            placeholderLabel.isHidden = false
        }

        if (str?.count)! > 30 {
            textView.text = str?.substring(to: (str?.index((str?.startIndex)!, offsetBy: 30))!)
            textLengthLabel.text = "30/30"
            return false
        }
        textLengthLabel.text = "\((str?.count)!)/30"
        return true

    }
}
