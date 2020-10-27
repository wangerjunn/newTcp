//
//  GroupPluginSwift.swift
//  GroupChatPlungSwiftPro
//
//  Created by 柴进 on 2017/3/24.
//  Copyright © 2017年 柴进. All rights reserved.
//

let kACCESS_TOKEN = "access_token"
let kIM_TOKEN = "im_token"

import UIKit

class GroupPluginSwift: NSObject {
    @objc class func initWithToken(token:String , next:@escaping (_ dic:NSDictionary)->()) {
        
        RCIM.shared().initWithAppKey(kRCIM_APPKEY)//正式
        sharePublicDataSingle.token = token as NSString;
        UserRequest.getToken(params: ["app_token":token], hadToast: true, fail: { (error) in
            print(error)
        }) { (dis) in
//            print(dis)
            sharePublicDataSingle.publicData.userid = dis["userid"] as! String
            sharePublicDataSingle.publicData.avater = dis["avater"] as! String
            sharePublicDataSingle.publicData.corpid = dis["corpid"] is NSNumber ? (dis["corpid"] as! NSNumber).stringValue : dis["corpid"] as! String
            sharePublicDataSingle.publicData.realname = dis["realname"] as! String
            sharePublicDataSingle.publicData.access_token = dis["access_token"] as! String
            sharePublicDataSingle.publicData.im_token = dis["im_token"] as! String
            sharePublicDataSingle.publicData.im_userid = dis["im_userid"] as! String
//            UserDefaults.standard.setValue(sharePublicDataSingle
//                                            .token, forKey: kACCESS_TOKEN)
//            UserDefaults.standard.setValue(sharePublicDataSingle.publicData
//                                            .im_token, forKey: kIM_TOKEN)
//            UserDefaults.standard.synchronize()
            DataBaseOperation.initDataBase()
            sharePublicDataSingle.startGetMessageNot()
            
            
            let username:String = sharePublicDataSingle.publicData.userid + sharePublicDataSingle.publicData.corpid
            let getRemote:Bool? = UserDefaults.standard.object(forKey: getRemoteKey + username) as! Bool?
            if getRemote == nil {
                UserDefaults.standard.set(true, forKey: getRemoteKey + username)
            }
            var time:String? = (UserDefaults.standard.object(forKey: username) as? String)
            
            if (time == nil ){
               time = "0"
            }
//            if UserModel.allObjects().count == 0 {
//                UserDefaults.standard.set("0", forKey: username)
//                time = "0"
//            }
            
            UserRequest.initData(params: ["app_token":token,"updatetime":time!], hadToast: true, fail: { (error) in
//                print(error)
            }, success: { (dic) in
//                print(dic)
                RCIM.shared().logout()
                
                RCIM.shared()?.connect(withToken: sharePublicDataSingle.publicData.im_token, dbOpened: { (errorCode) in
                    
                }, success: { (userId) in
                    print("登陆成功。当前登录的用户ID：\(String(describing: userId))")
                    next(NSDictionary.init(dictionaryLiteral: ("code", "1")))
                }, error: { (status) in
                    print("登陆的错误码为:\(status)")
                })
                //本地后台通知
//                RCIM.shared().disableMessageNotificaiton = true
                RCIM.shared().disableMessageAlertSound = true
                RCCall.shared()
            })
//            UserRequest.friends(params: ["app_token":token], hadToast: true, fail: { (error) in
//                print(error)
//            }, success: { (dic) in
//                print(dic)
//            })
        }
    }

    class func open(token:String , next:@escaping (_ dic:NSDictionary)->()) {
//        BaseNavigationController * nav = [[BaseNavigationController alloc] init];
//        UIViewController * vc = [[GroupListViewController alloc] init];
//        [nav addChildViewController:vc];
//        [self.viewController presentViewController:nav animated:YES completion:nil];
//        let nav = BaseNavigationController.init()
//        nav.addChildViewController(GroupListViewController.init())
        
    }
    
    class func logout(){
        RCIM.shared().logout()
    }

}



