//
//  PrivateUserModel.swift
//  GroupChatPlungSwiftPro
//
//  Created by 柴进 on 2018/2/13.
//  Copyright © 2018年 柴进. All rights reserved.
//

import UIKit

class PrivateUserModel: BaseRealMModel {
    @objc dynamic var id = ""
    override static func primaryKey()->String
    {
        return "id";
    }
}
