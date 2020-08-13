//
//  TMTabbarController.swift
//  TMSwiftLearn
//
//  Created by harry on 17/2/7.
//  Copyright © 2017年 timer. All rights reserved.
//

import UIKit



//tabbar高度
let kTabBarHeight :Float = 49;
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height



class TMTabbarController: UITabBarController
{
    
    var currentBtn:TMTabbarButton?
    var groupModel:RCConversationModel?{
    
        didSet {
            creatChildViewControllers()
        }
    }
    
    lazy var titleArray:[String] =
    {
//       let array = ["闲聊","主题","文件","公告"]
        let array = ["闲聊","公告"]
       return array
    
    }()
    
//    lazy var vcArray:[String] =
//        {
//            let array = ["ViewController","ViewController","ViewController","ViewController"]
//            return array
//            
//    }()
    
    lazy var imageNomalArray:[String] =
    {
            let array = ["tab_main_normal","tab_main_normal","tab_main_normal","tab_main_normal","tab_main_normal"]
            return array
            
    }()
    
    
    lazy var imageSelectArray:[String] =
        {
            let array = ["tab_main_selected","tab_main_selected","tab_main_selected","tab_main_selected","tab_main_selected"]
            return array
            
    }()
    
    
    
    lazy var bgImageView :UIImageView =
        {
            let img = UIImageView(image: UIImage(named: "find_radio_default"))
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true
            img.isUserInteractionEnabled = true
            return img
            
    }()
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tabBar.isHidden = true
        creatTab()
        self.setRightBtnWithArray(items: [UIImage.init(named: "nav_groupSetting")])

//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//         self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func rightBtnClick(button: UIButton) {
        let groupSettingVC : GroupSettingViewController = GroupSettingViewController()
        groupSettingVC.conversationModel = groupModel
        self.navigationController?.pushViewController(groupSettingVC, animated: true)
    }
    
}

extension TMTabbarController
{
    
    /// 创建tab
    func creatTab()
    {
        bgImageView.frame = CGRect(x: 0, y: kScreenH - 49, width: kScreenW, height: 49)
        bgImageView.backgroundColor = UIColor.black
        self.view.addSubview(bgImageView)
    }
    
    
    //MARK: 创建子控制器
    func creatChildViewControllers ()
    {
        for index  in 0...titleArray.count-1
        {
           
//           let aClass = getClassWitnClassName(vcArray[index]) as! UIViewController.Type
//           let vc:UIViewController = aClass.init()
//          let nav = TabNavgationVC.init(rootViewController: vc)
//          vc.tabBarItem.title = titleArray[index]
//          vc.tabBarItem.image = UIImage(named:imageNomalArray[index])
//          vc.tabBarItem.selectedImage = UIImage(named:imageSelectArray[index])
//          vc.title = titleArray[index]
//           addChildViewController(nav)
            
           
            var cuVC :UIViewController?
            
            
            switch index {
            case 0:
                
                let vc = SmallTalkVC(conversationType: (groupModel?.conversationType)!, targetId: groupModel?.targetId)
//                let nav = TabNavgationVC.init(rootViewController: vc!)
                          vc?.tabBarItem.title = titleArray[index]
                          vc?.tabBarItem.image = UIImage(named:imageNomalArray[index])
                          vc?.tabBarItem.selectedImage = UIImage(named:imageSelectArray[index])
                          vc?.title = titleArray[index]
                addChild(vc!)
                vc?.navigationController?.setNavigationBarHidden(true, animated: false)
//
                 cuVC = vc
//            case 1:
//                let vc = ThemeListVCViewController.init()
//                let nav = TabNavgationVC.init(rootViewController: vc)
//                vc.tabBarItem.title = titleArray[index]
//                vc.tabBarItem.image = UIImage(named:imageNomalArray[index])
//                vc.tabBarItem.selectedImage = UIImage(named:imageSelectArray[index])
//                vc.title = titleArray[index]
//                addChildViewController(nav)
//                cuVC = vc
//            case 2:
//                let vc = UIViewController.init()
//                let nav = TabNavgationVC.init(rootViewController: vc)
//                vc.tabBarItem.title = titleArray[index]
//                vc.tabBarItem.image = UIImage(named:imageNomalArray[index])
//                vc.tabBarItem.selectedImage = UIImage(named:imageSelectArray[index])
//                vc.title = titleArray[index]
//                addChildViewController(nav)
//                cuVC = vc
            case 1:
                let vc = TestVC.init()
                let nav = TabNavgationVC.init(rootViewController: vc)
                vc.tabBarItem.title = titleArray[index]
                vc.tabBarItem.image = UIImage(named:imageNomalArray[index])
                vc.tabBarItem.selectedImage = UIImage(named:imageSelectArray[index])
                vc.title = titleArray[index]
                addChild(nav)
                cuVC = vc
            default: break
                
            }
            
            
            
            let width :CGFloat = kScreenW/CGFloat(titleArray.count)
            let btn:TMTabbarButton = TMTabbarButton.init(frame:CGRect(x: width * CGFloat(index), y: 0, width: width, height: 49 ))

            btn.configWithItem((cuVC?.tabBarItem)!)
            btn.tag = index
            
            bgImageView.addSubview(btn)
            btn.addTarget(self, action: #selector(btnClick(_ :)), for: UIControl.Event.touchUpInside)
            if index == 0 {
                
                self.selectedIndex = 0
                btn.isSelected = true
                btn.backgroundColor = UIColor.blue
                currentBtn = btn;
            }
            
        }
    }
    
    @objc func btnClick(_ btn:TMTabbarButton)
    {
        if (currentBtn != nil)
        {
           currentBtn?.isSelected = false
           currentBtn?.backgroundColor = UIColor.black
        }
        btn.isSelected = true
        self.selectedIndex = btn.tag
        btn.backgroundColor = UIColor.blue
        currentBtn = btn
    
    }

    //获取工程的名字
    func getBundleName() -> String{
        var bundlePath = Bundle.main.bundlePath
        bundlePath = bundlePath.components(separatedBy: "/").last!
        bundlePath = bundlePath.components(separatedBy: ".").first!
        return bundlePath
    }
    //通过类名返回一个AnyClass
    func getClassWitnClassName(_ name:String) ->AnyClass?{
        let type = getBundleName() + "." + name
        return NSClassFromString(type)
    }
    
}
