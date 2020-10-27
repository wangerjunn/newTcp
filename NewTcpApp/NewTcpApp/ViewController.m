//
//  ViewController.m
//  NewTcpApp
//
//  Created by xslpiOS on 2020/7/19.
//  Copyright © 2020 xslpiOS. All rights reserved.
//

#define kACCESS_TOKEN @"access_token"
#define kIM_TOKEN @"im_token"

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <UMCommon/UMRemoteConfig.h>
#import <UMCommon/UMRemoteConfigSettings.h>
#import "NewTcpApp-Swift.h"
#import "ShareView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ApplePayViewController.h"

@interface ViewController () <WKNavigationDelegate,WKScriptMessageHandler>
{
    WKWebView *wkWebView;
    NSString *redirectUrl;
    UIImageView *animationImageview;
}

@end

@implementation ViewController
- (void)toPurchase {
    ApplePayViewController *applePay = [ApplePayViewController new];
    [self.navigationController pushViewController:applePay animated:YES];
}

#pragma mark -- 获取APP线上版本
- (void)getAppOnlineVersion {
    
    
    NSString *urlString=@"http://itunes.apple.com/lookup?id=1187076931"; //自己应用在App Store里的地址
    NSURL *url = [NSURL URLWithString:urlString];//这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。

    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];

    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    解析json数据

    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    NSArray *array = json[@"results"];

    NSString *newVersion = @"";
    for (NSDictionary *dic in array) {
        
        newVersion = dic[@"version"];//appstore版本号
        
        NSLog(@"%@",newVersion);

    }

    NSString *localVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];

    //是否在审核期间
    NSString * version_case = @"=";
    if (![localVersion isEqualToString:newVersion]) {
        
        NSArray *newVersionArr = [newVersion componentsSeparatedByString:@"."];
        NSArray *localVersionArr =  [localVersion componentsSeparatedByString:@"."];
        
        NSInteger length = newVersionArr.count;
        if (localVersionArr.count > newVersionArr.count) {
            length = localVersionArr.count;
        }
        
        for (int i = 0; i < length; i++) {
            
            NSInteger localUnit = -1;
            NSInteger newUnit = -1;
            
            if (i < localVersionArr.count) {
                localUnit = [localVersionArr[i] intValue];
            }
            
            if (i < newVersionArr.count) {
                newUnit =  [newVersionArr[i] intValue];
            }
            
            if (localUnit > newUnit) {
                version_case = @">";
                break;
            } else if (localUnit == newUnit) {
                //等于最新版本
                version_case = @"=";
            }else {
                //低于最新版本
                version_case = @"<";
            }
            
        }
    }
    
    NSString* configtestValue =  [UMRemoteConfig configValueForKey:kAppStore_is_auditing];
    
    BOOL isAudit = NO;
    
    if ([version_case isEqualToString:@"="] ) {
        if ([configtestValue isEqualToString:@"1"]) {
            isAudit = YES;
        }
    } else if ([version_case isEqualToString:@">"]) {
        isAudit = YES;
    }
   
    [self loadWebView:isAudit];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"内购" style:UIBarButtonItemStylePlain target:self action:@selector(toPurchase)];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    
//    [_bridge callHandler:@"lastFunTest" data:nil responseCallback:^(id response) {
//        NSLog(@"这里是OC调用JS成功后，JS回调的参数:%@", response);
//    }];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self getAppOnlineVersion];
}


- (void)loadWebView:(BOOL)isAudit {
    //初始化
    WKUserContentController* userContentController = WKUserContentController.new;
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kACCESS_TOKEN];
//
//    if (token) {
//
//        NSString *source = [NSString stringWithFormat:@"document.cookie ='xslp_sso_token=%@';",token];
//         WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
//
//         [userContentController addUserScript:cookieScript];
//    }
    
    //创建网页配置对象
     WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContentController;
    config.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
    config.suppressesIncrementalRendering = YES;
    WKProcessPool *processpool = [[WKProcessPool alloc] init];

    config.processPool = processpool;
    
     // 创建设置对象
     WKPreferences *preference = [[WKPreferences alloc]init];
     
//    animationImageview.animationImages
     // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
     preference.javaScriptCanOpenWindowsAutomatically = YES;
     config.preferences = preference;
         
        
     //这个类主要用来做native与JavaScript的交互管理
     WKUserContentController * wkUController = [[WKUserContentController alloc] init];
     //注册一个name为jsToOcNoPrams的js方法
     [wkUController addScriptMessageHandler:self  name:@"shareToPlatform"];
     [wkUController addScriptMessageHandler:self  name:@"logout"];
     [wkUController addScriptMessageHandler:self  name:@"init"];//登录成功回调
     config.userContentController = wkUController;
        
    wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20) configuration:config];
    wkWebView.navigationDelegate = self;

    NSString *timeStamp = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    
    NSString *versionStr = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    
    versionStr = [versionStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSInteger num_version = [versionStr intValue] * 100;
    NSString *version = [NSString stringWithFormat:@"%ld",(long)num_version];
    
    NSString *webString = [NSString stringWithFormat:@"%@sbc.html#/class?device=app&deviceType=ios&versionCode=%@&timestamp=%@12345",(isAudit ? kBASE_URL_INNER : kBASE_URL),version,timeStamp];//&timestamp=%@12345,timeStamp
    
    //请求
//   NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webString]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webString] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:3600*24];
//   if (token) {
//       [request setValue:[NSString stringWithFormat:@"%@=%@",@"xslp_sso_token", token] forHTTPHeaderField:@"Cookie"];
//
//   }
    
    [wkWebView loadRequest:request];
    [self.view addSubview:wkWebView];
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"页面开始加载时调用 didStartProvisionalNavigation");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"页面加载失败时调用 didFailProvisionalNavigation");
    [SVProgressHUD showErrorWithStatus:@"页面加载失败"];
}

    
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"当内容开始返回时调用 didCommitNavigation");
    
}

    
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用 didFinishNavigation");
  
    [SVProgressHUD dismiss];
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
        
        [SVProgressHUD show];
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
    [GroupPluginSwift initWithTokenWithToken:token next:^(NSDictionary * _Nonnull result) {
        NSLog(@"成功了");
        [SVProgressHUD dismiss];
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

#pragma mark -- WKScriptMessageHandler
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if ([message.name isEqualToString:@"shareToPlatform"]) {
        if (message.body) {
            [self callbackShare:message.body];
        }
        
    } else if ([message.name isEqualToString:@"logout"]) {
        //退出登录时清除cookie
        [self clearCookies];
    }else if ([message.name isEqualToString:@"init"]) {
        //初始化融云
        NSLog(@"%@", message.body);
    }
}

//调用分享
- (void)callbackShare:(NSString *)body {
    NSLog(@"body = %@",body);
    NSData *data = [[NSString stringWithFormat:@"%@",body] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@", json);
    
    if (json) {
        NSString *title = [NSString stringWithFormat:@"%@",json[@"title"]];
        NSString *desp = [NSString stringWithFormat:@"%@",json[@"content"]];
        NSString *logo = [NSString stringWithFormat:@"%@",json[@"thumb_img"]];
        NSString *url = [NSString stringWithFormat:@"%@",json[@"url"]];
        
        ShareView *shareView = [[ShareView alloc] initShareViewBySharePlaform:@[@0,@1,@2,@3] viewTitle:title shareTitle:title shareDesp:desp shareLogo:logo shareUrl:url];
        [shareView show];
    }
}

//退出登录时清除cookie
- (void)clearCookies {
    
//        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//        
//        [userdefault removeObjectForKey:kACCESS_TOKEN];
//        [userdefault removeObjectForKey:kIM_TOKEN];
//        [userdefault synchronize];
            
    if (@available(iOS 11, *)) {
        
        WKHTTPCookieStore *cookieStore = wkWebView.configuration.websiteDataStore.httpCookieStore;
        [cookieStore getAllCookies:^(NSArray* cookies) {
            for (NSHTTPCookie *cookie in cookies) {
                [cookieStore deleteCookie:cookie completionHandler:nil];
            }
        }];
        
        
    }else {
        [[WKWebsiteDataStore defaultDataStore] fetchDataRecordsOfTypes:[NSSet setWithObjects:WKWebsiteDataTypeCookies, nil] completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull records) {
             [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] forDataRecords:records completionHandler:^{

            }];
        }];
    }
}

- (void)initRCIM {
//    RCIM.shared().initWithAppKey("qf3d5gbjqpxeh")//测试
//    RCIM.shared().initWithAppKey("sfci50a7sqloi")//正式
    
    [[RCIM sharedRCIM] initWithAppKey:@"qf3d5gbjqpxeh"];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:kIM_TOKEN];
    
    [[RCIM sharedRCIM] logout];
    [[RCIM sharedRCIM] connectWithToken:token dbOpened:^(RCDBErrorCode code) {
            
        } success:^(NSString *userId) {
            
        } error:^(RCConnectErrorCode errorCode) {
            
        }];
    
    
}


@end
