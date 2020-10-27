//
//  PrivateListViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by 柴进 on 2018/2/13.
//  Copyright © 2018年 柴进. All rights reserved.
//

import UIKit

class PrivateListViewController: RCConversationListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configNav()
        view.backgroundColor = UIColor.white
        self.title = "单聊列表"
        
        self.isShowNetworkIndicatorView = true
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue])
        //        self.setCollectionConversationType([RCConversationType.ConversationType_PRIVATE.rawValue])
        self.showConnectingStatusOnNavigatorBar = true
        self.conversationListTableView.mj_header? = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction:#selector(headerRefresh))
        self.progressShow()
        self.getRemoteMessage(success: {
            self.progressDismiss()
        }, error: {
            self.progressDismiss()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func headerRefresh(){
        self.progressShow()
        self.getRemoteMessage(success: {
            self.progressDismiss()
        }, error: {
            self.progressDismiss()
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func willReloadTableData(_ dataSource: NSMutableArray!) -> NSMutableArray! {
        let arr = super.willReloadTableData(dataSource)
        let data = RCIMClient.shared().getConversationList([RCConversationType.ConversationType_PRIVATE.rawValue])
        print(arr)
        print(data)
        return arr
    }
    
    //重写RCConversationListViewController的onSelectedTableRow事件
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        //打开会话界面
        print(model)
        //        RCConversationViewController * rcc = [[RCConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:command.arguments[0]];
        //        rcc.title = command.arguments[1];
//        let rcc = RCConversationViewController.init(conversationType: model.conversationType, targetId: model.targetId)
        let rcc = SingleChatVC.init(conversationType: model.conversationType, targetId: model.targetId)
        self.navigationController?.pushViewController(rcc!, animated: true)
    }
    func getRemoteMessage(success: (() -> ())!, error: (() -> ())!) {
        let plist = PrivateUserModel.allObjects()
        var realArr : Array<String> = []
        for i in 0..<plist.count {
            realArr.append((plist[i] as! PrivateUserModel).id)
        }
        self.getRemoteHistoryMessages(from: 0, plist: realArr,successCount:0)
    }
    
    func getRemoteHistoryMessages(from:Int ,plist:Array<String>, successCount:Int) {
        
        if from == plist.count { //全部获取一遍并且有成功的(不能保证全部成功)
            self.progressDismiss()
            self.conversationListTableView.mj_header?.endRefreshing()
            if  successCount > 0 {//有成功的(不能保证全部成功)
                let arr = RCIMClient.shared().getConversationList([RCConversationType.ConversationType_PRIVATE.rawValue]) as NSArray
                for conversation in arr {
                    self.conversationListDataSource.add(RCConversationModel.init(conversation: (conversation as! RCConversation), extend: nil))
                }
                let username:String = sharePublicDataSingle.publicData.userid + sharePublicDataSingle.publicData.corpid
                UserDefaults.standard.set(false, forKey: getRemoteKey + username)
                self.refreshConversationTableViewIfNeeded()
            }
            return
        }
        let pId : String = plist[from]
        DispatchQueue.main.async {
            RCIMClient.shared().getRemoteHistoryMessages(.ConversationType_PRIVATE, targetId: pId, recordTime: 0, count: 5, success: { [weak self](array,success) in
                if let strongSelf = self {strongSelf.getRemoteHistoryMessages(from: from + 1, plist: plist,successCount:successCount + 1)}
                }, error: { [weak self](errorCode) in
                    if let strongSelf = self {
                        strongSelf.getRemoteHistoryMessages(from: from + 1, plist: plist,successCount:successCount)
                    }
            })
        }
    }
    
}
