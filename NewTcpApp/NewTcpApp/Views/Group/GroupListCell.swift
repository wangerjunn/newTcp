//
//  GroupListCell.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/1.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit
private let headerImageViewWidth : CGFloat = 44.0
class GroupListCell: RCConversationBaseCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(headerImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(detailLabel)

        headerImageView.mas_makeConstraints { (make) in
            make!.top.left().equalTo()(LEFT_PADDING)
            make!.size.equalTo()(CGSize(width: headerImageViewWidth, height: headerImageViewWidth))
        }
        nameLabel.mas_makeConstraints { [unowned self](make) in
            make!.top.equalTo()(self.headerImageView)
            make!.left.equalTo()(self.headerImageView.mas_right)!.offset()(LEFT_PADDING)
            make!.right.equalTo()(self.timeLabel.mas_left)!.offset()(-LEFT_PADDING)
        }
        timeLabel.mas_makeConstraints { [unowned self](make) in
            make!.top.equalTo()(self.headerImageView)
            make!.right.equalTo()(-LEFT_PADDING)
        }
        detailLabel.mas_makeConstraints { [unowned self](make) in
            make!.left.equalTo()(self.nameLabel)
            make!.right.equalTo()(-LEFT_PADDING)
            make!.bottom.equalTo()(self.headerImageView)
        }
    }
    override var model: RCConversationModel!{
        didSet {
            
//            let imageViewsCount : Int = model.extend != nil ? (model.extend as! NSMutableArray).count : 0
//            var imageViews : Array<Any> = []
//            for _ in 0..<imageViewsCount {
//                let imageView = UIImageView()
//                imageView.backgroundColor = UIColor.darkGray
//                imageViews.append(imageView)
//            }
            self.backgroundColor = model.isTop ? model.topCellBackgroundColor : model.cellBackgroundColor

            self.headerImageView.sd_setImage(with: NSURL.init(string: model.extend != nil ? model.extend as! String : " ") as URL?, placeholderImage: UIImage.init(named: "mine_avatar"))
//            self.headerImageView.stitchingOnImageView(imageViews: imageViews)
            self.headerImageView.badgeCenterOffset = CGPoint(x : -2, y : 0)

            if model.unreadMessageCount > 0 {
                self.headerImageView.showBadge(with: .redDot, value: model.unreadMessageCount, animationType: .none)
            }else{
                self.headerImageView.clearBadge()
            }
            
            if model.receivedTime == 0 {
                self.timeLabel.text = ""
            }else{
                let target : Date = Date.init(timeIntervalSince1970: TimeInterval(model.receivedTime / 1000))
                self.timeLabel.text = self.convertDate(date: target)
            }
            self.timeLabel.sizeToFit()
            timeLabel.mas_updateConstraints { [unowned self](make) in
                make!.width.equalTo()(self.timeLabel.frame.size.width)
            }

            self.nameLabel.text = model.conversationTitle
            
            if model.objectName.count > 0 {
                var unreadMessageCountStr : String?
                if model.unreadMessageCount > 1 {
                    unreadMessageCountStr = model.unreadMessageCount > 99 ? "[99条+]" : "[\(model.unreadMessageCount)条]"
                }else{
                    unreadMessageCountStr = ""
                }
                
                var lastSender : String?
                if model.senderUserId == "1" || model.senderUserId == sharePublicDataSingle.publicData.userid {
                    lastSender = nil
                }else{
                    
                    let groupUserModels = GroupUserModel.objects(with: NSPredicate.init(format:"userid == %@", model.senderUserId))
                    
                    var groupUserModel:GroupUserModel?
                    
                    if groupUserModels.count > 0 {
                        groupUserModel = groupUserModels.firstObject() as? GroupUserModel
                    }
//                    let groupUserModel = GroupUserModel.objects(with: NSPredicate.init(format:"userid == %@", model.senderUserId)).firstObject() as? GroupUserModel
                    lastSender = groupUserModel?.realname
                }

//                RC:CmdMsg  RC:CmdNtf  RC:InfoNtf RCTextMessageTypeIdentifier RC:GrpNtf
                
                var lastMessage : String!
                switch model.objectName {
                case "RC:TxtMsg":
                    lastMessage = model.lastestMessage.conversationDigest()
                case "RC:VcMsg":
                    lastMessage = "[语音]"
                case "RC:ImgMsg":
                    lastMessage = "[图片]"
                case "RC:LBSMsg":
                    lastMessage = "[位置]"
                case "RC:FileMsg":
                    lastMessage = "[文件]"
                case "RC:ImgTextMsg","RC:PSMultiImgTxtMsg","RC:PSImgTxtMsg":
                    lastMessage = "[图文]"
                case "RC:GrpNtf":
                    if model.lastestMessage is RCGroupNotificationMessage {
                        let message = model.lastestMessage as! RCGroupNotificationMessage
                        lastMessage = message.message
                        
                        if model.conversationTitle == nil && message.operation == "Create" {
                            let jsonData:Data = message.data.data(using: .utf8)!
                            
                            let groupInfo = try? (JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Dictionary<String,Any>)
                            self.nameLabel.text = groupInfo!["targetGroupName"] as? String
                        }
                    }
                    
                default:
                    
                    lastMessage = ""
                    if model.lastestMessage.responds(to: #selector(RCMessageContentView.conversationDigest)) {
                        lastMessage = model.lastestMessage.conversationDigest()
                    }
            
                    break
                }
                self.detailLabel.text = unreadMessageCountStr! + (lastSender == nil ? "" : (lastSender! + " : ")) + lastMessage
            }
        }
    }
    /*
    var model : String! {
        didSet {
        
            let imageViewsCount : Int = Int(model)!
            var imageViews : Array<Any> = []
            for _ in 0..<imageViewsCount {
                let imageView = UIImageView()
                imageView.backgroundColor = UIColor.darkGray
                imageViews.append(imageView)
            }
            self.headerImageView.stitchingOnImageView(imageViews: imageViews)
            self.headerImageView.badgeCenterOffset = CGPoint(x : -2, y : 0)
            if imageViewsCount == 1 {
                
                self.headerImageView.showBadge(with: .redDot, value: imageViewsCount, animationType: .none)
            }else if imageViewsCount == 9 {
                self.headerImageView.showBadge(with: .number, value: 100, animationType: .none)
            }else{
                self.headerImageView.showBadge(with: .number, value: imageViewsCount, animationType: .none)
            }
            let targetStr = "2017-02-28 16:00"
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let targetD = dateFormatter.date(from: targetStr)
            self.timeLabel.text = self.convertDate(date: targetD!)
            self.timeLabel.sizeToFit()
            timeLabel.mas_updateConstraints { [unowned self](make) in
                make!.width.equalTo()(self.timeLabel.frame.size.width)
            }
            self.nameLabel.text = "群组名称群组名称群组名称群组名称群组名称"
//            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:modelStr];
//            NSString *str = [[modelStr componentsSeparatedByString:@":"].firstObject stringByAppendingString:@":"];
//            NSRange range = [modelStr rangeOfString:str];
//            
//            [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
//            
//            self.lbDetail.attributedText = attrStr;
            let detailText = "[有人@我]消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容"
            let attrStr : NSMutableAttributedString = NSMutableAttributedString.init(string: detailText)
            let attrText : String = "[有人@我]"
            attrStr.addAttributes([NSForegroundColorAttributeName:UIColor.red], range: NSRange.init(location: 0, length: attrText.characters.count))
            self.detailLabel.attributedText = attrStr
        }
    }
 */
    func convertDate(date:Date) -> String {
        if Date.isToday(target: date) {
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }else if Date.isLastDay(target: date) {
            return "昨天"
        }else if Date.isOneWeek(target: date) {
            return Date.weekWithDateString(target: date)
        }else{
            return Date.formattDay(target: date)
        }
    }
    class func cell(withTableView tableView: UITableView) -> GroupListCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? GroupListCell
//        if cell == nil {
//            cell = GroupListCell.init(style: .default, reuseIdentifier: String(describing: self))
//            cell?.selectionStyle = .none
//        }
        let cell = GroupListCell.init(style: .default, reuseIdentifier: String(describing: self))
        cell.selectionStyle = .none

        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Getter and Setter
    //头像
    fileprivate var headerImageView: StitchingImageView = {
        var headerImageView = StitchingImageView.init(frame: CGRect(x: 0, y: 0, width: headerImageViewWidth, height: headerImageViewWidth))
        headerImageView.layer.cornerRadius = 4.0
        return headerImageView
    }()
    
    //名称
    fileprivate lazy var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.font = FONT_14
        nameLabel.textColor = UIColor.black
        return nameLabel
    }()
    
    //时间
    fileprivate lazy var timeLabel: UILabel = {
        var timeLabel = UILabel()
        timeLabel.font = FONT_14
        timeLabel.textColor = UIColor.lightGray
        timeLabel.sizeToFit()
        return timeLabel
    }()
    
    //内容
    fileprivate lazy var detailLabel: UILabel = {
        var detailLabel = UILabel()
        detailLabel.font = FONT_14
        detailLabel.textColor = UIColor.lightGray
        return detailLabel
    }()
}
