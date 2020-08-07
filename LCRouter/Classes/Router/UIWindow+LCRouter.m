//
//  UIWindow+LCRouter.m
//  LCRouter
//
//  Created by 刘彬 on 2020/8/5.
//

#import "UIWindow+LCRouter.h"

@implementation UIWindow (LCRouter)

/// 递归查找最上层viewController
/// @param vc 目标viewController
+ (UIViewController *)findViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [self findViewController:vc.presentedViewController];
    }
    else if([vc isKindOfClass:[UISplitViewController class]]){
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self findViewController:svc.viewControllers.lastObject];
        }
        else{
            return vc;
        }
    }
    else if ([vc isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)vc;
        if (nav.viewControllers.count > 0) {
            return [self findViewController:nav.topViewController];
        }
        else{
            return vc;
        }
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tab = (UITabBarController *)vc;
        if (tab.viewControllers.count > 0) {
            return [self findViewController:tab.selectedViewController];
        }
        else{
            return vc;
        }
    }
    else{
        return vc;
    }
}

- (UIViewController *)findTopViewControllerInWindow {
    UIViewController *vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    return [UIWindow findViewController:vc];
}
@end
