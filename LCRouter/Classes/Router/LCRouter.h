//
//  LCRouter.h
//  LCRouter
//
//  Created by 刘彬 on 2020/8/5.
//

#import <Foundation/Foundation.h>
#import "LCRouteContext.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

@interface LCRouter : NSObject

+ (instancetype)sharedInstance;

#pragma mark ----- registerActions

/// 注册路由配置
/// @param routePlistName 路由表配置表文件名
/// @param schemeUrl  路由协议schemeUrl
- (void)registerDefaultRoutingTableWithRoutePlistName:(NSString *)routePlistName withSchemeUrl:(const NSString *)schemeUrl;

#pragma mark ----- routerActions

/// url标准格式跳转
/// @param uri  xeample: 'schemeUrl://host?key=value'格式
- (BOOL)routeWithUri:(NSString *)uri;

/// host自定定义跳转
/// @param host 目标host
/// @param parameters 自定义参数
- (BOOL)routeWithHost:(NSString *)host parameters:(nullable NSDictionary *)parameters;

@end

#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
