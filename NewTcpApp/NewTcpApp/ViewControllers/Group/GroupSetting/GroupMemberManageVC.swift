//
//  GroupMemberManageVC.swift
//  NewTcpApp
//
//  Created by xslp on 2020/8/13.
//  Copyright © 2020 xslpiOS. All rights reserved.
//

import UIKit

class GroupMemberManageVC: GroupCreateVC {

    var isAddMember = false
    var existMember:Array<String>?//已存在成员id
    var groupid:String = ""
    typealias back = (_ resultArray:Array<Any>)->()
    var resultBlock : back?
    override func rightBtnClick(button: UIButton) {
        
        if isDepartmentData {
                   if self.seleDepartArray.count == 0 {return}
               }
               
       if !isDepartmentData {
           if self.seleOtherDepartArray.count == 0 {return}
       }
        
        if isAddMember {
            addGroupMember()
        }else {
            deleteGroupMember()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "删除成员"
        if isAddMember {
            self.title = "邀请成员"
        }
        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
            var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil
            {
               
                let path:String? = Bundle.main.path(forResource: "BaseTableCell", ofType: "nib")
                if path == nil {
                   let  aClass  = getClassWitnClassName("BaseTableCell") as! UITableViewCell.Type
                    cell = aClass.init(style: .default, reuseIdentifier: "BaseTableCell")
                }
                else
                {
                    cell = Bundle.main.loadNibNamed("BaseTableCell", owner: self, options: nil)?.last as! UITableViewCell?
                    
                }

            }
            
            var model:RLMObject?
                
            if isDepartmentData {
                
                model = departDataArray![Int(indexPath.row)]
            }else {
                
                model = otherDepartDataArray![Int(indexPath.row)]
            }
                
            
        
            let bCell = cell as! BaseTableCell
        
            bCell.model = model
            bCell.delegate = self

            bCell.rightBtn.isHidden = true
            bCell.rightBtn.isHidden = true
            
            var seleMemberArray:Array<RLMObject>?
            if isDepartmentData {
                seleMemberArray = self.seleDepartArray
            }else {
                seleMemberArray = self.seleOtherDepartArray
            }
            
            bCell.selectImage.image = UIImage.init(named: "logic_normal")
            
            if seleMemberArray?.count ?? 0 > 0 {
                if (seleMemberArray?.contains(where: { (m) -> Bool in
                    return (m as! FriendsModel).userid == (model as! FriendsModel).userid
                }))!{
                    
                    bCell.selectImage.image = UIImage.init(named: "logic_select")
                }
            }
            
        if (existMember?.contains((model as! FriendsModel).userid))! && isAddMember {
            bCell.selectImage.image = UIImage.init(named: "logic_disable")
        }
            
            return cell!
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let model:FriendsModel = (isDepartmentData ? departDataArray : otherDepartDataArray)?[Int(indexPath.row)] as! FriendsModel
            
            if (existMember?.contains(model.userid))! && isAddMember {
                    return
            }
        
            let index = (isDepartmentData ? seleDepartArray : seleOtherDepartArray).firstIndex(where: { (m) -> Bool in
                 return (m as! FriendsModel).userid == model.userid
             })
             if (index != nil) {
                
                if isDepartmentData {
                    seleDepartArray.remove(at: index!)
                }else {
                    seleOtherDepartArray.remove(at: index!)
                }
                
             }
             else
             {
                if isDepartmentData {
                    seleDepartArray.append(model)
                }else {
                    seleOtherDepartArray.append(model)
                }
                 
             }
            
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    
    //MARK: 请求列表数据
        /**
         type 查询类型（0:不限；1：本部门；2：非本部门）
         */
    override func loadData()  {
            var params = Dictionary<String, Any>()
            params["app_token"] = sharePublicDataSingle.token
            params["keyword"] = searchView.text ?? ""
            params["type"] = (isDepartmentData) ? 1 : 2
            UserRequest.coachSearchUser(params: params, hadToast: true, fail: { (error) in
                print(error.description)
                    }) {[weak self] (success) in
                        
                        print("获取部门列表\(success)");
                        
                        if let code = success["code"] {
                            if "\(code)" != "1" {
                                SVProgressHUD.showError(withStatus: success["msg"] as? String)
                                return
                            }
                        }
                        
    //                    获取部门列表["user_list": <__NSArray0 0x7fff8062d570>(
    //
    //                    )
    //                    , "keyword": , "count": 0]
                        
                        let user_list = success["user_list"] as! [Dictionary<String, Any>]
                        
                        var list:Array<RLMObject> = []
                        let userid:String = sharePublicDataSingle.publicData.userid as String
                
                        for any in user_list {
                            
                            if any["userid"] as! String !=  userid {
                                let model = FriendsModel.init(value: any)
                                
                                if self!.isAddMember == false {
                                    if (self?.existMember?.contains(model.userid))! {
                                         list.append(model)
                                    }
                                }else {
                                     list.append(model)
                                }
                            }
                            
                           
                        }
                        
                        
                        if !self!.isDepartmentData {
                            self?.isLoadOtherDepartData = true
                            self?.otherDepartDataArray =  list
                        }else {
                            self?.isLoadDepartData = true
                            self?.departDataArray =  list
                        }
                        
                        self?.listTable.reloadData()
                        
                    }
        }
    
    func deleteGroupMember()  {
        
        var params = Dictionary<String, Any>()
        
        let userArray = self.isDepartmentData ? self.seleDepartArray : self.seleOtherDepartArray
        
        let idStr = (NSArray.init(array: userArray).value(forKeyPath: "userid") as! NSArray).componentsJoined(by: ",")
        
            //appToken:App登录Token groupId:群组ID userIdStr:删除的用户ID（,分割）
        params["app_token"] = sharePublicDataSingle.token
        params["groupid"] = groupid
        params["userid_str"] = idStr
        GroupRequest.delUser(params: params, hadToast: true, fail: { (Error) in
                    print(Error.description)
                }) {[weak self] (success) in
                    
                    print("删除群组列表\(success)");
                    
                    if let code = success["code"] {
                        if "\(code)" != "1" {
                            SVProgressHUD.showError(withStatus: success["msg"] as? String)
                            return
                        }
                    }
            let username:String = sharePublicDataSingle.publicData.userid + sharePublicDataSingle.publicData.corpid
            var time:String? = UserDefaults.standard.object(forKey: username) as! String?
            if time == nil{
                time = "0"
            }
            UserRequest.initData(params: ["app_token":sharePublicDataSingle.token,"updatetime":time!], hadToast: true, fail: { (error) in
    
            }, success: { (dic) in
                print(dic)
                self?.resultBlock?(userArray)
                self?.navigationController?.popViewController(animated: true)
            })
                    
                }
        }
    
    func addGroupMember()  {
    
    var params = Dictionary<String, Any>()
    
    let userArray = self.isDepartmentData ? self.seleDepartArray : self.seleOtherDepartArray
    
    let idStr = (NSArray.init(array: userArray).value(forKeyPath: "userid") as! NSArray).componentsJoined(by: ",")
    
        //appToken:App登录Token groupId:群组ID userIdStr:删除的用户ID（,分割）
    params["app_token"] = sharePublicDataSingle.token
    params["groupid"] = groupid
    params["userid_str"] = idStr
        
//    self.resultBlock?(userArray)
//    self.navigationController?.popViewController(animated: true)
//    return
    GroupRequest.inviteUser(params: params, hadToast: true, fail: { (Error) in
        print(Error.description)
            }) {[weak self] (success) in
                
                print("邀请群组列表\(success)");
                
                if let code = success["code"] {
                    if "\(code)" != "1" {
                        SVProgressHUD.showError(withStatus: success["msg"] as? String)
                        return
                    }
                }
        
        
                let username:String = sharePublicDataSingle.publicData.userid + sharePublicDataSingle.publicData.corpid
                var time:String? = UserDefaults.standard.object(forKey: username) as! String?
                if time == nil{
                    time = "0"
                }
                UserRequest.initData(params: ["app_token":sharePublicDataSingle.token,"updatetime":time!], hadToast: true, fail: { (error) in
        
                }, success: { (dic) in
                    print(dic)
                    self?.resultBlock?(userArray)
                    self?.navigationController?.popViewController(animated: true)
                })
      
                
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
