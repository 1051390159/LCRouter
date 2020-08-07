//
//  LCFirstViewControllerContext.m
//  LCRouter_Example
//
//  Created by 刘彬 on 2020/8/7.
//  Copyright © 2020 liubin. All rights reserved.
//

#import "LCFirstViewControllerContext.h"

@implementation LCFirstViewControllerContext

- (BOOL)router:(LCRouter *)router
shouldRouteFrom:(UIViewController *)fromViewController
    parameters:(NSDictionary *)parameters
    transition:(LCRouteTransition)transition
      animated:(BOOL)animated {
    [[LCBaseTabBarViewController tabBarCtrl] switchToTabAtIndex:0];
    return NO;
}

@end
