//
//  BaseViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/2/28.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.configBackItem()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addAlertView(title:String, message:String, actionTitles:Array<String>,okAction: ((UIAlertAction) -> Void)?, cancleAction: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        for (index,actionTitle) in actionTitles.enumerated() {
            if index == 0 {
                alertController.addAction(UIAlertAction.init(title: actionTitle, style: .default, handler: { (action) in
                    okAction!(action)
                }))
            }
            if index > 0 && index == actionTitles.count - 1 {
                alertController.addAction(UIAlertAction.init(title: actionTitle, style: .cancel, handler: { (action) in
                    cancleAction!(action)
                }))
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    //通过类名返回一个AnyClass
    func getClassWitnClassName(_ name:String) ->AnyClass?{
        let type = getBundleName() + "." + name
        return NSClassFromString(type)
    }
    
    //获取工程的名字
    func getBundleName() -> String{
        var bundlePath = Bundle.main.bundlePath
        bundlePath = bundlePath.components(separatedBy: "/").last!
        bundlePath = bundlePath.components(separatedBy: ".").first!
        return bundlePath
    }

}
