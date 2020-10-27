//
//  TabNavgationVC.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/8.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class TabNavgationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
       let bar = UINavigationBar.appearance()
        bar.barTintColor = UIColor.black
        bar.tintColor = UIColor.white
        
        var attrs:[NSAttributedString.Key: AnyObject] = [:]
        
        attrs[NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)] = UIFont.systemFont(ofSize: 17)
        attrs[NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue)] = UIColor.white
        bar.titleTextAttributes = attrs
        

        
    }
    
    
   
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            
            let backBtn :UIButton = UIButton.init(type: .custom)
            backBtn.frame = CGRect.init(x: 0, y: 0, width: kNavBackWidth, height: kNavBackHeight)
            //        backBtn.setTitle("返回", for: .normal)
            backBtn.setImage(UIImage.init(named: "nav_back"), for: .normal)
            backBtn.sizeToFit()
            backBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: backBtn)
            viewController.navigationItem.leftBarButtonItem = barItem
            
        }
        super.pushViewController(viewController, animated: true)
    }
    
    
    @objc func btnClick()
    {
        if self.children.count>1 {
            if self.children[1] is TMTabbarController{
                let Tab:TMTabbarController = self.children[1] as! TMTabbarController
            let smak:SmallTalkVC = Tab.viewControllers?.first as! SmallTalkVC
            smak.clearInputText()
            }
            self.popViewController(animated: true)

        }
        else
        {
            let nav = self.tabBarController?.navigationController
            nav?.popViewController(animated: true)
            
        }
        
        
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
