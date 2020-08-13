//
//  ApplyJoinGroupViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/16.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class ApplyJoinGroupViewController: BaseViewController {

    var groupModel:GroupModel?
    var isAuthCode : Bool? //是否是验证码入群
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "申请加群"
        isAuthCode = true
        
        self.setRightBtnWithArray(items: ["发送"])
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(inputTextView)
        self.view.addSubview(bottomBtn)
        inputTextView.mas_makeConstraints { (make) in
            make!.left.equalTo()(15)
            make!.top.equalTo()(NAV_HEIGHT + 15)
            make!.width.equalTo()(SCREEN_WIDTH - 15 * 2)
            make!.height.equalTo()(inputTV_height_MIN)
        }
        bottomBtn.mas_makeConstraints { [unowned self](make) in
            make!.right.equalTo()(-15)
            make!.top.equalTo()(self.inputTextView.mas_bottom)!.offset()(5)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func rightBtnClick(button: UIButton) {
        if isAuthCode! {
            GroupRequest.groupJoinByCode(params: ["app_token":sharePublicDataSingle.token,"groupid":groupModel?.groupid,"auth_code":inputTextView.text], hadToast: true, fail: { (error) in
                
            }, success: { (dic) in
                if let code = dic["code"] {
                    if "\(code)" != "1" {
                        self.showAlert(content: dic["msg"] as! String)
                        return
                    }
                }
                self.navigationController!.popViewController(animated: true)
            })
        }else{
            GroupRequest.groupJoinApply(params: ["app_token":sharePublicDataSingle.token,"groupid":groupModel?.groupid,"msg":inputTextView.text], hadToast: true, fail: { (error) in
                
            }, success: { (dic) in
                if let code = dic["code"] {
                    if "\(code)" != "1" {
                        self.showAlert(content: dic["msg"] as! String)
                        return
                    }
                }
                self.navigationController!.popViewController(animated: true)
            })
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputTextView.endEditing(true)
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    fileprivate lazy var inputTextView: ApplyJoinGroupTextView = {
        var inputTextView = ApplyJoinGroupTextView.init(frame: CGRect.init(x: 15, y: NAV_HEIGHT + 15, width: SCREEN_WIDTH - 15 * 2, height: inputTV_height_MIN), textContainer: nil)
        inputTextView.placeholder = "请输入群组验证码,直接入群"
        return inputTextView
    }()
    
    fileprivate lazy var bottomBtn: UIButton = {
        var bottomBtn = ApplyJoinGroupBottomBtn.init()
        bottomBtn.setTitle("没有群组验证码点击这里~~", for: .normal)
        bottomBtn.setTitleColor(UIColor.hexString(hexString: "2183DE"), for: .normal)
        bottomBtn.titleLabel?.font = FONT_14
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        return bottomBtn
    }()
}
extension ApplyJoinGroupViewController {
    @objc func bottomBtnClick(button:UIButton) {
        inputTextView.text = ""
        inputTextView.placeholderLabel.isHidden = false
        if (button.titleLabel?.text?.contains("没有"))! {
            isAuthCode = false
            inputTextView.placeholder = "请输入您的附加信息:"
             bottomBtn.setTitle("我有群组验证码点击这里~~", for: .normal)
            inputTextView.mas_updateConstraints({ (make) in
                make!.height.equalTo()(inputTV_height_MAX)
            })
        }else{
            isAuthCode = true
            inputTextView.placeholder = "请输入群组验证码,直接入群"
             bottomBtn.setTitle("没有群组验证码点击这里~~", for: .normal)
            inputTextView.mas_updateConstraints({ (make) in
                make!.height.equalTo()(inputTV_height_MIN)
            })
        }
    }
}

