//
//  UIViewController+Extension.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/15.
//  Copyright © 2017年 柴进. All rights reserved.
//

import Foundation

extension UIViewController {

     /// 设置导航栏右侧按钮
     ///
     /// - Parameter items: 导航栏右侧按钮按从右往左的顺序,文字按钮直接传string类型,图片按钮需要传入UIImage类型
     func setRightBtnWithArray<T>(items:[T]){
    
        var itemArr = [UIBarButtonItem]()
        for i in 0..<items.count {
            
            let btn = UIButton.init()
            btn.tag = 1000 + i
            let item = items[i]
            if item is String {
                btn.titleLabel?.font = FONT_16
                btn.setTitle(item as? String, for: .normal)
            }
            if item is UIImage {
                btn.setImage(item as? UIImage, for: .normal)
            }
            btn.sizeToFit()
            btn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
            let barButtonItem = UIBarButtonItem.init(customView: btn)
            itemArr.append(barButtonItem)
        }
        self.navigationItem.rightBarButtonItems = itemArr
    }

    /// 导航栏右侧按钮点击事件,在需要监听方法的控制器中重写这个方法
    ///
     // - Parameter button: 通过按钮的tag值判断点击的是哪一个,tag值从1000开始
    @objc func rightBtnClick(button:UIButton) {
        
    }
    
    
    func showAlert(content:String) {
       let alert = UIAlertController(title: "提示", message: content, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
