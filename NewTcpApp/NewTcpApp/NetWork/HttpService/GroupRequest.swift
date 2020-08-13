//
//  GroupRequest.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/3.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

//关于群组相关的请求

class GroupRequest: BaseRequest {

    
    /// 入群申请
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token groupid:群组ID msg:申请说明
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func groupJoinApply(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_JoinApply), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }
    
    /// 批准入群申请
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token applyid:申请ID status:审核结果（1:同意入群;2:拒绝入群）
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func groupJoinApplyAudit(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_JoinApplyAudit), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }
    
    /// 使用验证码加入群组
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token groupid:群组ID auth_code:群组验证码
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func groupJoinByCode(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_JoinByCode), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }
    
    /// 扫描二维码加入群组
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token groupid:群组ID verify_code:群组验证码
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func groupJoinByQr(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_JoinByQr), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    /// 创建群组
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func creat(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_Create), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
        
//        self.basePost(url: "", params: params, hadToast: hadToast, fail: fail, success: success);
    }
    
    
    
    
    /// 修改群组
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token groupid:群组ID group_name:群组名称
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func update(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_Update), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    /// 是否开放
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token groupid:群组ID is_open:公开状态（0不公开，1公开）
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func setOpen(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_SetOpen), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 退出群组
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token groupid:群组ID
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func quit(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_Quit), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 解散群组
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token groupid:群组ID
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回{"code":1,"msg":"","data":null}
    public static func dismiss(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
         self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_Dismiss), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 群组成员
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func userList(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: "", params: params, hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 删除群组成员
    ///
    /// - Parameters:
    ///   - params: 请求参数 appToken:App登录Token groupId:群组ID userIdStr:删除的用户ID（,分割）
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func delUser(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_DelUser), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 获取加入群组
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func myGroupList(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: "", params: params, hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 访问服务端获取用户信息

    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func getUserByIds(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: "", params: params, hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 搜索群组
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func search(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_Search), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 置顶群组
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func setTop(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: "", params: params, hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 获取群组信息
    ///
    /// - Parameters:
    ///   - params: 请求参数  app_token:App登录Token groupid:群组ID
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func info(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_Info), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 邀请加入
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token groupid:群组ID userid_str:邀请用户ID字符串（,分割）
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func inviteUser(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_InviteUser), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 接受邀请加入
    ///
    /// - Parameters:
    ///   - params: 请求参数 app_token:App登录Token inviteid:邀请ID
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func acceptInvite(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        //group_AcceptInvite
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_AcceptInvite), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 主动加入
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func requestJoin(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: "", params: params, hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 验证码加入
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func joinByAuthCode(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: "", params: params, hadToast: hadToast, fail: fail, success: success);
    }

    
    
    /// 二维码加入
    ///
    /// - Parameters:
    ///   - params: 请求参数
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func join(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: "", params: params, hadToast: hadToast, fail: fail, success: success);
    }

    /// 获取二维码
    ///
    /// - Parameters:
    ///   - params: 请求参数 appToken:App登录Token groupId:群组ID authCode:群组验证码
    ///   - hadToast: 是否提醒
    ///   - fail: 失败返回
    ///   - success: 成功返回
    public static func getQrCode(params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
        self.basePost(url: SignTool.getSignUrlNotoken(params: params, methodName: group_Qr_code), params: ["param_json":SignTool.makeJsonStrWith(object: params)], hadToast: hadToast, fail: fail, success: success);
    }

    
    
}
