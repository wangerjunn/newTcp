//
//  GroupMemberVC.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/16.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit
import Realm
class GroupMemberVC: BaseTableVC {
    
    //创建群组和添加成员共用  但是数据处理和UI还是有一些小区别 因此添加了一个字段 isCreatGroup
    //是否是创建群组
    var isCreatGroup:Bool?
    var rightBtn:UIButton?
    var isAddMember:Bool? //是添加 还是删除
    
    
    typealias back = (_ resultArray:Array<Any>)->()
   fileprivate var resultBlock : back?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if isCreatGroup == true {
           configUIWithCreatGroup()
        }
        else
        {
           configUIWithAddMember()
           
        }
        self.configUIWith(fromCellName: "BaseTableCell", fromIsShowSearch: true,fromSearchType: true ,fromCellHeight: 50)
        
       
        
        if self.isAddMember == false{
            
            /// 删除成员
            var array = NSArray.init(array: (self.memberArray)!)
            if array.count < 1 {
                return
            }
            let model :GroupUserModel = array.firstObject as! GroupUserModel
            self.memberArray?.removeAll()
            array = array.value(forKeyPath: "userid") as! NSArray
            
            let predicate = NSPredicate(format:"userid in %@ AND groupid ==%@", array,model.groupid)
           
            self.allDataArray =  GroupUserModel.allObjects().objects(with: predicate) as? RLMResults<RLMObject>
            self.setDataArray(dataArray:(self.allDataArray!))
            
            return
        }
        
        
        var params = Dictionary<String, Any>()
        params["app_token"] = sharePublicDataSingle.token
        UserRequest.friends(params: params, hadToast: true, fail: { (Error) in
            print(Error.localizedDescription)
        }) {[weak self] (success) in
            
            print("获取好友列表\(success)");
            
            if let code = success["code"] {
                if "\(code)" != "1" {
                    self?.showAlert(content: success["msg"] as! String)
                    return
                }
            }
            
            let strongSelf = self
            DispatchQueue.main.async{
                
                
                
                strongSelf?.allDataArray =  FriendsModel.allObjects() as? RLMResults<RLMObject>
                
                strongSelf?.setDataArray(dataArray:(strongSelf?.allDataArray!)!)
//                 strongSelf?.creatGroup()
                    if strongSelf?.allDataArray?.count == 0{
//                        strongSelf?.creatGroup()
                    }
                
                
                }
           
            
            
        }
        
    }

    
    /// 创建群组
    func creatGroup()
    {
        var params = Dictionary<String, Any>()
        params["app_token"] = sharePublicDataSingle.token
        params["group_name"] = "测试"
        params["userid_str"] = ""
        params["is_open"] = "1"
        GroupRequest.creat(params: params, hadToast: true, fail: { (error)  in
            print(error.localizedDescription)
        }, success: {[weak self] (success)  in
            
            print("创建群组成功",success)
//            self?.navigationController?.popToRootViewController(animated: true)
//            self?.creatSweep()
            if let code = success["code"] {
                if "\(code)" != "1" {
                               //{"code":40003,"msg":"登录令牌错误","data":null}
                    self?.showAlert(content: success["msg"] as! String)
                    return
                }
            }else {
                self?.getImageWithGroup(id:String.changeToString(inValue: success["groupId"] as Any))
            }
            
        })
        

    }
    
    
    /// 获取群组的二维码
    ///
    /// - Parameter id: 群组id
    func getImageWithGroup(id:String){
    
        var params = Dictionary<String, Any>()
        params["app_token"] = sharePublicDataSingle.token
        params["groupid"] = id
        GroupRequest.getQrCode(params: params, hadToast: true, fail: { (error) in
            
        }) { (success) in
           if let code = success["code"] {
               if "\(code)" != "1" {
                              //{"code":40003,"msg":"登录令牌错误","data":null}
                self.showAlert(content: success["msg"] as! String)
                return
               }
           }
            self.creatSweep(url: success["qr_url"] as! String)
        }

    }
    
    
    /// 创建群组二维码显示界面
    ///
    /// - Parameter url: 二维码图片地址
    func creatSweep(url:String)
    {
      let sweep = GroupSweepView.initWithImage(url: url)
      self.view.addSubview(sweep)
    }
    
    /// 创建群组UI
    func configUIWithCreatGroup()
    {
        self.title = "选择联系人"
        rightBtn = UIButton.init(type: .custom)
        rightBtn?.frame = CGRect.init(x: 0, y: 100, width: 60, height: 30)
        rightBtn?.setTitle("确定", for:.normal)
        rightBtn?.sizeToFit()
        let rightItem  = UIBarButtonItem.init(customView: rightBtn!)
        rightBtn?.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
         rightItem.isEnabled = false
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    
    /// 添加成员UI
    func configUIWithAddMember()
    {
                self.view.backgroundColor = UIColor.black
                let titleLable = UILabel.init(frame: CGRect(x: (kScreenW-100)/2, y: 27, width: 100, height: 30))
                titleLable.text = "选择联系人"
                titleLable.textColor = UIColor.white
                self.view.addSubview(titleLable)
        
        
        
        
                let leftBtn = UIButton.init(type: .custom)
                leftBtn.frame = CGRect.init(x: 15, y: 27, width: 40, height: 30)
                leftBtn.setTitle("取消", for:.normal)
                self.view.addSubview(leftBtn)
                leftBtn.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
        
        
                rightBtn = UIButton.init(type: .custom)
                rightBtn?.frame = CGRect.init(x: kScreenW-60, y: 27, width: 60, height: 30)
                rightBtn?.isEnabled = false
                rightBtn?.setTitle("确定", for:.normal)
                rightBtn?.setTitleColor(UIColor.lightGray, for: .normal)
                rightBtn?.sizeToFit()
                self.view.addSubview(rightBtn!)
                rightBtn?.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
    }
    
    
    
    
    
    
    @objc func leftClick(){
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rightClick(){
        
        
        if isCreatGroup == true {
            //创建群组
            if self.selectedArray?.count == 0 {
                return
            }
            
            let alert = UIAlertController.init(title: "群组名称", message: "请输入创建的群组名称", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "请输入群组名称"
            }
            
            let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (cancelAction) in
                let isOpenVC = GroupIsOpenVC()
                isOpenVC.userArray = self.selectedArray
                self.navigationController?.pushViewController(isOpenVC, animated: true)
            }
            
            let okAction = UIAlertAction.init(title: "确认", style: .default) { (okAction) in
                let isOpenVC = GroupIsOpenVC()
                isOpenVC.groupName = alert.textFields?.first?.text
                isOpenVC.userArray = self.selectedArray
                self.navigationController?.pushViewController(isOpenVC, animated: true)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            
            return;
        }
        else if (isAddMember == false){
            //删除成员
        resultBlock?(selectedArray!)
        }
        else
        {
        //添加成员
        if resultBlock != nil  {
            if self.selectedArray?.count == 0 {
                return
            }
            var resultArray = Array<Any>()
            for i in 0...(selectedArray?.count)!-1 {
                
                let fModel = selectedArray?[i] as! FriendsModel
                let gModel = GroupUserModel()
                gModel.userid = fModel.userid
                gModel.avater = fModel.avater
                gModel.realname = fModel.realname
                resultArray.append(gModel)
            }
            
            
            resultBlock?(resultArray)
        }
        
        
        }
        
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isAddMember == false{
            let model:GroupUserModel = self.dataArray![UInt(indexPath.row)] as! GroupUserModel
            
            if (self.memberArray?.contains(where: { (m) -> Bool in
                
                return m.userid == model.userid
                
            }) == true) {
                
                return
            }
            
            
            
            
            let index = self.selectedArray?.firstIndex(where: { (m) -> Bool in
                return (m as! GroupUserModel).userid == model.userid
            })
            if (index != nil) {
                self.selectedArray?.remove(at: index!)
            }
            else
            {
                self.selectedArray?.append(model)
                
            }

        }
        else{
        
            let model:FriendsModel = self.dataArray![UInt(indexPath.row)] as! FriendsModel
            
            if (self.memberArray?.contains(where: { (m) -> Bool in
                
                return m.userid == model.userid
                
            }) == true) {
                
                return
            }
            
            
            
            
            let index = self.selectedArray?.index(where: { (m) -> Bool in
                return (m as! FriendsModel).userid == model.userid
            })
            if (index != nil) {
                self.selectedArray?.remove(at: index!)
            }
            else
            {
                self.selectedArray?.append(model)
                
            }

        }
        
        
       if self.isShowSearch! {
        
        
        
        
        
            searchView?.configWithDataArray(array:selectedArray!)
        
                }
    tableView.reloadData()
      
    changeRightBtnStatus()
        
    }
    
    
    /// 改变右边按钮状态
    func changeRightBtnStatus(){
        if selectedArray?.count != 0 {
            let countStr = String.init(format: "确定(%d)", (selectedArray?.count)!)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            rightBtn?.setTitleColor(UIColor.white, for: .normal)
            rightBtn?.isEnabled = true
            rightBtn?.setTitle(countStr, for: .normal)
            rightBtn?.sizeToFit()
        }
        else
        {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            rightBtn?.isEnabled = false
            rightBtn?.setTitleColor(UIColor.lightGray, for: .normal)
            rightBtn?.setTitle("确定", for: .normal)
        }

    }
   
    
    
    override func searchDeleteItem(item: RLMObject) {
        
        let model = item as! FriendsModel
        
        if (self.memberArray?.contains(where: { (m) -> Bool in
            
            return m.userid == model.userid
            
        }) == true) {
            
            return
        }

        
        
        let index = self.selectedArray?.index(where: { (m) -> Bool in
            return (m as! FriendsModel).userid == model.userid
        })
        if (index != nil) {
            self.selectedArray?.remove(at: index!)
        }
        
       table?.reloadData()
        changeRightBtnStatus()
    }
    
    
    public func resultWithArray(resultArray:@escaping back)
    {
       resultBlock = resultArray
    }
}


