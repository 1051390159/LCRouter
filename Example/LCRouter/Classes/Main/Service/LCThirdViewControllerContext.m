//
//  LCThirdViewControllerContext.m
//  LCRouter_Example
//
//  Created by 刘彬 on 2020/8/7.
//  Copyright © 2020 liubin. All rights reserved.
//

#import "LCThirdViewControllerContext.h"

@implementation LCThirdViewControllerContext

- (BOOL)router:(LCRouter *)router
shouldRouteFrom:(UIViewController *)fromViewController
    parameters:(NSDictionary *)parameters
    transition:(LCRouteTransition)transition
      animated:(BOOL)animated {
    [[LCBaseTabBarViewController tabBarCtrl] switchToTabAtIndex:2];
    return NO;
}

@end
