//
//  UserListModel.swift
//  NewTcpApp
//
//  Created by xslp on 2020/8/5.
//  Copyright © 2020 xslpiOS. All rights reserved.
//

import UIKit

class UserListModel: BaseRealMModel {

    @objc dynamic var userid = ""    // 用户ID
    @objc dynamic var realname = "" // 昵称
    @objc dynamic var avater = "" // 头像
    @objc dynamic var im_userid = "" // im-id
    @objc dynamic var updatetime = "" // 更新时间
    @objc dynamic var is_delete = "" // 是否删除
    override static func primaryKey()->String?
    {
        return "userid";
    }
}
