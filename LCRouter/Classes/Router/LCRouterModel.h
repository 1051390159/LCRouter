//
//  LCRouterModel.h
//  LCRouter
//
//  Created by 刘彬 on 2020/8/5.
//

#import <Foundation/Foundation.h>
#import "LCRouteContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCRouterModel : NSObject

/// 路由唯一标识
@property (nonatomic, copy, readonly) NSString *uriHost;

/// 路由参数列表
@property (nonatomic, copy, readonly) NSArray *uriQueries;

///路由情景控制模型
@property (nonatomic, strong, readonly) LCRouteContext *context;

- (instancetype)initWithUriHost:(NSString *)uriHost
                     uriQueries:(nullable NSArray *)uriQueries
                   contextClass:(NSString *)contextClass NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithUriHost:(NSString *)uriHost
                     uriQueries:(nullable NSArray *)uriQueries
                        context:(LCRouteContext *)context NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
