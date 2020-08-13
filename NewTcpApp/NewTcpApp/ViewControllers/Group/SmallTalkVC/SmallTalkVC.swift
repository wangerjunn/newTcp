//
//  SmallTalkVC.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/9.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class SmallTalkVC: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayUserNameInCell = true
        RCIM.shared()?.globalMessageAvatarStyle = .USER_AVATAR_CYCLE
        NotificationCenter.default.addObserver(self, selector: #selector(click), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickshow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let predicate = NSPredicate.init(format: "groupid == %@", argumentArray: [self.targetId ?? ""])
        let allModels = GroupModel.objects(with: predicate)
        if allModels.count > 0 {
            let gModel:GroupModel = allModels.firstObject() as! GroupModel
            if gModel != nil {
                self.tabBarController?.title = gModel.group_name
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.frame = CGRect.init(x: 0, y: -49, width:kScreenW, height: kScreenH)
        self.view.backgroundColor = UIColor.white
        self.conversationMessageCollectionView.frame = CGRect.init(x: 0, y: 49, width: kScreenW, height: kScreenH-49-49)
        self.scrollToBottom(animated: false)
        refreshUserInfoOrGroupInfo()
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
        }

       
    }
    
    @objc func clickshow(notification: NSNotification)
    {
        self.view.frame = CGRect.init(x: 0, y: 0, width:kScreenW, height: kScreenH)
    }

    
    /// 点击头像 响应事件
    ///
    /// - Parameter userId: <#userId description#>
    override func didTapCellPortrait(_ userId: String!) {
        
        print("点击了用户头像--用户id--"+userId)
    }
    
    
    
    /// 刷新用户信息 做头像  名称的刷新
    func  refreshUserInfoOrGroupInfo(){
    
        
        if self.conversationType == .ConversationType_GROUP {
            let predicate = NSPredicate.init(format: "groupid == %@", argumentArray: [self.targetId])
            let groupUser =  GroupUserModel.objects(with: predicate)
            if groupUser.count < 1 {
                return
            }
            for i in 0...groupUser.count-1 {
                    let gModel:GroupUserModel = groupUser.object(at: i) as! GroupUserModel
                    let userModel = RCUserInfo.init()
                    userModel.userId = gModel.userid
                    userModel.name = gModel.realname
                    if gModel.avater.isEmpty {
                        userModel.portraitUri = "mine_avatar"
                    } else {
                        userModel.portraitUri = gModel.avater
                    }
                    
                    RCIM.shared().refreshUserInfoCache(userModel, withUserId: userModel.userId)
            }
            
            
        }

     }
}
