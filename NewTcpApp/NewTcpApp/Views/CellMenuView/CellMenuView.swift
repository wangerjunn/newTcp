//
//  CellMenuView.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/9.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

//TODO:(harry标注)--类型还没填完全
enum MenuType {
    case MenuType_Copy
}

class CellMenuView: UIView {
   

  typealias clickBlock = (_ type:MenuType)->()
  fileprivate  var block : clickBlock?
    
    
   @objc fileprivate func click(notification: NSNotification)
    {
     self.removeFromSuperview()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
   
  fileprivate  override init(frame: CGRect) {
        super.init(frame: frame)
    
    NotificationCenter.default.addObserver(self, selector: #selector(click), name: UIMenuController.willHideMenuNotification, object: nil)
        
    }
    
    
    override var canBecomeFirstResponder: Bool
    {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        //        return true
        if action == #selector(copyClick1(item:)) || action == #selector(copyClick2(item:)) || action == #selector(copyClick3(item:))
        {
            return true
            
        }
        else
        {
            return false
        }
    }

    

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

//MARK: - ---------------------类内部私有方法----------------------
extension CellMenuView{

    fileprivate  func configItem(menu:UIMenuController) {
        
        let copy1 = UIMenuItem.init(title: "复制1", action: #selector(copyClick1(item:)))
        let copy2 = UIMenuItem.init(title: "复制1", action: #selector(copyClick2(item:)))
        let copy3 = UIMenuItem.init(title: "复制1", action: #selector(copyClick3(item:)))
        menu.menuItems = [copy1,copy2,copy3]
    }
}



//MARK: - ---------------------按钮点击响应方法----------------------
extension CellMenuView{
    
    @objc fileprivate func copyClick1(item:UIMenuItem) -> () {
        block?(MenuType.MenuType_Copy)
    }
    @objc fileprivate func copyClick2(item:UIMenuItem) -> () {
        block?(MenuType.MenuType_Copy)
    }
    @objc fileprivate func copyClick3(item:UIMenuItem) -> () {
        block?(MenuType.MenuType_Copy)
    }
}




//MARK: - ---------------------对外接口----------------------
extension CellMenuView{
    
    
    /// 初始化菜单
    ///
    /// - Parameter inview: 传入将要作为被处理的View
    /// - Returns: 返回CellMenuView 对象 用来做按钮点击后的回调用
    public static func configWith(inview:UIView)->(CellMenuView)
    {
        let myView = CellMenuView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        inview.addSubview(myView)
        myView.becomeFirstResponder()
        
        
        let menuVC = UIMenuController.shared
        myView.configItem(menu: menuVC)
        menuVC.setTargetRect(CGRect.init(x: 0, y: 0, width: 100, height: 30), in:inview )
        menuVC.setMenuVisible(true, animated: false)
        return myView
    }

    
    /// 菜单按钮点击回调闭包
    ///
    /// - Parameter type: 返回点击的类型
    public func menuClickWithType(type:@escaping clickBlock)
    {
        block = type
    }
}


