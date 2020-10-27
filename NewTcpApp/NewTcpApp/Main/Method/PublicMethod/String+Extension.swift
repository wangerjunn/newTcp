//
//  String+Extension.swift
//  GroupChatPlungSwiftPro
//
//  Created by rms on 17/3/15.
//  Copyright © 2017年 柴进. All rights reserved.
//

import Foundation

extension String {
    
    ///   NSRange 转 Range<String.Index>
    ///
    /// - Parameter nsRange: <#nsRange description#>
    /// - Returns: <#return value description#>
    func changeToRange(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    
    /// Range<String.Index> 转 NSRange
    ///
    /// - Parameter range: <#range description#>
    /// - Returns: <#return value description#>
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
            if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
               return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
            }
            return NSRange.init()
    }
    
    func getTextHeight(font:UIFont,width:CGFloat) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    func getTextWidth(font:UIFont,height:CGFloat) -> CGFloat {
        
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
    func getSpaceLabelHeight(font:UIFont,width:CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = textLineSpace
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle], context: nil)
        return boundingBox.height
    }
    
    static func changeToString(inValue:Any) -> String {
        var str = ""
        if inValue is NSNumber {
            str = (inValue as! NSNumber).stringValue
        }else if inValue is String{
            str = inValue as! String
        }else if inValue is Float || inValue is Int{
            str = "\(inValue)"
        }
        
        return str
    }
    
    
    
    static func noNilStr(str:Any?)->(String){
        
        if str is NSNull {
            return ""
        }
        
        if str is NSNumber {
            
            return "\(str!)"
        }
        
        if str is String {
            if String(describing: str!) == "(null)"{
                return ""
            }
            return String(describing: str!)
        }
        
        if str == nil {
            return ""
        }
        
        return String(describing: str!)
    }
    
    func stringValueDic(_ str: String) -> [String : Any]?{
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any] {
            return dict
        }
        
        return nil
    }
    
}
