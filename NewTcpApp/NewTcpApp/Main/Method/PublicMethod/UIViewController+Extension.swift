//
//  UIViewController+Extension.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/15.
//  Copyright © 2017年 柴进. All rights reserved.
//

import Foundation


extension UIView{
    
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    /// 最右边x的值
    var max_X:CGFloat{
        get {
            return self.x + self.width
        }
    }
    ///最低端x的值
    var max_Y:CGFloat{
        get {
            return self.y + self.height
        }
    }
    
}



extension UIViewController {

    // MARK: - 注册自定义消息
    func registerCustomerMessageContent(){
        RCIM.shared().registerMessageType(ThemeMessageContent.self)
        RCIM.shared().registerMessageType(HistoryMessageContent.self)
        RCIM.shared().registerMessageType(ProjectVoiceMessageContent.self)
//        RCIM.shared().registerMessageType(ProjectReportMessageContent.self)
    }
    
    
    class func appRootViewController() -> UIViewController
    {
        
        let appRootVC = UIApplication.shared.keyWindow?.rootViewController
        var topVC = appRootVC
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController;
        }
        return topVC!;
    }
    class func appCurrentViewController() -> UIViewController
    {
        let vc = self.appRootViewController()
        if (vc is UITabBarController) {
            let nav = (vc as! UITabBarController).selectedViewController as? UINavigationController
            while ((nav?.topViewController?.presentedViewController) != nil) {
                return (nav!.topViewController?.presentedViewController)!;
            }
            return nav!.topViewController!;
        }else{
            return vc;
        }
    }
    class func appChildViewController() -> UIViewController
    {
        let appRootVC = UIApplication.shared.keyWindow?.rootViewController
        var topVC = appRootVC;
        while (topVC?.children.count != 0) {
            if (topVC is UITabBarController) {
                topVC = (topVC as! UITabBarController).selectedViewController
            }else if (topVC is UINavigationController){
                topVC = (topVC as! UINavigationController).topViewController
            }else{
                print("出错了！！")
                break;
            }
        }
        return topVC!;
    }
    
    
    
    
    
    
    
    
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
    /// - Parameter button: 通过按钮的tag值判断点击的是哪一个,tag值从1000开始
    @objc func rightBtnClick(button:UIButton) {
        
    }
    
    
    
    /// 对导航颜色做修改
    func configNav(){
    
        let bar = UINavigationBar.appearance()
        bar.barTintColor = UIColor.black
        bar.tintColor = UIColor.white
            var attrs = [NSAttributedString.Key : AnyObject]()
            attrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17)
            attrs[NSAttributedString.Key.foregroundColor] = UIColor.white
        bar.titleTextAttributes = attrs
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
    
    }
    
    
    /// 显示加载状态
    func progressShow(){
       self.configSVP()
       SVProgressHUD.show()
    }
    /// 显示加载状态
    func progressShowWith(str:String){
        self.configSVP()
        SVProgressHUD.show(withStatus: str)
    }
    /// 取消
    func progressDismiss(){
       SVProgressHUD.dismiss()
    }
    
    /// 取消
    func progressDismissWith(str:String){
        SVProgressHUD.showError(withStatus: str)
        SVProgressHUD.dismiss(withDelay: 0.5)
    }

    /// 配置SVP
    func configSVP(){
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)
        SVProgressHUD.setForegroundColor(UIColor.white)
    }
    
    
    
    /// 应酬tab
    ///
    /// - Parameter isHidden: <#isHidden description#>
    func isHiddeTab(isHidden:Bool){
        
        if self.tabBarController == nil {
            return;
        }
        
        if (self.tabBarController?.isKind(of: TMTabbarController.self))! {
            
            let tab:TMTabbarController = self.tabBarController as! TMTabbarController
            tab.isHiddenTab(isHidden: isHidden)
        }
        
    }

    
    /// 清除tab红点提示
    func clearTabRedPoint(){
    
        
        
        var tab:TMTabbarController?
        
        for vc in (self.navigationController?.children)! {
            
            if vc.isKind(of: TMTabbarController.self) {
                tab = vc as! TMTabbarController
            }
        }
        
        guard tab != nil else {
            return
        }
        
            tab?.clearRedPoint()
        
        
    }
    
    
    /// 显示tab红点提示(在主题聊天界面调用)
    func showTabRedPoint(){
        
        
        
        var tab:TMTabbarController?
        
        for vc in (self.navigationController?.children)! {
            
            if vc.isKind(of: TMTabbarController.self) {
                tab = vc as! TMTabbarController
            }
        }
        
        guard tab != nil else {
            return
        }
        
       tab?.showRedPoint(type: 1)
        
        
    }

    
    
    
    
    /// 显示红点提醒
    ///
    /// - Parameter type: <#type description#>
    func showRedRemind(type:Int){
        if self.tabBarController == nil {
            return;
        }
        
        
        if (self.tabBarController?.isKind(of: TMTabbarController.self))! {
          
            let tab:TMTabbarController = self.tabBarController as! TMTabbarController
            tab.showRedPoint(type: 1)
        }
    }
    
    
    
    
    func configBackItem(){
    
        let backBtn :UIButton = UIButton.init(type: .custom)
        backBtn.frame = CGRect.init(x: -5, y: 0, width: kNavBackWidth, height: kNavBackHeight)
        //        backBtn.setTitle("返回", for: .normal)
        backBtn.setImage(UIImage.init(named: "nav_back"), for: .normal)
        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        let barItem :UIBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.leftBarButtonItem = barItem

    
    }
    
    
    @objc func backBtnClick()
    {
        if self is TMTabbarController {
            ((self as! TMTabbarController).viewControllers?.first as! SmallTalkVC).clearInputText()
        }
        self.navigationController?.popViewController(animated: true)
//        if self.childViewControllers.count>1 {
//            self.popViewController(animated: true)
//        }
//        else
//        {
//            let nav = self.tabBarController?.navigationController
//            nav?.popViewController(animated: true)
//            
//        }
        
        
    }

    
}
