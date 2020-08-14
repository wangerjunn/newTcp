//
//  DataOperation.swift
//  GroupChatPlungSwiftPro
//
//  Created by 柴进 on 2017/3/21.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class DataOperation: DataBaseOperation {
    class func saveInitData(success:@escaping (_ success:Dictionary<String, Any>) ->()) -> (Dictionary<String, Any>) ->() {
        func temp(dic:Dictionary<String, Any>) ->(){
            
            DataBaseOperation.addDataWithArray(rlmObjects: dic["groupList"] as! Array<Any>, aClass: GroupModel.self)
            
            DataBaseOperation.addDataWithArray(rlmObjects: dic["groupUserList"] as! Array<Any>, aClass: GroupUserModel.self)
            DataBaseOperation.addDataWithArray(rlmObjects: dic["userList"] as! Array<Any>, aClass: FriendsModel.self)
            success(dic)
        }
        return temp
    }
    
    
    
    class func saveFriendsData(success:@escaping (_ success:Dictionary<String, Any>) ->()) -> (Dictionary<String, Any>) ->() {
        
        
        func temp(dic:Dictionary<String, Any>) ->(){
            
            print(dic)
            DataBaseOperation.addDataWithArray(rlmObjects: dic["list"] as! Array<Any>, aClass: FriendsModel.self)
            
        }
         return success
    }
    
    
    class func saveUserListData(success:@escaping (_ success:Dictionary<String, Any>) ->()) -> (Dictionary<String, Any>) ->() {
        
        
        func temp(dic:Dictionary<String, Any>) ->(){
            
            print(dic)
            DataBaseOperation.addDataWithArray(rlmObjects: dic["user_list"] as! Array<Any>, aClass: FriendsModel.self)
            
        }
         return success
    }

}
