//
//  FriendsModel.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/3.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

//好友表

class FriendsModel: BaseRealMModel {
    
    @objc dynamic var userid = ""    // 用户ID
    @objc dynamic var realname = "" // 昵称
    @objc dynamic var avater = "" // 头像
    @objc dynamic var type:NSNumber = 0//1 互粉  2单粉我
    @objc dynamic var im_userid = "" // im-id
    @objc dynamic var updatetime = "" // 更新时间
    @objc dynamic var is_delete = "" // 是否删除
    override static func primaryKey() -> String?
    {
        return "userid";
    }

}
