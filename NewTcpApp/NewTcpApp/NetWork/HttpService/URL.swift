//
//  URL.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/3.
//  Copyright © 2017年 柴进. All rights reserved.
//

import Foundation

//MARK:----------------------初始化----------------------
//http://t-gw.xslp.cn" else "
let host_url = "http://t-gw.xslp.cn/index.php?" //网络接口
//let host_url = "https://api.xslp.com/index.php?" //网络接口
let data_Init = "index.php" //初始化数据

//MARK:----------------------群组相关----------------------

let group_Create = "tcp.group.create"   //创建群组
let group_Update = "tcp.group.update"   //修改群组
let group_SetOpen = "tcp.group.set_open" //设置群组是否开放
let group_Quit = "tcp.group.quit"       //退出群组
let group_Dismiss = "tcp.group.dismiss"  //解散群组
let group_UserList = "tcp.group.userList"  //群组成员
let group_DelUser = "tcp.group.delUser"  //删除群组成员
let group_MyGroupList = "tcp.group.myGroupList"  //获取加入的群组信息
let group_GetUserByIds = "tcp.group.getUserByIds"  //访问服务端获取用户信息
let group_Search = "tcp.group.search"  //搜索群组
let group_SetTop = "tcp.group.setTop"  //置顶
let group_Info = "tcp.group.info"  //获取群组信息
let group_InviteUser = "tcp.group.invite"  //邀请加入
let group_AcceptInvite = "tcp.group.accept"  //接收邀请加入
let group_RequestJoin = "tcp.group.requestJoin"  //主动加入
let group_JoinByQr = "tcp.group.join_by_qr"  //二维码加入
let group_JoinApply = "tcp.group.join_apply"  //入群申请
let group_JoinApplyAudit = "tcp.group.join_audit"  //批准入群申请
let group_JoinByCode = "tcp.group.join_by_code"  //使用验证码加入群
let group_Qr_code   = "tcp.group.qr_code"  //获取二维码




//MARK:----------------------用户管理相关----------------------




let im_GetToken = "tcp.im.get_token"  //获取token
let im_InitData = "tcp.im.sync"  //初始化数据
let im_UserInfo = "tcp.im.user_info"  //获取用户信息
let im_UserList = "tcp.im.user_list"  //获取多个用户信息
let im_Friends = "tcp.im.friends"  //获取好友列表
let im_Coach_Search_User = "tcp.im.cloud_coach_search_user" //搜索部门/其它部门成员
