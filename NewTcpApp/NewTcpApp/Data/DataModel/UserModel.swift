//
//  UserModel.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/7/24.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class UserModel: BaseRealMModel {

    @objc dynamic var userid = ""    // 用户ID
    @objc dynamic var corpid = "0" // 企业ID
    @objc dynamic var realname = "" // 昵称
    @objc dynamic var avater = "" // 头像
    @objc dynamic var updatetime = "" // 更新时间
    @objc dynamic var is_delete = "" // 是否删除
    @objc dynamic var im_userid = ""
    @objc override static func primaryKey()->String?
    {
        return "userid";
    }

}
