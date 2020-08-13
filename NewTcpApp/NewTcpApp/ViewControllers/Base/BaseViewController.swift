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
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.hexString(hexString: "333333")
        //修改导航栏按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
