//
//  GroupSettingWithSwitchCell.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/9.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

protocol GroupSettingWithSwitchCellDelegate {
    func onClickSwitchButton(swich:UISwitch, title:String)
}
class GroupSettingWithSwitchCell: UITableViewCell {

    var delegate : GroupSettingWithSwitchCellDelegate?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(swich)
        
        titleLabel.mas_makeConstraints { [unowned self](make) in
            make!.left.equalTo()(LEFT_PADDING_GS)
            make!.centerY.equalTo()(self)
        }
       
        swich.mas_makeConstraints { [unowned self](make) in
            make!.right.equalTo()(-LEFT_PADDING_GS)
            make!.centerY.equalTo()(self)
        }
        
    }
    
    var model: Any? {
        didSet{
            titleLabel.text = (model as! Dictionary<String, Any>).first?.key
            swich.isOn = String.changeToString(inValue: (model as! Dictionary<String, Any>).first?.value) == "1"
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cell(withTableView tableView: UITableView) -> GroupSettingWithSwitchCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? GroupSettingWithSwitchCell
        if cell == nil {
            cell = GroupSettingWithSwitchCell.init(style: .default, reuseIdentifier: String(describing: self))
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    @objc func onClickSwitch(swich:UISwitch, title:String) {
        delegate?.onClickSwitchButton(swich:swich, title: titleLabel.text!)
    }
    //MARK: - Getter and Setter
    //标题
    fileprivate lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = FONT_16
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    //开关
    lazy var swich: UISwitch = {
        var swich = UISwitch()
        swich.addTarget(self, action: #selector(onClickSwitch(swich:title:)), for: .valueChanged)
        return swich
    }()
}
