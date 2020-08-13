//
//  GroupListViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/2/28.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class GroupListViewController: RCConversationListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = UIColor.white
        self.title = "群组列表"
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.hexString(hexString: "333333")
        //修改导航栏按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.makeNavigationBackBtn()
        self.setRightBtnWithArray(items: [UIImage.init(named: "nav_add")])
        self.setDisplayConversationTypes([RCConversationType.ConversationType_GROUP.rawValue])
        //        self.setCollectionConversationType([RCConversationType.ConversationType_GROUP.rawValue])
        self.showConnectingStatusOnNavigatorBar = true
        //                self.refreshConversationTableViewIfNeeded()
        self.conversationListTableView.tableFooterView = self.footView

//        self.footLabel.text = "9个群组"
//        mainTableView.tableFooterView = self.footView
//        view.addSubview(mainTableView)

//        RCIM.shared().initWithAppKey("m7ua80gbm7bgm")
//        RCIM.shared().initWithAppKey("qf3d5gbjqpxeh")
        
//        RCIM.shared().connect(withToken: "QjOJ1HmIeLx/djdJWjJLEq01ibRUkx5u43yhw5p9sIJ1Gzd/ZtB7c+x51YXnMt9+O3QyP4bYCQc=", success: { (userId) in
//            print("登陆成功。当前登录的用户ID：\(userId)")
//        self.footLabel.text = "\(self.conversationListDataSource.count)个群组"

//        }, error: { (status) in
//            print("登陆的错误码为:\(status)")
//        }) {
//            print("token错误")
//        }
        
//        vGrq8dIdrbwP12fNpzuNjAuG3tBEDnpU3tFaQ1AXlym5UhyJM8YFEjSjwExHl1Ufndemu86S3L0yDc5koEsXNA==    003
//        oHnV7O0HSy7n9NIF0l8jrAuG3tBEDnpU3tFaQ1AXlynh8NXb9ekqzXpo4NhCEz6I3u2slqAixQ0yDc5koEsXNA==    002
//        PublicDataSingle.sharePublicDataSingle
//        sharePublicDataSingle
        
//        UserRequest.getToken(params: ["app_token":sharePublicDataSingle.token], hadToast: true, fail: { (error) in
//            print(error)
//        }) { (dis) in
//            print(dis)
//            sharePublicDataSingle.publicData.userid = dis["userid"] as! String
//            sharePublicDataSingle.publicData.avater = dis["avater"] as! String
//            sharePublicDataSingle.publicData.corpid = dis["corpid"] is NSNumber ? (dis["corpid"] as! NSNumber).stringValue : dis["corpid"] as! String
//            sharePublicDataSingle.publicData.realname = dis["realname"] as! String
//            sharePublicDataSingle.publicData.access_token = dis["access_token"] as! String
//            sharePublicDataSingle.publicData.im_token = dis["im_token"] as! String
//            DataBaseOperation.initDataBase()
//            
//            UserRequest.initData(params: ["app_token":sharePublicDataSingle.token,"updatetime":"0"], hadToast: true, fail: { (error) in
//                print(error)
//            }, success: { (dic) in
//                print(dic)
////                let oncRCId = ((dic["groupList"] as! Array)[0])["groupid"] as! String
////                let oneRc = RCIMClient.shared().getConversation(RCConversationType.ConversationType_GROUP, targetId: oncRCId)
////                print("\(oneRc)")
//                RCIM.shared().connect(withToken: sharePublicDataSingle.publicData.im_token, success: { (userId) in
//                    print("登陆成功。当前登录的用户ID：\(userId)")
//                    DispatchQueue.main.async {
//                        self.footLabel.text = "\(self.conversationListDataSource.count)个群组"
//                    }
//                    let coList = RCIMClient.shared().getConversationList([1,2,3,4,5,6])
//                    print(coList)
//                    let oncRCIdDic = ((dic["groupList"] as! Array)[0]) as! Dictionary<String,Any>
//                    let oncRCId = oncRCIdDic["groupid"] as! String
////                    let oneRc = RCIMClient.shared().getConversation(RCConversationType.ConversationType_GROUP, targetId: oncRCId)
//                    let oneRc = RCIMClient.shared().getLatestMessages(RCConversationType.ConversationType_GROUP, targetId: oncRCId, count: 100)
//                    print("\(oneRc)")
//                }, error: { (status) in
//                    print("登陆的错误码为:\(status)")
//                }) {
//                    print("token错误")
//                }
//            })
        
//                RCIM.shared().connect(withToken: sharePublicDataSingle.publicData.im_token, success: { (userId) in
//                    print("登陆成功。当前登录的用户ID：\(userId)")
//                    DispatchQueue.main.async {
//                        let results = GroupModel.allObjects()
//                        self.footLabel.text = "\(results.count)个群组"
//
//                        self.refreshConversationTableViewIfNeeded()
//                        
//                    }
//                }, error: { (status) in
//                    print("登陆的错误码为:\(status)")
//                }) {
//                    print("token错误")
//                }

//            UserRequest.userInfo(params: ["appToken":sharePublicDataSingle.token,"userid":sharePublicDataSingle.publicData.userid], hadToast: true, fail: { (error) in
//                print(error)
//            }, success: { (dic) in
//                print(dic)
//            })
//            UserRequest.userList(params: ["userIdStr":[664,665],"appToken":sharePublicDataSingle.token], hadToast: true, fail: { (error) in
//                print(error)
//            }, success: { (dic) in
//                print(dic)
//            })
//            RCIM.shared().connect(withToken: sharePublicDataSingle.publicData.im_token, success: { (userId) in
//                print("登陆成功。当前登录的用户ID：\(userId)")
//                DispatchQueue.main.async {
//                    self.footLabel.text = "\(self.conversationListDataSource.count)个群组"
//                }
//            }, error: { (status) in
//                print("登陆的错误码为:\(status)")
//            }) {
//                print("token错误")
//            }
//        }
       
    }
    override func rightBtnClick(button: UIButton) {
        UIApplication.shared.keyWindow?.addSubview(comboboxView!)
    }
    private func makeNavigationBackBtn() {
        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: kNavBackWidth, height: kNavBackHeight))
        backBtn.addTarget(self, action: #selector(backBtnDidClick), for: .touchUpInside)
        backBtn.setImage(UIImage.init(named: "nav_back"), for: .normal)
        backBtn.sizeToFit()
        let leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    //左上角返回按钮点击事件
    @objc func backBtnDidClick() {
        self.dismiss(animated: true) {
            //断开融云链接
            RCIM.shared().logout()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //重写RCConversationListViewController的onSelectedTableRow事件
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        //打开会话界面
        if conversationModelType == RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION {

//            let chat = RongTestVC(conversationType: model.conversationType, targetId: model.targetId)
//            chat?.title = model.conversationTitle
//           
//            self.navigationController?.pushViewController(chat!, animated: true)
            
            let tabBarVc : TMTabbarController = TMTabbarController()
            tabBarVc.groupModel = model
            self.navigationController?.pushViewController(tabBarVc, animated: true)
            
        }
    }

    override func willReloadTableData(_ dataSource: NSMutableArray!) -> NSMutableArray! {
//        super.willReloadTableData(dataSource)
        
        let results = GroupModel.allObjects().sortedResults(usingKeyPath: "inputtime", ascending: false)
        
        var tempArrM = Array<String>()
        
        for i in 0..<dataSource.count {
            
            let model : RCConversationModel = dataSource[i] as! RCConversationModel
            
            model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION

            let models = GroupModel.objects(with: NSPredicate.init(format: "groupid == %@",model.targetId))
            
            var result : GroupModel?
            
            if models.count > 0 {
                result = models.firstObject() as! GroupModel?
            }
//            result : GroupModel? = GroupModel.objects(with: NSPredicate.init(format: "groupid == %@",model.targetId)).firstObject() as! GroupModel?

            if result == nil {
                //不存在本地数据库时
                print("本地不存在数据\(model.targetId!)")
            }
            model.conversationTitle = result?.group_name
//            let imageArr : NSMutableArray = [result?.icon_url as Any]
            model.extend = result?.icon_url
            model.topCellBackgroundColor = UIColor.hexString(hexString: "F6F6F6")
            model.cellBackgroundColor = UIColor.white
        
            tempArrM.append(model.targetId)
        }

        //遍历本地数据库数据
        for i in 0..<results.count {
            
            let groupModel : GroupModel = results[i] as! GroupModel
            
            //融云端数据不包含本地数据时
            if !tempArrM.contains(groupModel.groupid){
                
                if groupModel.is_delete == "0" {
                    let model = RCConversationModel.init()
                    model.conversationModelType = RCConversationModelType.CONVERSATION_MODEL_TYPE_CUSTOMIZATION
                    //                let imageArr : NSMutableArray = [groupModel.icon_url]
                    model.extend = groupModel.icon_url
                    model.conversationType = .ConversationType_GROUP
                    model.targetId = groupModel.groupid
                    model.conversationTitle = groupModel.group_name
                    model.unreadMessageCount = 0
                    model.isTop = false
                    model.topCellBackgroundColor = UIColor.hexString(hexString: "F6F6F6")
                    model.cellBackgroundColor = UIColor.white
                    model.receivedStatus = .ReceivedStatus_UNREAD
                    model.sentStatus = .SentStatus_SENDING
                    model.receivedTime = 0
                    model.sentTime = 0
                    model.draft = ""
                    model.objectName = ""
                    model.senderUserId = ""
                    model.lastestMessageId = 0
                    model.lastestMessage = RCMessageContent.init()
                    model.lastestMessageDirection = .MessageDirection_SEND
                    model.jsonDict = nil
                    model.hasUnreadMentioned = false
                    dataSource.add(model)
                }
                
            }else {
                if groupModel.is_delete == "1" {

                    if dataSource.contains(where: { (m) -> Bool in
                        return (m as! RCConversationModel).targetId == groupModel.groupid
                    }) {
                         let models = dataSource.filtered(using: NSPredicate.init(format: "targetId == %@",groupModel.groupid))
                        dataSource.removeObjects(in: models)
                    }

                }
            }

        }
        self.conversationListDataSource = dataSource
        DispatchQueue.main.async {
             self.footLabel.text = "\(dataSource.count)个群组"
        }
        
        return dataSource
    }
    
    
    override func rcConversationListTableView(_ tableView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        return 64
    }
    override func rcConversationListTableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> RCConversationBaseCell! {
        let cell = GroupListCell.cell(withTableView: tableView)
        if self.conversationListDataSource.count > indexPath.row {
            print("conversationListDataSource count = \(self.conversationListDataSource.count)\n indexPath.row = \(indexPath.row)")
            cell.setDataModel((self.conversationListDataSource![indexPath.row] as! RCConversationModel))
        }
        
        return cell

    }
    override func didReceiveMessageNotification(_ notification: Notification!) {
      
        if notification.object is RCMessage {
            let message = notification.object as! RCMessage
//             if message.content is RCGroupNotificationMessage {
//           let groupMessage = model.content as! RCGroupNotificationMessage
//           if  groupMessage.operation == "Dismiss" {
//            message.targetId
//           }
//       }
            print(message)
        }
//        self.refreshConversationTableViewIfNeeded()
    }
    
    
    /*!
    左滑删除自定义会话时的回调

    @param tableView       当前TabelView
    @param editingStyle    当前的Cell操作，默认为UITableViewCellEditingStyleDelete
    @param indexPath       该Cell对应的会话Cell数据模型在数据源中的索引值

    @discussion 自定义会话Cell在删除时会回调此方法，您可以在此回调中，定制删除的提示UI、是否删除。
    如果确定删除该会话，您需要在调用RCIMClient中的接口删除会话或其中的消息，
    并从conversationListDataSource和conversationListTableView中删除该会话。
    */
    override func rcConversationListTableView(_ tableView: UITableView!, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath!) {
        
        let model = self.conversationListDataSource![indexPath.row] as! RCConversationModel;
        RCIMClient.shared()?.deleteMessages(model.conversationType, targetId: model.targetId, success: {
            DispatchQueue.main.async {
                
                let groupModels = GroupModel.objects(with: NSPredicate.init(format: "groupid == %@",(model.targetId)!))
                
                var groupModel:GroupModel?
                if groupModels.count > 0 {
                    groupModel = (groupModels.firstObject() as! GroupModel)
                    DataOperation.removeData(rlmObject: groupModel)
                }
                
                self.conversationListDataSource.removeObject(at: indexPath.row)
                self.footLabel.text = "\(self.conversationListDataSource.count)个群组"
                self.conversationListTableView.reloadData()
            }
        
        }, error: { (erroCode) in
            
        })
    }
    
//    - (void)rcConversationListTableView:(UITableView *)tableView
//                     commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
//                      forRowAtIndexPath:(NSIndexPath *)indexPath;
//
   
    /*
    //MARK: --------------------------- Getter and Setter --------------------------
    /// tableview
    fileprivate lazy var mainTableView : UITableView = {
        var mainTabView : UITableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        mainTabView.backgroundColor = UIColor.groupTableViewBackground
        mainTabView.rowHeight   = 64
        mainTabView.dataSource  = self
        mainTabView.delegate    = self
        return mainTabView
    }()
     */
    lazy var footView: UIView = {
        var footView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        var separateLine : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0.5))
        separateLine.backgroundColor = separateLine_Color
        footView.addSubview(separateLine)
        footView.addSubview(self.footLabel)
        return footView
    }()

    lazy var footLabel: UILabel = {
        var footLabel : UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        footLabel.font = FONT_14
        footLabel.textColor = UIColor.darkGray
        footLabel.textAlignment = .center
        return footLabel
    }()

    lazy var comboboxView: ComboboxView? = {
        var comboboxView = ComboboxView.init(titles: ["创建群组","查找群组"], imageNames: [["group_add","search_white"],["group_add","search_white"]], bgImgName: "combobox", frame: CGRect.init(x: SCREEN_WIDTH - 100 - 10, y: 64, width: 100, height: (oneRow_height * 2 + TOP_PADDING + 1)))
        comboboxView.delegate = self
        return comboboxView
    }()
}

extension GroupListViewController : ComboboxViewDelegate {

    func comboboxViewOneRowClick(button: UIButton) {
        switch button.tag {
        case 10:
            //创建群组
//            GroupCreateVC,GroupMemberVC
            let addMemeberVc = GroupCreateVC()
//            addMemeberVc.isCreatGroup = true
//            addMemeberVc.resultWithArray { (resultArray) in
//
//            }
            self.navigationController?.pushViewController(addMemeberVc, animated: true)
        case 11:
            
            //搜索群组
            let search = GroupSearchVC()
            self.navigationController?.pushViewController(search, animated: true)
            
            
            
            break
            
        default:
            break
        }
    }
}
/*
//MARK: --------------------------- TableViewDelegate TableViewDataSource --------------------------
extension GroupListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GroupListCell.cell(withTableView: tableView)
        cell.model = String(indexPath.row + 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        RCIM.shared().initWithAppKey("m7ua80gbm7bgm")
//        RCIM.shared().connect(withToken: "MjQqsfL9QMLYUd2X3XTT/1B2V+2Y3XGjyhArGfi6/pMfyDKJUVq0bT/evBgpGQxSXva54fobkQu8Ck4pHtVifw==", success: { (userId) in
//            print("登陆成功。当前登录的用户ID：\(userId)")
//            let rcb = RCConversationViewController.init(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: "2222")
//            DispatchQueue.main.async {
//                self.navigationController?.pushViewController(rcb!, animated: true)
//            }
//        }, error: { (status) in
//            print("登陆的错误码为:\(status)")
//        }) {
//            print("token错误")
//        }
        //新建一个聊天会话View Controller对象,建议这样初始化
        let groupChat = RongTestVC.init(conversationType: .ConversationType_GROUP, targetId: "qunzu1")
        //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
//        chat.conversationType = ConversationType_PRIVATE;
        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
//        chat.targetId = @"targetIdYouWillChatIn";
        
        //设置聊天会话界面要显示的标题
        groupChat?.title = "群组1"
        //显示聊天会话界面
       self.navigationController?.pushViewController(groupChat!, animated: true)
    }
}
*/
