//
//  BaseTableCell.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/13.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit
import Realm

protocol BaseCellDelegate {
    func cellRightBtnClick(model:RLMObject)
}

@objcMembers
class BaseTableCell: UITableViewCell {
    
    var delegate:BaseCellDelegate?
    
    @IBOutlet weak var imageLeftSpace: NSLayoutConstraint!

    @IBAction func BtnClick(_ sender: UIButton) {
        
        delegate?.cellRightBtnClick(model: self.model!)
    }
    @IBOutlet weak var rightBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var desLable: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var selectImage: UIImageView!
    
    var model:RLMObject?
    {
        didSet{
            
            if model is FriendsModel {
               let fModel  = model as! FriendsModel
               desLable.text = fModel.realname
               rightBtnWidth.constant = 60
               rightBtn.layer.borderWidth = 0.5
               rightBtn.layer.cornerRadius = 6
//                self.selectImage.isHidden = true
                if fModel.type == 1 {
                   rightBtn.layer.borderColor = UIColor.orange.cgColor
                   rightBtn.setTitleColor(UIColor.orange, for: .normal)
                   rightBtn.setTitle("互粉", for: .normal)
                }
                else if fModel.type == 2
                {
                    rightBtn.layer.borderColor = UIColor.green.cgColor
                    rightBtn.setTitleColor(UIColor.green, for: .normal)
                   rightBtn.setTitle("粉丝", for: .normal)
                }
            
                if !fModel.avater.isEmpty {
                   iconImage.sd_setImage(with: NSURL.init(string: fModel.avater) as URL?, placeholderImage: UIImage.init(named: "mine_avatar"))
                }
                else
                {
                     iconImage.image = UIImage.init(named: "mine_avatar")
                }

            }
            else if model is GroupUserModel{
                let fModel  = model as! GroupUserModel
                desLable.text = fModel.realname
                if !fModel.avater.isEmpty {
                    iconImage.sd_setImage(with: NSURL.init(string: fModel.avater) as URL?, placeholderImage: UIImage.init(named: "mine_avatar"))
                }
                else
                {
                    iconImage.image = UIImage.init(named: "mine_avatar")
                }
                rightBtn.isHidden = true
            }
            else if model is GroupModel {
//            group_name  user_num
                
                selectImage.isHidden = true
                self.imageLeftSpace.constant = -20
                self.rightBtn.setTitleColor(UIColor.white, for: .normal)
                self.rightBtn.backgroundColor = UIColor.hexString(hexString: "166AD9")
                
                
                let gModel = model as! GroupModel
                if !gModel.group_name.isEmpty {
                    
                let num = gModel.user_num.isEmpty ? "0" : gModel.user_num
                   desLable.text = String.init(format: "%@(%@)", gModel.group_name,num)
                }
               
               iconImage.image = UIImage.init(named: "mine_avatar")
            }
        }
    
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.backgroundColor = UIColor.groupTableViewBackground
        self.selectionStyle = .none
//        iconImage.backgroundColor = UIColor.red
        iconImage.layer.cornerRadius = iconImage.bounds.size.width/2
        iconImage.clipsToBounds = true
        
//        iconImage.image = UIImage.init(named: "mine_avatar")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
