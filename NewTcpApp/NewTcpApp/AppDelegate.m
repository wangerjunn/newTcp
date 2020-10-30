//
//  AppDelegate.m
//  NewTcpApp
//
//  Created by xslpiOS on 2020/7/19.
//  Copyright © 2020 xslpiOS. All rights reserved.
//

#import "AppDelegate.h"

#import "WXApi.h"
#import "ViewController.h"
#import "NewTcpApp-Swift.h"
#import <UMShare/UMShare.h>
#import <WeiboSDK.h>
#import <UMCommon/UMCommon.h>
#import <UMCommon/UMRemoteConfig.h>
#import <UMCommon/UMRemoteConfigSettings.h>

@interface AppDelegate () <WXApiDelegate,WeiboSDKDelegate,UMRemoteConfigDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
//        NSLog(@"微信日志: %@",log);
//    }];
//
    
    [self configUMRemoteConfig];
    
    [WXApi registerApp:@"wx17ddf17d8a5e75dc" universalLink:@"https://tcp.xslp.cn/tcpapp/"];
//
//    //调用自检函数
//    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult* result) {
//        NSLog(@"WeixinSDK2：%@, %u, %@, %@", @(step), result.success, result.errorInfo, result.suggestion);
//    }];
//    //注册微博
//    //    [WeiboSDK enableDebugMode:YES];
//    [WeiboSDK registerApp:@"2126283473"];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    // U-Share 平台设置
    [self confitUShareSettings];
    [self configUSharePlatforms];
    
    if (@available(iOS 13.0, *)) {
        NSLog(@"%@", [UIDevice currentDevice].systemVersion);
        } else {
          
            CGRect screenBounds = [[UIScreen mainScreen] bounds];

            self.window = [[UIWindow alloc] initWithFrame:screenBounds];
            self.window.autoresizesSubviews = YES;
            
            ViewController *viewController = [[ViewController alloc] init];
            
            self.window.rootViewController = viewController;
            [self.window makeKeyAndVisible];
            
        }
    
    
    
    
    return YES;
}

- (void)configUMRemoteConfig {
    [UMConfigure initWithAppkey:kUM_Appkey channel:@"App Store"];
    
    
    //初始化设置activateAfterFetch = YES 为获取数据后自动激活
    //初始化设置activateAfterFetch = NO 就需要手动激活数据[UMRemoteConfig activateWithCompletionHandler:nil];
    [UMRemoteConfig remoteConfig].remoteConfigDelegate = self;
    [UMRemoteConfig remoteConfig].configSettings.activateAfterFetch = YES;
    
    //设置本地默认的数据，在没有取到服务器的数据的时候，获取本地的数据
    [UMRemoteConfig setDefaultsFromPlistFileName:@"RemoteConfigDefaults"];
    
    //获取的是上一次激活的数据，如果上一次的数据是最新的就直接使用，
    //不然需要在UMRemoteConfigDelegate:remoteConfigActivated的回调里面获取最新值，后续的获取都是最新的值
    NSString* configtestValue =  [UMRemoteConfig configValueForKey:kAppStore_is_auditing];
    NSLog(@"remoteConfigActivated init configtest = %@",configtestValue);
}
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
//    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
        //配置微信平台的Universal Links
    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://tcp.xslp.cn/tcpapp/",
                                                        @(UMSocialPlatformType_QQ):@"https://tcp.xslp.cn/qq_conn/101364990/"
                                                        };
}
- (void)configUSharePlatforms
{
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx17ddf17d8a5e75dc" appSecret:@"xslpwrq12441eqw423423423424asdsd" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101364990"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
//    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2126283473"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

void uncaughtExceptionHandler(NSException*exception){
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@",[exception callStackSymbols]);
    // Internal error reporting
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self] || [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];

}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}
#pragma mark -- 微信回调
- (void)onResp:(BaseResp *)resp {
    
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
}

#pragma mark- UMRemoteConfigDelegate

-(void)remoteConfigActivated:(UMRemoteConfigActiveStatus)status
                       error:(nullable NSError*)error
                    userInfo:(nullable id)userInfo{
    if (error) {
        NSLog(@"remoteConfigActivated error:%@",error);
        return;
    }
    
    //回调到这表示当前获取到了服务器的最新的参数
    NSString* configtestValue =  [UMRemoteConfig configValueForKey:kAppStore_is_auditing];
    NSLog(@"remoteConfigActivated Activated for configtest = %@",configtestValue);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remoteConfigActivated" object:nil];
}


-(void)remoteConfigReady:(UMRemoteConfigActiveStatus)status
                   error:(nullable NSError*)error
                userInfo:(nullable id)userInfo{
    if (error) {
        NSLog(@"remoteConfigReady error:%@",error);
        return;
    }
    
    //在[UMRemoteConfig remoteConfig].configSettings.activateAfterFetch = NO的时候调用，来选择用以前的缓存的数据还是激活当前下载的服务器最新的数据
    //[UMRemoteConfig activateWithCompletionHandler:nil];
    
}

@end
