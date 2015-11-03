//
//  AppDelegate.m
//  骏途旅游
//
//  Created by mac10 on 15/10/5.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "FirstViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //判断是否是第一次登录
    BOOL first = [[NSUserDefaults standardUserDefaults] objectForKey:@"first"];
    if (!first) {
        FirstViewController *fVC = [[FirstViewController alloc] init];
        self.window.rootViewController = fVC;
    }
    
    
    [ShareSDK registerApp:@"b83e33a36470" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo)] onImport:nil onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch(platformType){
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:@"3539777889" appSecret:@"2c233967dbbdf4f602a9c9f2fcd5910f" redirectUri:@"https://api.weibo.com/oauth2/default.html" authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeTencentWeibo:
                [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650" appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3" redirectUri:@"http://www.sharesdk.cn"];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx1d3e3c0b2cd4ce0e" appSecret:@"d4624c36b6795d1d99dcf0547af5443d"];
                break;
        }
    }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
