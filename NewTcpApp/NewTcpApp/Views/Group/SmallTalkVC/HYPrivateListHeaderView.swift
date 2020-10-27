//
//  HYPrivateListHeaderView.swift
//  SLAPP
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018 柴进. All rights reserved.
//
import UIKit
class HYPrivateListHeaderView: UIView {
//    let search = RCDSearchBar.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
//    存放cell 的数组
    var subCellArray:Array<GroupListCell> = Array()
//    cell 点击后的闭包响应
    var cellClickWithTargetId:(_ id:String,_ name:String)->() = { (id,name) in
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.groupTableViewBackground
        self.configUI();
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func fillSubViews(datas:Array<Dictionary<String,String>>){
        func makeCell() -> GroupListCell{
            let cell = GroupListCell.init(style: .default, reuseIdentifier: "cell")
            cell.backgroundColor = UIColor.white
            cell.badgeLb.isHidden = true
            //cell.frame = CGRect.init(x: 0, y: 44+65*i, width: Int(kScreenW), height: 65);
            cell.addSubview(makeCellLine())
            cell.addSubview(makeCellBtn())
            return cell
        }
        func makeCellLine() -> UIView{
            let line = UIView.init(frame: CGRect(x: 15, y: 65-0.3, width: kScreenW-15, height: 0.3))
            line.backgroundColor = UIColor.groupTableViewBackground
            return line
        }
        func makeCellBtn() -> UIButton{
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 65)
            btn.addTarget(self, action: #selector(btnClick(btn: )), for: .touchUpInside)
            return btn
        }
    }
    func configUI(){
//        self.addSubview(search)
//        let targetIdArray = ["systemMessage"]
        let imageArray = ["commenticon"]
        let titleArray = ["系统消息"]
        for i in 0..<titleArray.count {
            let cell = GroupListCell.init(style: .default, reuseIdentifier: "cell")
            cell.backgroundColor = UIColor.white
            cell.frame = CGRect.init(x: 0, y: 65*i, width: Int(kScreenW), height: 65);
            cell.headerImageView.image = UIImage.init(named: imageArray[i])
            cell.nameLabel.text = titleArray[i]
            cell.detailLabel.text = "暂时没有新消息"
            let line = UIView.init(frame: CGRect(x: 15, y: 65-0.3, width: kScreenW-15, height: 0.3))
            cell.addSubview(line)
            line.backgroundColor = UIColor.groupTableViewBackground
            self.addSubview(cell)
//            cell.customTargetId = targetIdArray[i]
            subCellArray.append(cell)
            cell.badgeLb.isHidden = true
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 65)
            cell.addSubview(btn)
            btn.addTarget(self, action: #selector(btnClick(btn: )), for: .touchUpInside)
        }
    }
    @objc func btnClick(btn:UIButton){
        if btn.superview!.isKind(of: GroupListCell.self) {
            let cell:GroupListCell = btn.superview as! GroupListCell
            self.cellClickWithTargetId("group_system",cell.nameLabel.text!)
        }
    }
          func refresh(){
        for cell in subCellArray {
            DispatchQueue.global(qos: .default).async
         {
//               查询该回话类型对应的最新的一条消息
                
                let subArray = RCIMClient.shared().getLatestMessages(RCConversationType.ConversationType_SYSTEM, targetId: "group_system", count: 1)
                if !(subArray?.isEmpty)!
                {
                    let model:RCMessage = subArray!.first! as! RCMessage;
                    if model.content .isKind(of: RCTextMessage.self)
                    {
                        DispatchQueue.main.async {
                            cell.detailLabel.text = (model.content as! RCTextMessage).content
                        }
                    }
                    DispatchQueue.global(qos: .default).async{
//                        查询未读数
                        if(RCIMClient.shared().getUnreadCount(RCConversationType.ConversationType_SYSTEM, targetId: "group_system") == 0){
                            DispatchQueue.main.async {
                                cell.badgeLb.isHidden = true
                            }
                        }else{
                            DispatchQueue.main.async {
                                cell.badgeLb.isHidden = false
                            }
                        }
                    }
                 }
         }
    }
 }
}
