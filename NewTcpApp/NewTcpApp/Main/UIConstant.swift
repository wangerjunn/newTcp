//
//  UIConstant.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/2.
//  Copyright © 2017年 柴进. All rights reserved.
//

import Foundation

// 屏幕宽高
let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.width
let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.height

let kGreenColor = UIColor.hexString(hexString: "43be5f")
let ispX:Bool = UIScreen.main.bounds.height == 812 ? true :false
//false 在px 上全屏不包含tab最下边的安全区  true 为相反   其他机型还是全屏
let MAIN_SCREEN_HEIGHT_PX = ispX ? false ? SCREEN_HEIGHT : SCREEN_HEIGHT - 34  : SCREEN_HEIGHT


//屏幕适配
func kReal(value : CGFloat) -> CGFloat { return value / 375 * SCREEN_WIDTH }
func kRealHeight(value : CGFloat) -> CGFloat { return value / 667 * SCREEN_HEIGHT }
func kRealFont(value : CGFloat) -> CGFloat { return value / 667 * SCREEN_HEIGHT }
let NAV_HEIGHT : CGFloat = 44.0 + UIApplication.shared.statusBarFrame.size.height                  //导航栏高度
let kFakeTab_HEIGHT : CGFloat = 56.0              //假tab高度
let kNavBackWidth : CGFloat = 30.0               //返回按钮高度
let kNavBackHeight : CGFloat = 30.0               //返回按钮高度

// 字体
let FONT_10 : UIFont = UIFont.systemFont(ofSize: 10)
let FONT_11 : UIFont = UIFont.systemFont(ofSize: 11)
let FONT_12 : UIFont = UIFont.systemFont(ofSize: 12)
let FONT_14 : UIFont = UIFont.systemFont(ofSize: 14)
let FONT_16 : UIFont = UIFont.systemFont(ofSize: 16)
let FONT_18 : UIFont = UIFont.systemFont(ofSize: 18)

// tableView分割线颜色
let separateLine_Color : UIColor = UIColor.hexString(hexString:"D1D1D1")
//群组头像borderColor
let headerBorderColor : String = "C5C5C5"

// 间距
//MARK: - GroupListCell
let LEFT_PADDING : CGFloat = 10.0

//MARK: - GroupSettingWithArrowCell AND GroupSettingWithSwitchCell
let LEFT_PADDING_GS : CGFloat = 15.0
let LEFT_PADDING_BIG : CGFloat = LEFT_PADDING_GS + 25.0
//MARK: - GroupNameEditTextField
let inputTF_height : CGFloat = 40.0

//MARK: - ApplyJoinGroupTextView
let inputTV_height_MIN : CGFloat = 40.0
let inputTV_height_MAX : CGFloat = 120.0

//MARK: - ComboboxView
let TOP_PADDING : CGFloat = 3.0
let oneRow_height : CGFloat = 44.0

//MARK: - BaseSearchView
let searchView_height : CGFloat = 50.0

//MARK: - publicKey
let getRemoteKey:String = "getRemoteKey"
