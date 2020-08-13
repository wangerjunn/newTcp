//
//  ViewController.m
//  NewTcpApp
//
//  Created by xslpiOS on 2020/7/19.
//  Copyright © 2020 xslpiOS. All rights reserved.
//

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "NewTcpApp-Swift.h"
#import "LoadingAnimationView.h"
#import "ShareView.h"
@interface ViewController () <WKNavigationDelegate>
{
    WKWebView *wkWebView;
    NSString *redirectUrl;
    UIImageView *animationImageview;
    LoadingAnimationView *loadingView;
}

@end

@implementation ViewController

- (void)shareToPlatform {
    ShareView *shareView = [[ShareView alloc] initShareViewBySharePlaform:@[@1] viewTitle:@"分享测试啦" shareTitle:@"我是分享的标题啊" shareDesp:@"我是分享的描述啊" shareLogo:@"logo" shareUrl:@"https://www.baidu.com"];
    [shareView show];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"share" style:UIBarButtonItemStylePlain target:self action:@selector(shareToPlatform)];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    //创建网页配置对象
     WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
     
     // 创建设置对象
     WKPreferences *preference = [[WKPreferences alloc]init];
     
//    animationImageview.animationImages
     // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
     preference.javaScriptCanOpenWindowsAutomatically = YES;
     config.preferences = preference;
         
        
    //     //这个类主要用来做native与JavaScript的交互管理
    //     WKUserContentController * wkUController = [[WKUserContentController alloc] init];
    //     //注册一个name为jsToOcNoPrams的js方法
    //     [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcNoPrams"];
    //     [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"];
    //    config.userContentController = wkUController;
        
    wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20) configuration:config];
    wkWebView.navigationDelegate = self;

//    NSString *webString = @"http://tcp.xslp.cn/sbc.html#/class?device=app";
    NSString *webString = @"http://t-tcp.xs815.com/sbc.html#/class?device=app";
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webString]]];
    [self.view addSubview:wkWebView];
//    [_bridge callHandler:@"lastFunTest" data:nil responseCallback:^(id response) {
//        NSLog(@"这里是OC调用JS成功后，JS回调的参数:%@", response);
//    }];
    
    loadingView = [[LoadingAnimationView alloc] init];
    [loadingView showInView:self.view];
    
    [self.view bringSubviewToFront:loadingView];
    NSLog(@"移除启动图后");
    
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"页面开始加载时调用 didStartProvisionalNavigation");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"页面加载失败时调用 didFailProvisionalNavigation");
    [loadingView dismiss];
}

    
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"当内容开始返回时调用 didCommitNavigation");
    
}

    
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用 didFinishNavigation");
    [webView evaluateJavaScript:@"window.location.host" completionHandler:^(id _Nullable handle, NSError * _Nullable error) {
        NSLog(@"window.location.host = %@",handle);
    }];
    
    [webView evaluateJavaScript:@"window.location.hostname" completionHandler:^(id _Nullable handle, NSError * _Nullable error) {
        NSLog(@"window.location.hostname = %@",handle);
    }];
    
    [loadingView dismiss];
}
   
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlString = navigationAction.request.URL.absoluteString;
    
    NSString *wxScheme = @"pay.xslp.cn";
    NSString *referer = [NSString stringWithFormat:@"%@://",wxScheme];

    
    NSLog(@"%@", urlString);

    //调起群组
    if ([urlString hasPrefix:@"xslpapp://com.xslp.dk"]) {

        //获取token
        NSRange range = [urlString rangeOfString:@"?"];
        if (range.location != NSNotFound) {

            NSString *paramsString = [urlString substringFromIndex:range.location+range.length];

            NSArray *paramsArr = [paramsString componentsSeparatedByString:@"&"];

            for (NSString *param in paramsArr) {
                if ([param hasPrefix:@"token="]) {
                    NSArray *elements = [param componentsSeparatedByString:@"="];

                    NSString *token = elements.lastObject;

                    [self connectRongYun:token];

                    break;

                }
            }
        }

        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([urlString hasPrefix:@"weixin://wap/pay"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:nil];
               decisionHandler(WKNavigationActionPolicyCancel);
               return;
    }
    if ([urlString containsString:@"alipay://alipayclient/"]) {
        //调起支付宝支付
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }else if ([urlString hasPrefix:wxScheme]) {
        //由微信支付返回到APP回调

        NSRange range = [urlString rangeOfString:wxScheme];
        if (range.location != NSNotFound) {
            
            NSString *lastUrlString = [urlString substringFromIndex:range.location+range.length];

            urlString = [@"https" stringByAppendingString:lastUrlString];

            NSURL * url = [NSURL URLWithString:urlString];
            NSURLRequest *tmpRequest = [[NSURLRequest alloc] initWithURL:url];
            [webView loadRequest:tmpRequest];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
            
        
    }

//    if ([urlString isEqualToString:@"https://pay.xslp.cn/index.php/User/Payment/pay"]) {
//
//        NSData *data = request.HTTPBody;
//
//
//        NSString *params = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", params);
//
//        if ([params containsString:@"platform=ios"]) {
//            return YES;
//        }
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
//        // 如果有webMethod并且是POST,则POST方式组合提交
//        [requestM setHTTPMethod:@"POST"];
//        NSString *body = nil;
//        body = [NSString stringWithFormat:@"%@&platform=ios",params];
//        [requestM setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
//
//        NSLog(@"%@",body);
//       urlString = [urlString stringByAppendingFormat:@"%@&platform=ios",params];
//
//        [webView loadRequest:requestM];
//        return NO;
//
//    }


    else if ([[navigationAction.request.URL absoluteString] containsString:@"https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb"]) {
        //weixin://wap/pay?prepayid%3Dwx2317173862758252dcad00251141517400&package=1136975133&noncestr=1592903981&sign=4d26d96740bc8240197aa215c4137180
        
        
        NSRange range = [urlString rangeOfString:@"redirect_url="];
        if (range.location != NSNotFound) {
            NSString *url = [urlString substringToIndex:range.location+range.length];

            NSString *subString = [urlString substringFromIndex:range.location+range.length];

            //判断URL是否修改，使返回App
            if (redirectUrl && [subString isEqualToString:redirectUrl]) {
                redirectUrl = nil;
                decisionHandler(WKNavigationActionPolicyAllow);
                return;
            }
            
            
            subString = [subString substringFromIndex:5];

            subString = [wxScheme stringByAppendingString:subString];

            redirectUrl = subString;
            
            urlString = [url stringByAppendingString:subString];

            NSMutableURLRequest *tmpRequest =  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            //设置授权域名
            [tmpRequest setValue:referer forHTTPHeaderField:@"Referer"];

            [webView loadRequest:tmpRequest];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }

    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
    

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//    //用户身份信息
//    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
//    //为 challenge 的发送方提供 credential
//    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
//    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
//}
    //进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

#pragma mark -- 连接融云
- (void)connectRongYun:(NSString *)token {
    [GroupPluginSwift initWithTokenWithToken:token next:^{
        NSLog(@"成功了");
        [self displayGroupChat];
    }];
}

- (void)displayGroupChat {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController * vc = [[GroupListViewController alloc] init];
        BaseNavigationController * nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        //设置模态视图弹出样式
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    });
    
}


@end
