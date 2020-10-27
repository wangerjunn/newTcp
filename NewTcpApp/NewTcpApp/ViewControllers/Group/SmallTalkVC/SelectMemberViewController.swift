//
//  SelectMemberViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 2018/1/15.
//  Copyright © 2018年 柴进. All rights reserved.
//

import UIKit

class SelectMemberViewController: RCCallSelectMemberViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "选择联系人"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(rightButtonClick))
        //融云页面样式问题修改
        for subView in self.view.subviews {
            if subView.isKind(of: UINavigationBar.self){
                subView.frame = CGRect.init(x: 0, y: 20, width: self.view.frame.size.width, height: 44)
                (subView as! UINavigationBar).isTranslucent = false
                (subView as! UINavigationBar).barTintColor = UIColor.hexString(hexString: "262e42")
            }
        }
    }

    
    @objc func rightButtonClick() {
        self.done()
    }
}
