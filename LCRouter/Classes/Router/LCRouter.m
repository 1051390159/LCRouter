//
//  LCRouter.m
//  LCRouter
//
//  Created by 刘彬 on 2020/8/5.
//

#import "LCRouter.h"
#import "NSDictionary+Addition.h"
#import "NSString+QueryDictionary.h"
#import "UIWindow+LCRouter.h"

#import "LCRouterModel.h"
#import "LCRouterDefineHeader.h"

@interface LCRouter() {
    NSMutableDictionary *_routingTable;                 //路由表
    NSMutableDictionary *_classTable;                   //页面class对照表
    NSMutableDictionary *_protocalClassTable;           //protocal class表
}

/// scheme
@property (nonatomic, strong) NSString *schemeURL;
@property (nonatomic, strong) NSString *universalLink;

@end

@implementation LCRouter

- (instancetype)init {
    self = [super init];
    if (self) {
        _routingTable = [NSMutableDictionary dictionary];
        _classTable = [NSMutableDictionary dictionary];
        _protocalClassTable = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static LCRouter *shareInstance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[LCRouter alloc] init];
    });
    return shareInstance;
}

#pragma mark ----- register

/// 注册路由表
- (void)registerDefaultRoutingTableWithRoutePlistName:(NSString *)routePlistName withSchemeUrl:(const NSString *)schemeUrl {
    
    self.schemeURL = [schemeUrl copy];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:routePlistName ofType:@"plist"];
    NSArray *routeInfos = [NSArray arrayWithContentsOfFile:filePath];
    for (int i = 0; i < routeInfos.count; i++) {
        NSDictionary *routeInfo = routeInfos[i];
        //解析路由情景模型
        LCRouteContext *context = nil;
        NSDictionary *contextInfo = [routeInfo dictionaryForKey:@"context"];
        NSString *contextClass = [contextInfo stringForKey:@"class"];
        
        Class class = NSClassFromString(contextClass);
        if ([class isSubclassOfClass:[LCRouteContext class]]) {
            context = [[class alloc] init];
        } else {
            context = [[LCRouteContext alloc] init];
        }
        
        NSString *target = [contextInfo stringForKey:@"target"];
        if (target.length) {
            context.targetClass = NSClassFromString(target);
        }
        
        NSDictionary *map = [contextInfo dictionaryForKey:@"map"];
        if (map.count) {
            context.keyPathMap = map;
        }
        
        NSString *transitionKey = [contextInfo stringForKey:@"transition"];
        if ([transitionKey isEqualToString:@"push"]) { //不支持present
            context.supportedTransitions = LCRouteTransitionPush;
        } else if ([transitionKey isEqualToString:@"present"]) { //不支持push
            context.supportedTransitions = LCRouteTransitionPresent;
        }
        
        [self registerRouteInfoWithUriHost:[routeInfo stringForKey:@"host"]
        uriQueries:[[routeInfo dictionaryForKey:@"query"] allKeys]
           context:context];
    }
}

/// 动态注册路由信息
- (BOOL)registerRouteInfoWithUriHost:(NSString *)uriHost
                          uriQueries:(NSArray *)uriQueries
                             context:(LCRouteContext *)context
{
    return [self registerRouteInfoWithUriHost:uriHost
                                   uriQueries:uriQueries
                                 contextClass:nil
                                      context:context];
}

/// 动态注册路由信息
- (BOOL)registerRouteInfoWithUriHost:(NSString *)uriHost
                          uriQueries:(NSArray *)uriQueries
                        contextClass:(NSString *)contextClass
                             context:(LCRouteContext *)context {
    //唯一标识不能为空
    if (!kIsValidStr(uriHost) || !kIsValidStr(self.schemeURL)) {
        return NO;
    }
    //情景模型不能为空
    if (!context) {
        return NO;
    }
    //已注册
    if ([_routingTable valueForKey:uriHost]) {
        return NO;
    }
    
    LCRouterModel *routeModel = nil;
    if (context) {
        routeModel = [[LCRouterModel alloc] initWithUriHost:uriHost
                                                uriQueries:uriQueries
                                                   context:context];
    } else {
        routeModel = [[LCRouterModel alloc] initWithUriHost:uriHost
                                                uriQueries:uriQueries
                                              contextClass:contextClass];
    }
    
    //更新路由表
    [_routingTable yk_setValue:routeModel forKey:uriHost];
    //更新class对照表
    NSString *className = NSStringFromClass(routeModel.context.targetClass);
    if (![_classTable valueForKey:className]) { //未注册
        [_classTable yk_setValue:routeModel forKey:className];
    }
    return YES;
}

#pragma mark ----- router

- (BOOL)routeWithUri:(NSString *)uri {
    return [self routeWithUri:uri
                         from:nil
                   transition:LCRouteTransitionAuto
                     animated:YES
                        flush:NO];
}

- (BOOL)routeWithHost:(NSString *)host parameters:(nullable NSDictionary *)parameters {
    return [self routeWithHost:host parameters:parameters from:nil transition:LCRouteTransitionAuto animated:YES flush:NO];
}

- (BOOL)routeWithUri:(NSString *)uri
                from:(UIViewController *)fromViewController
          transition:(LCRouteTransition)transition
            animated:(BOOL)animated
               flush:(BOOL)flush {
    //URI不能为空
    if (!kIsValidStr(uri)) {
        return NO;
    }
    //补充头部
    NSString *routePath = [uri hasPrefix:self.schemeURL] ? uri : [NSString stringWithFormat:@"%@%@",self.schemeURL, uri];
    NSURL *routeURL = [NSURL URLWithString:routePath];
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[routePath queryDictionary]];
    [parameters yk_setValue:uri forKey:self.schemeURL];
    
    return [self routeWithHost:routeURL.host
                    parameters:parameters
                          from:fromViewController
                    transition:transition
                      animated:animated
                         flush:flush];
}

- (BOOL)routeWithHost:(NSString *)host
           parameters:(NSDictionary *)parameters
                 from:(UIViewController *)fromViewController
           transition:(LCRouteTransition)transition
             animated:(BOOL)animated
                flush:(BOOL)flush {
    //host唯一标识不能为空及&schemeUrl不能空
    if (!(host) || !kIsValidStr(self.schemeURL)) {
        return NO;
    }
    LCRouterModel *routeModel = [_routingTable valueForKey:host];
    //未注册
    if (!routeModel) {
        return NO;
    }
    //获取顶部控制器
    if (!fromViewController) {
        //主窗口顶部控制器
        UIWindow *mainWindow = [[[UIApplication sharedApplication] windows] firstObject];
        UIViewController *topViewController = [mainWindow findTopViewControllerInWindow];
        //清理路径控制器
        if (flush && topViewController.presentingViewController) { //顶部控制器为present方式弹出的页面
            //TODO: 无法获取返回值，需改为block回调
            [topViewController dismissViewControllerAnimated:NO completion:^{
                [self routeWithHost:host
                         parameters:parameters
                               from:fromViewController
                         transition:transition
                           animated:animated
                              flush:flush];
            }];
            return NO;
        }
        fromViewController = topViewController;
    }
    //是否可执行跳转
    LCRouteContext *context = routeModel.context;
    BOOL shouldRoute = YES;
    //询问代理
    if ([context respondsToSelector:@selector(router:shouldRouteFrom:parameters:transition:animated:)]) { //询问代理
        shouldRoute = [context router:self
                      shouldRouteFrom:fromViewController
                           parameters:parameters
                           transition:transition
                             animated:animated];
    }
    //自定义跳转
    if (!shouldRoute) {
         return YES;
    }
    BOOL canPush = ((context.supportedTransitions & LCRouteTransitionPush)
                    && (transition & LCRouteTransitionPush)
                    && fromViewController.navigationController); //支持Push
    BOOL canPresent = ((context.supportedTransitions & LCRouteTransitionPresent)
                       && (transition & LCRouteTransitionPresent)); //支持Present
    if (!canPush && !canPresent) { //不满足转场条件
        return NO;
    }
    //创建目标视图控制器
    if (![context.targetClass isSubclassOfClass:[UIViewController class]]) {
        return NO; //未找到class，或class不是视图控制器类型
    }
    
    UIViewController *targetViewController = [[context.targetClass alloc] init];
    
    //配置目标视图控制器属性
    if (parameters.count) {
        NSArray *parameterKeys = context.keyPathMap.allKeys;
        for (int i = 0; i < parameterKeys.count; i++) {
            NSString *parameterKey = parameterKeys[i];
            if (!parameterKey.length) {
                continue;
            }
            id parameterValue = [parameters valueForKey:parameterKey];
            if (!parameterValue) {
                continue;
            }
            NSString *keyPath = [context.keyPathMap stringForKey:parameterKey];
            if (!keyPath.length) {
                continue;
            }
            if ([targetViewController validateValue:&parameterValue forKeyPath:keyPath error:nil]) {
                [targetViewController setValue:parameterValue forKeyPath:keyPath];
            }
        }
    }
    //跳转页面
    if (canPush) {
        [fromViewController.navigationController pushViewController:targetViewController animated:animated];
     
    } else if (canPresent) {
        if ([targetViewController isKindOfClass:[UINavigationController class]]) {
            targetViewController.modalPresentationStyle = 0;
            [fromViewController presentViewController:targetViewController animated:animated completion:nil];
        } else {
            UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:targetViewController];
            naviC.modalPresentationStyle = 0;
            [fromViewController presentViewController:naviC animated:animated completion:nil];
        }
    }
    return YES;
}


@end
