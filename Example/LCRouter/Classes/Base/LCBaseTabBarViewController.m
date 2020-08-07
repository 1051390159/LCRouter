//
//  LCBaseTabBarViewController.m
//  LCRouter_Example
//
//  Created by 刘彬 on 2020/8/6.
//  Copyright © 2020 liubin. All rights reserved.
//

#import "LCBaseTabBarViewController.h"

@interface LCBaseTabBarViewController ()

@end

@implementation LCBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Public

+ (LCBaseTabBarViewController *)tabBarCtrl {
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (![vc isKindOfClass:[LCBaseTabBarViewController class]]) {
        return nil;
    }
    LCBaseTabBarViewController *tabBarCtrl = (LCBaseTabBarViewController *)vc;
    return tabBarCtrl;
}

- (void)9switchToTabAtIndex:(NSInteger)tabIndex {
    [self popToCurrentRootVC];
    dispatch_queue_t queue= dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), queue, ^{
        // 再切换index
        if (self.selectedIndex != tabIndex) {
            self.selectedIndex = tabIndex;
        }
    });
}

#pragma mark -Private

- (void)popToCurrentRootVC {
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navCurrent = self.selectedViewController;
        NSArray *arrayVC = navCurrent.viewControllers;
        // 判断最上层的VC模态VC，如果是则执行影响引用计数和dismiss操作，需要加保护，因为有些系统自带和第三方VC未必支持
        [self presentVCDismiss:arrayVC.lastObject];
        // 返回到RootVC
        [navCurrent popToRootViewControllerAnimated:NO];
    }
}

-(void)presentVCDismiss:(UIViewController *)vcLast {
    UIViewController *vcPresented = (UIViewController *) vcLast.presentedViewController;
    if (vcPresented) {
        // 执行影响引用计数的操作，需要加保护，因为有些系统自带和第三方VC未必支持
        SEL selector = NSSelectorFromString(@"sc_releaseReferenceCount");
        if ([vcPresented respondsToSelector:selector]) {
            IMP imp = [vcPresented methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(vcPresented, selector);
        }
        [vcPresented dismissViewControllerAnimated:NO completion:^{}];
    }
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
