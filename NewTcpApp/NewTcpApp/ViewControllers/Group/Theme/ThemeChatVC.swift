//
//  ThemeChatVC.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/9.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class ThemeChatVC: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(click), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickshow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.frame = CGRect.init(x: 0, y: -49, width:kScreenW, height: kScreenH)
        self.view.backgroundColor = UIColor.white
        self.conversationMessageCollectionView.frame = CGRect.init(x: 0, y: 49+49, width: kScreenW, height: kScreenH-49-50-44)
        self.scrollToBottom(animated: false)
    }
    
    
    
    //MARK:----------------------键盘通知----------------------
    @objc func click(notification: NSNotification)
    {

        if self.chatSessionInputBarControl.frame.origin.y>kScreenH-49{
            self.view.frame = CGRect.init(x: 0, y: 0, width:kScreenW, height: kScreenH)
        }
        else
        {
            self.view.frame = CGRect.init(x: 0, y: -49, width:kScreenW, height: kScreenH)
            self.conversationMessageCollectionView.frame = CGRect.init(x: 0, y: 49+49, width: kScreenW, height: kScreenH-49-50-44)
        }


    }
    
    @objc func clickshow(notification: NSNotification)
    {
        self.view.backgroundColor = UIColor.groupTableViewBackground
        //MARK:----------------------暂时这么写 35  没明白这个高度----------------------
        self.view.frame = CGRect.init(x: 0, y: 0, width:kScreenW, height: kScreenH)
        self.conversationMessageCollectionView.frame = CGRect.init(x: 0, y: 49+49-35, width: kScreenW, height: kScreenH-49-50-44)
        self.scrollToBottom(animated: false)
    }
    
    override func didLongTouchMessageCell(_ model: RCMessageModel!, in view: UIView!) {
        
        let menu = CellMenuView.configWith(inview: view)
        menu.menuClickWithType(type: { (type) in
            print(type)
        })
    }
    
    
    
    /// 点击头像 响应事件
    ///
    /// - Parameter userId: <#userId description#>
    override func didTapCellPortrait(_ userId: String!) {
        
       print("点击了用户头像--用户id--"+userId)
    }
    
    
}


