//
//  AppDelegate.m
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "AppDelegate.h"
//Integrate BQMM
#import <BQMM/BQMM.h>

#import <Bugly/Bugly.h>
#import "MMChatViewController.h"
//#import "BQMMDNSConfigurator.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //Integrate BQMM    initialize
    NSString *appId = @"15e0710942ec49a29d2224a6af4460ee";
    NSString *secret = @"b11e0936a9d04be19300b1d6eec0ccd5";
    [[MMEmotionCentre defaultCentre] setAppId:appId
                                       secret:secret];
 //   [[BQMMDNSConfigurator sharedConfigurator] setup];
//    [[MMEmotionCentre defaultCentre] setAppkey:@"8aaf0708586c4340015870446c2d020e" platformId:@"97790e9a809a41c7aa523ba5fa019f25"];
    
    [MMEmotionCentre defaultCentre].sdkMode = MMSDKModeIM;
    [MMEmotionCentre defaultCentre].sdkLanguage = MMLanguageChinese;
    
    MMTheme *theme = [[MMTheme alloc] init];
    theme.navigationBarColor = [UIColor blueColor];
    theme.navigationBarTintColor = [UIColor redColor];
    [[MMEmotionCentre defaultCentre] setTheme:theme];
    
    //initialize bugly
//    [Bugly startWithAppId:@"900037281"];
    
    MMChatViewController *VC = [[MMChatViewController alloc] init];
    VC.title = @"chat view";
    UINavigationController *rootNavi = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window.rootViewController = rootNavi;
    
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
    //Integrate BQMM
    [[MMEmotionCentre defaultCentre] clearSession];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
