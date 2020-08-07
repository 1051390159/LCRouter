//
//  UIWindow+LCRouter.h
//  LCRouter
//
//  Created by 刘彬 on 2020/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (LCRouter)

/// 获取最上层的viewController
- (UIViewController *)findTopViewControllerInWindow;

@end

NS_ASSUME_NONNULL_END
