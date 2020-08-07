//
//  LCBaseTabBarViewController.h
//  LCRouter_Example
//
//  Created by 刘彬 on 2020/8/6.
//  Copyright © 2020 liubin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCBaseTabBarViewController : UITabBarController

/// 获取对象
+ (LCBaseTabBarViewController *)tabBarCtrl;

/// 切换barIndex
/// @param tabIndex item标识
- (void)switchToTabAtIndex:(NSInteger)tabIndex;

@end

NS_ASSUME_NONNULL_END
