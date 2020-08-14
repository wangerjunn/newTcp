//
//  GroupIsOpenVC.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/23.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class GroupIsOpenVC: BaseViewController {
    
    var userArray:Array<RLMObject>?
    var groupName:String?
    var isOpen = true
    @IBAction func btnClick(_ sender: UIButton) {
        rightImage.image = UIImage.init(named: "isClose_normal")
        leftImage.image = UIImage.init(named: "isOpen_normal")
        
        if sender.tag == 101 {
            isOpen = true
            rightImage.image = UIImage.init(named: "isClose_select")
        }else {
            isOpen = false
            leftImage.image = UIImage.init(named: "isOpen_select")
        }
    }
    
    
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var deslable: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.view.backgroundColor = UIColor.groupTableViewBackground
       self.title = "创建群组"
       self.setRightBtnWithArray(items: ["确定"])
       
       self.deslable.layer.cornerRadius = 6
       self.deslable.clipsToBounds = true
        
       self.deslable.text = "\n提示：若您设置为【开放】，则企业成员可查找到该群组，并申请加入；若您设置为【私有】，则企业内部其他成员无法查找到该群，仅能通过扫描群二维码加入。               \n "
        
        // 设置行间距
        let style = NSMutableParagraphStyle()
        // 间隙
        style.lineSpacing = 5
        self.deslable.attributedText = NSAttributedString(string: self.deslable.text!,
                                    attributes: [NSAttributedString.Key.paragraphStyle: style])

        let bgView = UIView.init()
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 6
        view.addSubview(bgView)
        
        bgView.mas_makeConstraints { [unowned self](make) in
            make?.left.equalTo()(self.deslable)?.offset()(-10)
            make?.right.equalTo()(self.deslable)?.offset()(10)
            make?.top.centerX()?.centerY()?.height()?.equalTo()(self.deslable)
        }
        
        view.sendSubviewToBack(bgView)
        
        leftImage.image = UIImage.init(named: "isOpen_select")
    }

    override func rightBtnClick(button: UIButton) {
       
        var params = Dictionary<String, Any>()
        params["app_token"] = sharePublicDataSingle.token
        
        params["group_name"] = ""
        if groupName != nil {
            params["group_name"] = groupName!
        }
        


        let idStr = (NSArray.init(array: userArray!).value(forKeyPath: "userid") as! NSArray).componentsJoined(by: ",")


        params["userid_str"] = idStr
        
        if isOpen {
            params["is_open"] = "1"
        } else {
           params["is_open"] = "0"
        }
        
        
       GroupRequest.creat(params: params, hadToast: true, fail: { (error)  in

       }, success: {[weak self] (success)  in
        if let code = success["code"] {
            if "\(code)" != "1" {
                self?.showAlert(content: success["msg"] as! String)
                return
            }
        }
        
//        RCIM.shared()?.refreshGroupInfoCache(<#T##groupInfo: RCGroup!##RCGroup!#>, withGroupId: <#T##String!#>)
        print("创建群组成功",success)
        
        if let gorupid = success["groupId"] {
            let group:RCGroup = (RCIM.shared()?.getGroupInfoCache("\(gorupid)"))!
            
            print(group.groupName ?? "")
            //群组成员信息groupID修改值
//            for i in 0..<(self?.userArray!.count)! {
//                let friendModel = self!.userArray![i] as! FriendsModel
//
//                var groupUserModel = GroupUserModel.init()
//                groupUserModel.groupid = gorupid as! String
//                groupUserModel.userid = friendModel.userid
//                groupUserModel.realname = friendModel.realname
//                groupUserModel.avater = friendModel.avater
//                groupUserModel.is_delete = "0"
//            }
            
            
                
            self?.getGroupInfo(groupid: "\(gorupid)")
        }
        
       })

        
    }
    
    //获取群组信息，写入本地数据
    func getGroupInfo(groupid:String) {
        
        var params = Dictionary<String, Any>()
        params["app_token"] = sharePublicDataSingle.token
        params["groupid"] = groupid
        GroupRequest.info(params: params, hadToast: true, fail: { (Error) in
            
        }) { [weak self] (success) in
            if let code = success["code"] {
                if "\(code)" != "1" {
                    self?.showAlert(content: success["msg"] as! String)
                    return
                }
            }
            
            
           let group = GroupModel.init(value: success)
            DataOperation.addData(rlmObject: group)
            self?.navigationController?.popToRootViewController(animated: true)
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
