//
//  UIButton+Extension.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 2017/4/19.
//  Copyright © 2017年 柴进. All rights reserved.
//

import Foundation

extension UIButton{

    func animationStartWith(str:String){
      
        var array = Array<UIImage>()
        
        for i in 1...3 {
          array.append(UIImage(named:String.init(format: "%@%d", str,i))!)
        }
        self.imageView?.animationImages = array
        self.imageView?.animationDuration = 1
        self.imageView?.animationRepeatCount = 0
        self.imageView?.startAnimating()
        
     }
   
    
    func stopAnimation(){
        self.imageView?.stopAnimating()
        self.imageView?.animationImages = nil
    }
    
}

extension UIImageView{
    
    func animationStart(){
        
        var array = Array<UIImage>()
        
        for i in 1...3 {
            array.append(UIImage(named:String.init(format: "voiceR%d",i))!)
        }
        self.animationImages = array
        self.animationDuration = 1
        self.animationRepeatCount = 0
        self.startAnimating()
        
    }
    
    
    func stopAnimation(){
        self.stopAnimating()
        self.animationImages = nil
    }


}



