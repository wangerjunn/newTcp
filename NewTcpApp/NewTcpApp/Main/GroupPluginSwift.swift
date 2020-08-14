//
//  GroupPluginSwift.swift
//  GroupChatPlungSwiftPro
//
//  Created by 柴进 on 2017/3/24.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class GroupPluginSwift: NSObject {
    @objc class func initWithToken(token:String , next:@escaping ()->()) {
        
        RCIM.shared().initWithAppKey("qf3d5gbjqpxeh")
        
        UserRequest.getToken(params: ["app_token":token], hadToast: true, fail: { (error) in
            print(error)
        }) { (dis) in
            print(dis)
            
            if let code = dis["code"] {
                if "\(code)" != "1" {
                   print("\(dis["msg"] ?? ""):\(code)")
                   return
                }
            }
           
            sharePublicDataSingle.publicData.userid = dis["userid"] as! String
            sharePublicDataSingle.publicData.avater = dis["avater"] as! String
            sharePublicDataSingle.publicData.corpid = dis["corpid"] is NSNumber ? (dis["corpid"] as! NSNumber).stringValue : dis["corpid"] as! String
            sharePublicDataSingle.publicData.realname = dis["realname"] as! String
            sharePublicDataSingle.publicData.access_token = dis["access_token"] as! String
            sharePublicDataSingle.publicData.im_token = dis["im_token"] as! String
            sharePublicDataSingle.token = token as NSString
            DataBaseOperation.initDataBase()
            
            UserRequest.initData(params: ["app_token":token,"updatetime":"0"], hadToast: true, fail: { (error) in
//                print(error)
            }, success: { (dic) in
//                print(dic)
                RCIM.shared().connect(withToken: sharePublicDataSingle.publicData.im_token, success: { (userId) in
                    print("登陆成功。当前登录的用户ID：\(String(describing: userId))")
                    next()
                }, error: { (status) in
                    print("登陆的错误码为:\(status)")
                }) {
                    print("token错误")
                }
            })
//            UserRequest.friends(params: ["app_token":token], hadToast: true, fail: { (error) in
//                print(error)
//            }, success: { (dic) in
//                print(dic)
//            })
        }
    }
    
   @objc class func logout(){
        RCIM.shared().logout()
    }

}
