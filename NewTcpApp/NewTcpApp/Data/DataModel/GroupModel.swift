//
//  GroupModel.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/1.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

//群组表

class GroupModel: BaseRealMModel {
    @objc dynamic var is_open = ""    // 是否开放（0:私有;1:公开）
    @objc dynamic var user_max = ""   // 用户上限
    @objc dynamic var group_name = "" // 群组名
    @objc dynamic var owner_id = ""   // 群主用户ID
    @objc dynamic var groupid = ""    // 群组ID
    @objc dynamic var user_num = ""   // 用户数
    @objc dynamic var qr_url = ""     // 二维码
    @objc dynamic var auth_code = ""  // 验证码
    @objc dynamic var corpid = ""
    @objc dynamic var inputtime = ""
    @objc dynamic var icon_url = ""
    @objc dynamic var is_delete = ""
    @objc dynamic var updatetime = ""
    
    override static func primaryKey()->String
    {
        return "groupid";
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
