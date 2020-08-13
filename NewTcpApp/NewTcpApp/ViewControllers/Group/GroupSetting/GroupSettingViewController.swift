//
//  GroupSettingViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/9.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class GroupSettingViewController: BaseViewController {

    fileprivate var dataSourceArr = Array<Array<Dictionary<String, Any>>>()
    fileprivate var usersDataSourceArr  = Array<GroupUserModel>()
    var header : GroupSettingTableViewHeader!
    var headerView : UIView!
    var groupModel:GroupModel?
    var is_owner : Bool? //是否是群组
    var conversationModel:RCConversationModel?{
        
        didSet {
            groupModel = GroupModel.objects(with: NSPredicate.init(format: "groupid == %@",(conversationModel?.targetId)!)).firstObject() as! GroupModel?
            
            if groupModel == nil {
                self.getGroupInfo(groupid: conversationModel?.targetId ?? "")
            }else {
                is_owner = (groupModel?.owner_id)! == sharePublicDataSingle.publicData.userid as String
                self.configData()
                self.configUI()
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "群组信息"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if groupModel != nil {
            self.configData()
            self.tableView.reloadData()
        }
    }
    func configData() {
        let groupUserModels = GroupUserModel.objects(with: NSPredicate.init(format: "groupid == %@",(conversationModel?.targetId)!)).sortedResults(usingKeyPath: "inputtime", ascending: true)
        for i in 0..<groupUserModels.count {
            let groupUserModel : GroupUserModel = groupUserModels[i] as! GroupUserModel
            usersDataSourceArr.append(groupUserModel)
        }
        dataSourceArr = [
            [["群组名称":groupModel?.group_name ?? ""],["群组二维码":""],["群组验证码":groupModel?.auth_code ?? ""],["群组开放性":groupModel?.is_open ?? ""]],
            [["置顶聊天":conversationModel?.isTop.hashValue ?? 0]]
        ]

    }
    
    func configUI() {
        header = GroupSettingTableViewHeader.init()
        header.myDelegate = self
        header.users = usersDataSourceArr
        header.isAllowedDeleteMember = is_owner
        headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: header.collectionViewLayout.collectionViewContentSize.height))
        headerView.addSubview(header)
        header.mas_makeConstraints { (make) in
            make!.top.left().bottom().right().equalTo()(headerView)
        }
        self.tableView.tableHeaderView = headerView
        
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 70))
        footerView.backgroundColor = UIColor.clear
        let delAndExitBtn = UIButton.init(frame: CGRect.init(x: 20, y: 20, width: SCREEN_WIDTH - 20 * 2, height: 40))
        delAndExitBtn.addTarget(self, action: #selector(exitBtnClick), for: .touchUpInside)
        delAndExitBtn.backgroundColor = UIColor.hexString(hexString: "2183DE")
        delAndExitBtn.layer.cornerRadius = 5.0
        if is_owner! {
            
            delAndExitBtn.setTitle("解散群组", for: .normal)
        }else{
            delAndExitBtn.setTitle("删除并退出", for: .normal)
        }
        delAndExitBtn.titleLabel?.textColor = UIColor.white
        delAndExitBtn.titleLabel?.font = FONT_16
        footerView.addSubview(delAndExitBtn)
        
        self.tableView.tableFooterView = footerView
        
        self.view.addSubview(self.tableView)
        
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
            
            self?.groupModel = GroupModel.init(value: success)
            self?.is_owner = (self?.groupModel?.owner_id) == sharePublicDataSingle.publicData.userid as String
            self?.configData()
            self?.configUI()
            self?.tableView.reloadData()
            DataOperation.addData(rlmObject: (self?.groupModel)!)
        }
    }
    
    @objc func exitBtnClick() {
        
//        let platforms = [NSNumber(value: 0),NSNumber(value: 1),NSNumber(value: 2),NSNumber(value: 3)]
//        let shareView = ShareView.init(shareViewBySharePlaform: platforms, viewTitle: "页面标题", shareTitle: "分享标题", shareDesp: "分享描述", shareLogo: "http://img.xingdongsport.com/file/WechatIMG6500.png", shareUrl: "https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_10139635496213047344%22%7D&n_type=0&p_from=1")
//        shareView!.show()
//        return
        if is_owner! {
            GroupRequest.dismiss(params: ["app_token":sharePublicDataSingle.token,"groupid":groupModel?.groupid ?? ""], hadToast: true, fail: { (error) in
                
            }, success: {  [weak self](dic) in
                print(dic)
                if let code = dic["code"] {
                    if "\(code)" != "1" {
                        self?.showAlert(content: dic["msg"] as! String)
                        return
                    }
                }
                if let strongSelf = self{
                    DispatchQueue.main.async {
                        let realm:RLMRealm = RLMRealm.default()
                        realm.beginWriteTransaction()
                        strongSelf.groupModel?.setValue( "1", forKey: "is_delete")
                        try? realm.commitWriteTransaction()
                                            
                        //                    RCIMClient.shared().clearMessages((strongSelf.conversationModel?.conversationType)!, targetId: strongSelf.conversationModel?.targetId)
                        //                    RCIMClient.shared().remove((strongSelf.conversationModel?.conversationType)!, targetId: strongSelf.conversationModel?.targetId)
                        //                    DataOperation.removeData(rlmObject: strongSelf.groupModel)
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                    
                }
            })
        }else{
            GroupRequest.quit(params: ["app_token":sharePublicDataSingle.token,"groupid":groupModel?.groupid ?? ""], hadToast: true, fail: { (error) in
                
            }, success: { [weak self](dic) in
                print(dic)
                if let code = dic["code"] {
                    if "\(code)" != "1" {
                        self?.showAlert(content: dic["msg"] as! String)
                        return
                    }
                }
                if let strongSelf = self{
                    DispatchQueue.main.async {
                        let realm:RLMRealm = RLMRealm.default()
                        realm.beginWriteTransaction()
                        strongSelf.groupModel?.setValue( "1", forKey: "is_delete")
                        try? realm.commitWriteTransaction()
                                            
                        //                    RCIMClient.shared().clearMessages((strongSelf.conversationModel?.conversationType)!, targetId: strongSelf.conversationModel?.targetId)
                        //                    RCIMClient.shared().remove((strongSelf.conversationModel?.conversationType)!, targetId: strongSelf.conversationModel?.targetId)
                        //                    DataOperation.removeData(rlmObject: strongSelf.groupModel)
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                }
            })
        }
    }
    
    
    //MARK: --------------------------- Getter and Setter --------------------------

    lazy var tableView: UITableView = {
        var tableView : UITableView = UITableView.init(frame: self.view.bounds)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.dataSource  = self
        tableView.delegate    = self
        return tableView
    }()
}
//MARK: - UITableViewDataSource, UITableViewDelegate
extension GroupSettingViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row != 3 || indexPath.section == 1 && indexPath.row != 0 {
            let cell = GroupSettingWithArrowCell.cell(withTableView: tableView)
            if indexPath.section == 0 && indexPath.row == 1 {
                cell.detailLabel.isHidden = true
                cell.detailImage.isHidden = false
            }else{
                cell.detailLabel.isHidden = false
                cell.detailImage.isHidden = true
            }
            cell.model = dataSourceArr[indexPath.section][indexPath.row]
            return cell
        }else{
            let cell = GroupSettingWithSwitchCell.cell(withTableView: tableView)
            cell.delegate = self
            cell.model = dataSourceArr[indexPath.section][indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 && indexPath.row == 3 {
//            let detailStr = (dataSourceArr[indexPath.section][indexPath.row] ).first?.value as! String?
//            if detailStr == "未设置" {
//                return 44
//            }else{
//                let height = ((detailStr?.getTextHeight(font: FONT_14, width: SCREEN_WIDTH - LEFT_PADDING_GS * 2 - 15))! + 0.4) > 60 ? 50.5 : ((detailStr?.getTextHeight(font: FONT_14, width: SCREEN_WIDTH - LEFT_PADDING_GS * 2 - 15))! + 0.4)
//                return 44 + height + 5
//            }
//        }else{
            return 44
//        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let groupNameEditVC = GroupNameEditViewController()
                groupNameEditVC.groupModel = groupModel
                self.navigationController?.pushViewController(groupNameEditVC, animated: true)
            case 1:
                let groupQRCodeVC = GroupQRCodeViewController()
                groupQRCodeVC.groupModel = groupModel
                self.navigationController?.pushViewController(groupQRCodeVC, animated: true)
                
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 1:
                
                  let histotyVC = SearchHistotyVC()
                  self.navigationController?.pushViewController(histotyVC, animated: true)
                
            default:
                break
            }
        default:
            break
        }
    }
}
//MARK: - GroupSettingTableViewHeaderDelegate
extension GroupSettingViewController : GroupSettingTableViewHeaderDelegate {

    func userItemDidClick(userId: String) {
        
    }
    func addBtnDidClick() {
        let addMemeberVc = GroupMemberVC()
        // 数组 header.users 包含群组成员model
//        addMemeberVc.mem
        addMemeberVc.isAddMember = true
        addMemeberVc.memberArray = header.users
        addMemeberVc.resultWithArray { [weak self]  (resultArray) in
            if let strongHSelf = self{
                for userModel in resultArray
                {
                    strongHSelf.header.users.append(userModel as! GroupUserModel)
                }
                strongHSelf.header.reloadData()
                strongHSelf.headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height:
                    strongHSelf.header.collectionViewLayout.collectionViewContentSize.height)
                strongHSelf.tableView.reloadData()
                
            }

        }
        
        addMemeberVc.modalPresentationStyle = .fullScreen
        self.present(addMemeberVc, animated: true, completion: nil)

    }
    func delBtnDidClick() {
        let addMemeberVc = GroupMemberVC()
        addMemeberVc.isAddMember = false
       
        var tempUsers : Array<GroupUserModel> = Array()
        for userModel in header.users {
            if userModel.userid != groupModel?.owner_id {
                tempUsers.append(userModel)
            }
        }
        addMemeberVc.memberArray = tempUsers
        addMemeberVc.resultWithArray { [weak self]  (resultArray) in
            if let strongHSelf = self{
                var tempUserIdsArr = Array<String>()
                var tempResultIdsArr = Array<String>()
                var tempDelArr = Array<Int>()
                
                for userModel in resultArray
                {
                    tempResultIdsArr.append((userModel as! GroupUserModel).userid)
                }
                
                for i in 0..<strongHSelf.header.users.count
                {
                    let userModel = strongHSelf.header.users[i]
                    if tempResultIdsArr.contains(userModel.userid){
                        tempDelArr.append(i)
                    }
                    tempUserIdsArr.append(userModel.userid)
                }
                for index in tempDelArr.reversed(){
                    strongHSelf.header.users.remove(at: index)
                }
                strongHSelf.header.reloadData()
                strongHSelf.headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height:
                    strongHSelf.header.collectionViewLayout.collectionViewContentSize.height)
                strongHSelf.tableView.reloadData()
                
            }
            
        }

        self.present(addMemeberVc, animated: true, completion: nil)
//        header.users.removeLast()
//        header.reloadData()
//        headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: header.collectionViewLayout.collectionViewContentSize.height)
//        tableView.reloadData()
    }
}

extension GroupSettingViewController : GroupSettingWithSwitchCellDelegate {
    
    func onClickSwitchButton(swich: UISwitch, title: String) {
        switch title {
        case "群组开放性":
            GroupRequest.setOpen(params: ["app_token":sharePublicDataSingle.token,"groupid":groupModel?.groupid,"is_open":swich.isOn ? "1" : "0"], hadToast: true, fail: { (error) in

            }) { [weak self](dic) in
                if String.changeToString(inValue: (dic as! Dictionary)["code"]!) != "1"{
                    swich.isOn = !swich.isOn
                    self?.showAlert(content: dic["msg"] as! String)
                    return
                }
                if let strongSelf = self {
                    let realm:RLMRealm = RLMRealm.default()
                    realm.beginWriteTransaction()
                    strongSelf.groupModel?.setValue(swich.isOn ? "1" : "0", forKey: "is_open")
                    try? realm.commitWriteTransaction()

                }
            }
        case "置顶聊天":
            RCIMClient.shared().setConversationToTop((conversationModel?.conversationType)!, targetId: conversationModel?.targetId, isTop: swich.isOn)
            
        default:
            break
        }

    }
}
