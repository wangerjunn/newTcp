//
//  SbcViewController.m
//  SLAPP
//
//  Created by xslp on 2020/9/17.
//  Copyright © 2020 wangxitan. All rights reserved.
//

#import "SbcViewController.h"
#import <WebKit/WebKit.h>
#import "NewTcpApp-Swift.h"

@interface SbcViewController () <WKNavigationDelegate>
{
    WKWebView *web;
    NSString *redirectUrl;
}

@property (nonatomic, strong) WKWebView *webView;
@end

@implementation SbcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.viewTitle?self.viewTitle:@"";
    
    [self createUI];
}

- (void)createUI {

    self.view.backgroundColor = [UIColor whiteColor];
    
     //初始化
     WKUserContentController* userContentController = WKUserContentController.new;
//    PublicDataSingle * sharePublicDataSingle = [[PublicDataSingle alloc]init];
    
    if (_token) {
        NSString *source = [NSString stringWithFormat:@"document.cookie ='xslp_sso_token=%@';",_token];
         WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];

         [userContentController addUserScript:cookieScript];
    }
    
     WKWebViewConfiguration* webViewConfig = WKWebViewConfiguration.new;
     webViewConfig.userContentController = userContentController;
     WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webViewConfig];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
     //请求
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    if (_token) {
        [request setValue:[NSString stringWithFormat:@"%@=%@",@"xslp_sso_token", _token] forHTTPHeaderField:@"Cookie"];
    }
    
     [webView loadRequest:request];
    
    [SVProgressHUD showInfoWithStatus:@"加载中..."];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
