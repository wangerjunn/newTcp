//
//  UserRequest.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/3.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

//用户管理相关

class UserRequest: BaseRequest {

    /// 获取用户Token
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func getToken(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ fail:Dictionary<String, Any>) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: im_GetToken), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
//        self.basePost(url: data_Init, params: params, hadToast: hadToast, fail: fail, success: success);
    }
    
    
    /// 获取初始化数据
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func initData(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ fail:Dictionary<String, Any>) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        
        if sharePublicDataSingle.updateTime == (params["updatetime"] as! String) {
            sharePublicDataSingle.addSuccesB(success: success)
            print("addSucc:\(sharePublicDataSingle.successNum)")
            return
        }else{
            sharePublicDataSingle.updateTime = (params["updatetime"] as! String)
//            sharePublicDataSingle.successList.removeAll()
//            sharePublicDataSingle.successB = nil
            sharePublicDataSingle.addSuccesB(success: success)
            
            print("NewSucc:\(sharePublicDataSingle.successNum)")
        }
        print("NewSuccB:\(sharePublicDataSingle.successB == nil) \n \(params)")
        if sharePublicDataSingle.successB == nil {
            UserRequest.initData(params: params, hadToast: hadToast, fail: fail, success: success)
            return
        }else{
            self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: im_InitData), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: DataOperation.saveInitData(success: sharePublicDataSingle.successB!));
        }
        //        self.basePost(url: data_Init, params: params, hadToast: hadToast, fail: fail, success: success);
    }
    
    
    /// 获取用户信息
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func userInfo(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ fail:Dictionary<String, Any>) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: im_UserInfo), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }
    
    
    
    
    /// 获取用户信息列表
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func userList(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ fail:Dictionary<String, Any>) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrl(params: params, methodName: im_UserList), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }
    
    /// 获取好友列表
    ///
    /// - Parameters:
    ///   - params: 请求参数  app_token:App登录Token
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func friends(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ fail:Dictionary<String, Any>) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: im_Friends), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: DataOperation.saveFriendsData(success: success));
    }
    /// 查找用户
    ///
    /// - Parameters:
    ///   - params: 请求参数  app_token:App登录Token keyword:关键词（匹配用户名、邮箱、手机)
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func searchUser(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ fail:Dictionary<String, Any>) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: im_Search_user), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: DataOperation.saveFriendsData(success: success))
    }
    /// 撤回消息
    ///
    /// - Parameters:
    ///   - params: 请求参数  app_token:App登录Token msg_uid:融云消息ID  groupid:群组/话题ID
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func withdraw_message(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ fail:Dictionary<String, Any>) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: im_Withdraw_message), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success)
    }
    
    
    // 获取部门/其他部分成员
    ///
    /// - Parameters:
    ///   - params: 请求参数  app_token:App登录Token
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func coachSearchUser(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ fail:Dictionary<String, Any>) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: im_Coach_Search_User), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success)
    }

}
