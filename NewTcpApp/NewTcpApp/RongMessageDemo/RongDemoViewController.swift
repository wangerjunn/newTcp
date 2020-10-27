//
//  RongDemoViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by 柴进 on 2017/3/1.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class RongDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        RCIM.shared().initWithAppKey("m7ua80gbm7bgm")
        
//        RCIM.shared().connect(withToken: "MjQqsfL9QMLYUd2X3XTT/1B2V+2Y3XGjyhArGfi6/pMfyDKJUVq0bT/evBgpGQxSXva54fobkQu8Ck4pHtVifw==", success: { (userId) in
//            print("登陆成功。当前登录的用户ID：\(userId)")
//            let rcb = RCConversationViewController.init(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: "2222")
//            DispatchQueue.main.async {
//                self.present(rcb!, animated: true, completion: nil)
//            }
//        }, error: { (status) in
//            print("登陆的错误码为:\(status)")
//        }) {
//            print("token错误")
//        }
        //2222
//        RCIM.shared().initWithAppKey("m7ua80gbm7bgm")
//        RCIM.shared().connect(withToken: "ymwQ4+vs5yrA+uFi3S1YZQuG3tBEDnpU3tFaQ1AXlymv+iOvift2KeE28gDsFOcjUHVfMMBayUBfOxUqEilUyA==", success: { (userId) in
//            print("登陆成功。当前登录的用户ID：\(userId)")
//            let rcb = RCConversationViewController.init(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: "1111")
//            DispatchQueue.main.async {
//                self.present(rcb!, animated: true, completion: nil)
//            }
//        }, error: { (status) in
//            print("登陆的错误码为:\(status)")
//        }) {
//            print("token错误")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
