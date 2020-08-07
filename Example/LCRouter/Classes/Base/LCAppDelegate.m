//
//  LCAppDelegate.m
//  LCRouter
//
//  Created by liubin on 08/05/2020.
//  Copyright (c) 2020 liubin. All rights reserved.
//

#import "LCAppDelegate.h"

const NSString * kSchemeUrl = @"shenZhen://";

@implementation LCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[LCRouter sharedInstance] registerDefaultRoutingTableWithRoutePlistName:@"route" withSchemeUrl:kSchemeUrl];
    
    [self loadRootViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark ----- initRoot

- (void)loadRootViewController
{
    //主控制器
    LCBaseTabBarViewController  *tabVc = [[LCBaseTabBarViewController alloc]init];
    self.window.rootViewController = tabVc;
    [self.window makeKeyAndVisible];
    
    //firstItem
    LCFirstViewController *firstVc = [[LCFirstViewController alloc]init];
    LCBaseNavigationViewController *firstNav = [[LCBaseNavigationViewController alloc]initWithRootViewController:firstVc];
    firstVc.title = @"First";
    
    //secondItem
    LCSecondViewController *secondVc = [[LCSecondViewController alloc]init];
    LCBaseNavigationViewController *sencondNav = [[LCBaseNavigationViewController alloc]initWithRootViewController:secondVc];
    secondVc.title = @"Second";
    
    //thirdItem
    LCThirdViewController *thirdVc = [[LCThirdViewController alloc]init];
    LCBaseNavigationViewController *thirdNavVc = [[LCBaseNavigationViewController alloc]initWithRootViewController:thirdVc];
    thirdVc.title = @"Third";
    
    tabVc.viewControllers = @[firstNav,sencondNav,thirdNavVc];
    
    [LCTextPopView showTextPopView];
    
}

@end
