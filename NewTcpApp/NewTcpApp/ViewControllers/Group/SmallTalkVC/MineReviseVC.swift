//
//  MineReviseVC.swift
//  SLAPP
//
//  Created by apple on 2018/4/28.
//  Copyright © 2018年 柴进. All rights reserved.
//

import UIKit
import WebKit

class MineReviseVC: UIViewController,WKNavigationDelegate {
   
    var url:URL?
   
    lazy var web = { () -> WKWebView in
        let web  = WKWebView()
        return web
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(web)
        web.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        web.load(URLRequest.init(url: url!))
        web.navigationDelegate = self
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressDismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.progressDismissWith(str: "出现错误")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progressShow()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
