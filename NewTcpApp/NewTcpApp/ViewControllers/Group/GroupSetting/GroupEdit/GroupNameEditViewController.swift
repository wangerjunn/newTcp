//
//  GroupNameEditViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/14.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class GroupNameEditViewController: BaseViewController {

    var groupModel:GroupModel?{
    
        didSet {
            
            inputTextField.text = groupModel?.group_name
            countLabel.text = "\((groupModel?.group_name.count)!)/10"

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "群组名称"
        
        self.setRightBtnWithArray(items: ["完成"])
        self.view.addSubview(inputTextField)
        self.view.addSubview(countLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func rightBtnClick(button: UIButton) {
//        tcp.group.update
//        app_token
//        groupid
//        group_name
        GroupRequest.update(params: ["app_token":sharePublicDataSingle.token,"groupid":groupModel?.groupid,"group_name":inputTextField.text], hadToast: true, fail: { (error) in
            
        }) { [weak self](dic) in
            
            if let code = dic["code"] {
                if "\(code)" != "1" {
                    self?.showAlert(content: dic["msg"] as! String)
                    return
                }
            }
            if let strongSelf = self {
                let realm:RLMRealm = RLMRealm.default()
                realm.beginWriteTransaction()
                strongSelf.groupModel?.setValue(strongSelf.inputTextField.text, forKey: "group_name")
                try? realm.commitWriteTransaction()
                strongSelf.navigationController!.popViewController(animated: true)
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputTextField.endEditing(true)
    }
    //MARK: --------------------------- Getter and Setter --------------------------
    fileprivate lazy var inputTextField: GroupNameEditTextField = {
        var inputTextField = GroupNameEditTextField.init(placeholder: "请输入群组名称")
        inputTextField.frame = CGRect.init(x: 15, y: NAV_HEIGHT + 15, width: SCREEN_WIDTH - 15 * 2, height: inputTF_height)
        inputTextField.delegate = self
        return inputTextField
    }()
    
    fileprivate lazy var countLabel: UILabel = {
        var countLabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH - 15 - 40, y: NAV_HEIGHT + 15 + inputTF_height + 5, width: 40, height: 30))
        countLabel.font = FONT_14
        countLabel.textColor = UIColor.gray
        countLabel.textAlignment = .right
        return countLabel
    }()
}
extension GroupNameEditViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var str = textField.text?.replacingCharacters(in: (textField.text?.changeToRange(from: range)!)!, with: string)
        if (str?.count)! > 10 {
            textField.text = str?.substring(to: (str?.index((str?.startIndex)!, offsetBy: 10))!)
            countLabel.text = "10/10"
            return false
        }
        countLabel.text = "\((str?.count)!)/10"
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        countLabel.text = "0/10"
        return true
    }
}
