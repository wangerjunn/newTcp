
//
//  MyVoiceView.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/7.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit
import AVFoundation



class MyVoiceView: UIView {

    var leftBtn : UIButton?
    var progressSlider:UISlider?
    var timeLable:UILabel?
    
    var player :AVAudioPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self .congigUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
   public func congigUIWithModel(_ model:RCVoiceMessage) {
       
        leftBtn = UIButton.init(type: .custom)
        leftBtn?.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        addSubview(leftBtn!)
        leftBtn?.addTarget(self, action: #selector(btnClick(_ :)), for: .touchUpInside)
        leftBtn?.setTitle("播放", for: .normal)
    
    
        progressSlider = UISlider.init(frame: CGRect.init(x:42, y: 19, width:self.frame.width-42*2 , height: 2))
        addSubview(progressSlider!)
        progressSlider?.addTarget(self, action: #selector(sliderChange(_ :)), for: .valueChanged)
        timeLable = UILabel.init(frame: CGRect.init(x: self.frame.width-42, y: 0, width: 40, height: 40))
        addSubview(timeLable!)
        timeLable?.text = String(model.duration)
        player = try? AVAudioPlayer.init(data: model.wavAudioData)
    }
    
    @objc func btnClick(_ btn:UIButton)
    {
        if (player?.isPlaying)!
        {
            player?.pause()
            
            btn.setTitle("播放", for: .normal)
        }
        else
        {
            
         player?.play()
         btn.setTitle("暂停", for: .normal)
        }
    }
    
    @objc func sliderChange(_ slider:UISlider){
        player?.volume = slider.value;
    }
}
