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

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [WXApi registerApp:@"wx17ddf17d8a5e75dc" universalLink:@"https://com.salesvalley.tcpapp/"];
//    //注册微博
//    //    [WeiboSDK enableDebugMode:YES];
//    [WeiboSDK registerApp:@"2126283473"];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    // U-Share 平台设置
    [self confitUShareSettings];
    [self configUSharePlatforms];
    
    if (@available(iOS 13.0, *)) {

        } else {
          
            CGRect screenBounds = [[UIScreen mainScreen] bounds];

            self.window = [[UIWindow alloc] initWithFrame:screenBounds];
            self.window.autoresizesSubviews = YES;
            
            ViewController *viewController = [[ViewController alloc] init];
//            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
            self.window.rootViewController = viewController;
            [self.window makeKeyAndVisible];
            
        }
    
    
    
    
    return YES;
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
    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://com.salesvalley.tcpapp/",
                                                        @(UMSocialPlatformType_QQ):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/qq_conn/101364990"
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


@end
