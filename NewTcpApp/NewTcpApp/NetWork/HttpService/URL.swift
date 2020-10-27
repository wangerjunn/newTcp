//
//  URL.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/3.
//  Copyright © 2017年 柴进. All rights reserved.
//

import Foundation
// t-gw.xslp.cn 
//MARK:----------------------初始化----------------------
//测试环境
//let kBASE_URL = "http://t-tcp.xs815.com/"
//内测环境
//let kBASE_URL = "http://ka.xslp.cn/"
//生产环境
let kBASE_URL = "http://tcp.xslp.cn/"

//融云App_key
let kRCIM_APPKEY = "sfci50a7sqloi" //正式环境
//let kRCIM_APPKEY = "qf3d5gbjqpxeh" //测试环境

//let host_url = "http://t-c-gw.xslp.cn/index.php?" //网络接口
let host_url = "http://api.xslp.com/index.php?" //网络接口 //正式
//let host_url = "http://192.168.1.100/" //网络接口 192.168.1.100


let data_Init = "index.php" //初始化数据

//MARK:----------------------群组相关----------------------

let group_Create = "tcp.group.create"   //创建群组
let group_Update = "tcp.group.update"   //修改群组
let group_SetOpen = "tcp.group.set_open" //设置群组是否开放
let group_Quit = "tcp.group.quit"       //退出群组
let group_Dismiss = "tcp.group.dismiss"  //解散群组
let group_UserList = "tcp.group.userList"  //群组成员
let group_DelUser = "tcp.group.del_user"  //删除群组成员
let group_MyGroupList = "tcp.group.myGroupList"  //获取加入的群组信息
let group_GetUserByIds = "tcp.group.getUserByIds"  //访问服务端获取用户信息
let group_Search = "tcp.group.search"  //搜索群组
let group_SetTop = "tcp.group.setTop"  //置顶
let group_Info = "tcp.group.info"  //获取群组信息
let group_InviteUser = "tcp.group.cloud_coach_invite"  //邀请加入群
let group_AcceptInvite = "tcp.group.accept"  //接收邀请加入
let group_RequestJoin = "tcp.group.requestJoin"  //主动加入
let group_JoinByQr = "tcp.group.join_by_qr"  //二维码加入
let group_JoinApply = "tcp.group.join_apply"  //入群申请
let group_JoinApplyAudit = "tcp.group.join_audit"  //批准入群申请
let group_JoinByCode = "tcp.group.join_by_code"  //使用验证码加入群
let group_Qr_code   = "tcp.group.qr_code"  //获取二维码
let group_JoinPublicGroup   = "tcp.group.join_public_group"  //加入公共群组


//MARK:----------------------话题相关----------------------

let group_SubjectList = "tcp.group.subject_list" //话题列表
let group_Create_subject = "tcp.group.create_subject" //创建话题
let group_Quit_subject = "tcp.group.quit_subject" //退出话题
let group_Subject_info = "tcp.group.subject_info" //话题信息
let group_Join_subject = "tcp.group.join_subject" //加入话题
let group_Finish_Online_Consult = "tcp.group.finish_online_consult" //结束辅导
let group_Update_subject = "tcp.group.update_subject" //修改话题
let group_Dismiss_subject = "tcp.group.dismiss_subject" //解散话题
let group_Forward_Subject = "tcp.group.forward_group_msg"//转推组群
let group_Subject_msg_history = "tcp.group.subject_msg_history"//查看话题历史记录


//MARK:----------------------用户管理相关----------------------




let im_GetToken = "tcp.im.get_token"  //获取token
let im_InitData = "tcp.im.sync"  //初始化数据
let im_UserInfo = "tcp.im.user_info"  //获取用户信息
let im_UserList = "tcp.im.user_list"  //获取多个用户信息
let im_Friends = "tcp.im.friends"  //获取好友列表
let im_Search_user = "tcp.im.search_user"  //查找用户
let im_Withdraw_message = "tcp.im.withdraw_message"  //撤回消息
let im_Coach_Search_User = "tcp.im.cloud_coach_search_user" //搜索部门/其它部门成员

