//
//  GroupQRCodeViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/23.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class GroupQRCodeViewController: BaseViewController {

    var groupModel:GroupModel?{
        
        didSet {
            
            self.getQrCodeWithGroupId(id: (groupModel?.groupid)!)
            headerImageView.sd_setImage(with: NSURL.init(string: groupModel?.icon_url != nil ? (groupModel?.icon_url)!  : " ") as URL?, placeholderImage: UIImage.init(named: "mine_avatar"))
            groupNameLabel.text = groupModel?.group_name
            let currentDate : Date = Date()
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M月d日"
            let endDate : Date = Date.init(timeInterval: 7*24*60*60, since: currentDate)
            let endDateStr : String = dateFormatter.string(from: endDate)

            bottomLabel.text = "该二维码7天内(\(endDateStr)前)有效,重新进入将更新"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.darkGray
        self.title = "群二维码名片"
        
        self.view.addSubview(bgView)
        bgView.addSubview(headerImageView)
        bgView.addSubview(groupNameLabel)
        bgView.addSubview(seperateLine)
        bgView.addSubview(qrCodeImageView)
        bgView.addSubview(bottomLabel)
        
        bgView.mas_makeConstraints { (make) in
            make!.left.equalTo()(20)
            make!.right.equalTo()(-20)
            make!.top.equalTo()(NAV_HEIGHT + 80)
            make!.bottom.equalTo()(-120)
        }
        headerImageView.mas_makeConstraints { (make) in
            make!.left.equalTo()(20)
            make!.top.equalTo()(20)
            make!.size.equalTo()(CGSize.init(width: 45, height: 45))
        }
        groupNameLabel.mas_makeConstraints { [unowned self](make) in
            make!.left.equalTo()(self.headerImageView.mas_right)!.offset()(10)
            make!.right.equalTo()(-20)
            make!.centerY.equalTo()(self.headerImageView)
        }
        seperateLine.mas_makeConstraints { [unowned self](make) in
            make!.left.equalTo()(self.headerImageView)
            make!.right.equalTo()(-20)
            make!.top.equalTo()(self.headerImageView.mas_bottom)!.offset()(15)
            make!.height.equalTo()(0.5)
        }
        qrCodeImageView.mas_makeConstraints { (make) in
            make!.left.equalTo()(50)
            make!.top.equalTo()(self.headerImageView.mas_bottom)!.offset()(30)
            make!.right.equalTo()(-50)
            make!.height.equalTo()(SCREEN_WIDTH - 40 - 100)
        }
        bottomLabel.mas_makeConstraints { [unowned self](make) in
            make!.centerX.equalTo()(self.bgView)
            make!.top.equalTo()(self.qrCodeImageView.mas_bottom)!.offset()(20)
        }
    }
    func getQrCodeWithGroupId(id:String){
        
        var params = Dictionary<String, Any>()
        params["app_token"] = sharePublicDataSingle.token
        params["groupid"] = id
        GroupRequest.getQrCode(params: params, hadToast: true, fail: { (error) in
            
        }) { [weak self](success) in
            if let strongSelf = self{
                
                if let code = success["code"] {
                    if "\(code)" != "1" {
                        self?.showAlert(content: success["msg"] as! String)
                        return
                    }
                }
                strongSelf.qrCodeImageView.sd_setImage(with: NSURL.init(string: (success["qr_url"] as? String) != nil ? success["qr_url"] as! String : " ") as URL?, placeholderImage: UIImage.init(named: "mine_avatar"))
            }
        }
        
    }
    
    fileprivate lazy var bgView: UIView = {
        var bgView = UIView.init()
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 2
        return bgView
    }()
    fileprivate var headerImageView: UIImageView = {
        var headerImageView = UIImageView.init()
        headerImageView.layer.cornerRadius = 4.0
        return headerImageView
    }()
    fileprivate var groupNameLabel: UILabel = {
        var groupNameLabel = UILabel.init()
        groupNameLabel.textColor = UIColor.black
        groupNameLabel.font = FONT_16
        return groupNameLabel
    }()
    fileprivate var seperateLine: UIView = {
        var seperateLine = UIView.init()
        seperateLine.backgroundColor = UIColor.lightGray
        return seperateLine
    }()
    fileprivate var qrCodeImageView: UIImageView = {
        var qrCodeImageView = UIImageView.init()
        return qrCodeImageView
    }()
    fileprivate var bottomLabel: UILabel = {
        var bottomLabel = UILabel.init()
        bottomLabel.textColor = UIColor.darkGray
        bottomLabel.font = FONT_12
        return bottomLabel
    }()

}
