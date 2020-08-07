//
//  LCRouteContext.h
//  LCRouter
//
//  Created by 刘彬 on 2020/8/5.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

///路由转场类型
typedef NS_OPTIONS(NSUInteger, LCRouteTransition) {
    ///Push
    LCRouteTransitionPush       = 1 << 0,
    ///Present
    LCRouteTransitionPresent    = 1 << 1,
    ///自动（Push|Present）
    LCRouteTransitionAuto       = (LCRouteTransitionPush | LCRouteTransitionPresent),
};

@class LCRouter;

@protocol LCRouterDelegate <NSObject>

@optional

/// 跳转
/// @param router 路由
/// @param fromViewController 目标vc
/// @param parameters 参数
/// @param transition 转场类型
/// @param animated 是否启用动画
- (BOOL)router:(LCRouter *)router
shouldRouteFrom:(UIViewController *)fromViewController
    parameters:(NSDictionary *)parameters
    transition:(LCRouteTransition)transition
      animated:(BOOL)animated;

@end

@interface LCRouteContext : NSObject<LCRouterDelegate>

///目标class
@property (nonatomic, strong) Class targetClass;

///路由参数与视图控制器属性的映射表
@property (nonatomic, strong) NSDictionary *keyPathMap;

///支持的转场类型。默认为SCRouteTransitionAuto。
@property (nonatomic) LCRouteTransition supportedTransitions;

@end

NS_ASSUME_NONNULL_END
