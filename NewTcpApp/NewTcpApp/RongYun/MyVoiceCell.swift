
//
//  MyVoiceCell.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/7.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class MyVoiceCell: RCMessageCell {

    var textlable :RCAttributedLabel?
    var bubbleBackgroundView :UIImageView?
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    func initialize() {
        bubbleBackgroundView = UIImageView.init(frame: CGRect.init())
        messageContentView.addSubview(bubbleBackgroundView!)
        
        textlable?.text = "123123123123123";
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func getBubbleBackgroundViewSize(str:String) -> (CGSize)
    {
      return CGSize.init(width: 0, height: 0)
    }
    
    override func setDataModel(_ model: RCMessageModel!) {
        super.setDataModel(model)
        self.setAutoLayout()
    }
    
    func setAutoLayout(){
        let bubbleBackgroundViewSize:CGSize = CGSize.init(width: 300, height: 44)
        var messageContentViewRect:CGRect = self.messageContentView.frame
         messageContentViewRect.size.width = bubbleBackgroundViewSize.width;
        
        if .MessageDirection_RECEIVE == self.messageDirection {
            self.messageContentView.frame = messageContentViewRect;
            self.bubbleBackgroundView?.frame = CGRect.init(x: 0, y: 0, width: bubbleBackgroundViewSize.width, height: bubbleBackgroundViewSize.height)
            
            let image:UIImage = RCKitUtility.imageNamed("chat_from_bg_normal", ofBundle: "RongCloud.bundle")
            
            self.bubbleBackgroundView?.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: image.size.height * 0.8, left: image.size.height * 0.8, bottom: image.size.height * 0.2, right: image.size.height * 0.2))
        }
        else
        {
            messageContentViewRect.size.width = bubbleBackgroundViewSize.width;
            messageContentViewRect.size.height = bubbleBackgroundViewSize.height;
            messageContentViewRect.origin.x =
                self.baseContentView.bounds.size.width -
                (messageContentViewRect.size.width + 6 +
                    RCIM.shared().globalMessagePortraitSize.width + 10);
            self.messageContentView.frame = messageContentViewRect;
            
            self.bubbleBackgroundView?.frame = CGRect.init(x: 0, y: 0, width: bubbleBackgroundViewSize.width, height: bubbleBackgroundViewSize.height)
            
            let image:UIImage = RCKitUtility.imageNamed("chat_to_bg_normal", ofBundle: "RongCloud.bundle")
            
            self.bubbleBackgroundView?.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: image.size.height * 0.8, left: image.size.height * 0.2, bottom: image.size.height * 0.2, right: image.size.height * 0.8))

        }
       
        let voiceModel:RCVoiceMessage = model.content as! RCVoiceMessage
        
        let myView = MyVoiceView.init(frame: CGRect.init(x: 0, y: 0, width: messageContentView.frame.width, height: 44))
        messageContentView.addSubview(myView)
        myView .congigUIWithModel(voiceModel)
        
    }
}
