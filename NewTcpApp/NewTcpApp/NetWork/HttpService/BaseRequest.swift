//
//  BaseRequest.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/2.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit


let manager = AFHTTPSessionManager.init(sessionConfiguration: URLSessionConfiguration.default)

class BaseRequest: NSObject {
    
   
    
   
    //MARK:----------------------AF网络请求相关----------------------
    
    public static func initManager()->(AFHTTPSessionManager)
    {
        
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
//            [NSSet setWithObject:@"text/html"]
        return manager
    }
    

    //MARK:----------------------POST请求先关----------------------
    /// post请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 请求参数
    ///   - hadToast: 是否添加提醒
    ///   - fail: 失败返回闭包(返回空闭包)
    ///   - success: 成功返回闭包
    public static func basePost(url:String,params:Dictionary<String, Any>,hadToast:Bool,fail:@escaping ( _ err:Error) ->() ,success:@escaping (_ success:Dictionary<String, Any>) ->())
    {
       let manager = self.initManager()
        let task:URLSessionDataTask? =  manager.post(url, parameters: params, headers: nil, progress: nil, success: { (task:URLSessionDataTask, any:Any) in
         if any is Dictionary<String, Any>{
            
             //TODO:(harry标注)-- 等接口能用的时候 考虑是否只返回 data中的数据
             success(any as! Dictionary<String, Any>)
         }else{
            let str = String.init(data: any as! Data, encoding: String.Encoding.utf8)
            print(str ?? "")
            let dic = try?JSONSerialization.jsonObject(with: any as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
            if String.changeToString(inValue: dic?["code"] ?? "2") == "1" {
                if dic?["data"] is Dictionary<String, Any>{
                    success(dic?["data"] as! Dictionary<String, Any>)
                }else{
                    if dic != nil {
                        success(dic!)
                    }
                }
            }else{
                print(String.changeToString(inValue: dic?["msg"] ?? "错了"))
                if dic != nil {
                    success(dic!)
                }
                
            }
//            [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding]
            
        }
        }) { (task:URLSessionDataTask?,err:Error) in
            
           fail(err)
           print(err.localizedDescription.description )
        }
        task?.resume()
    }
    
    
    
    
    //MARK:----------------------Json 与 String 互转----------------------
    
    /// 将类转化为json串
    ///
    /// - Parameter object: 需要转化的类
    /// - Returns: 返回转换后的json串
    public static func makeJsonStringWithObject(object:Any)->(String)
    {
        let result :Data = try! JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonStr:String = String.init(data: result, encoding: .utf8)!
       return jsonStr
    }
    
    
    /// 将json串转成类
    ///
    /// - Parameter jsonStr: 需要转化的json串
    /// - Returns: 返回转换后的类
    public static func makeJsonWithString(jsonStr:String)->(Any)
    {
        let data:Data = jsonStr.data(using: .utf8)!
        let result = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        return result
    }
    
    
    
    //MARK:----------------------MD5加密----------------------
    
    /// MD5 加密
    ///
    /// - Parameter str: 需要加密的字符串
    /// - Returns: MD5加密后的字符串
    public static func md5StringFromString(str:String)->(String?)
    {
        guard !str.isEmpty  else {
            return nil
        }
        
        let cStr = str.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    
    
   //MARK:----------------------其他相关----------------------
    
   /// 获取当前所在的最前边的UIViewController
   ///
   /// - Returns: 返回
   public static func appTopController() ->(UIViewController)
    {
        let appRoot = UIApplication.shared.keyWindow?.rootViewController
        var topVC = appRoot
        while ((topVC?.children) != nil) {
            if topVC! is UITabBarController {
                topVC = (topVC! as! UITabBarController).selectedViewController
            }
            else if topVC! is UINavigationController
            {
               topVC = (topVC! as! UINavigationController).visibleViewController
            }
            else
            {
                break
            }
        }
        
        return topVC!
    }
    
    
    
    /// 错误提醒
    ///
    /// - Parameters:
    ///   - code: 错误码
    ///   - message: 错误具体信息
    public static func analysisFailMessage(code:String,message:String)->()
    {
    
    
    }
}
