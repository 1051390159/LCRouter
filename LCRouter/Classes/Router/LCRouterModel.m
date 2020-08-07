//
//  LCRouterModel.m
//  LCRouter
//
//  Created by 刘彬 on 2020/8/5.
//

#import "LCRouterModel.h"

@implementation LCRouterModel

- (instancetype)initWithUriHost:(NSString *)uriHost
                     uriQueries:(NSArray *)uriQueries
                   contextClass:(NSString *)contextClass {
    self = [super init];
    if (self) {
        _uriHost = uriHost;
        _uriQueries = uriQueries;
        Class class = NSClassFromString(contextClass);
        if ([class isSubclassOfClass:[LCRouteContext class]]) {
            _context = [[class alloc] init];
        } else {
            _context = [[LCRouteContext alloc] init];
        }
    }
    return self;
}

- (instancetype)initWithUriHost:(NSString *)uriHost
                     uriQueries:(NSArray *)uriQueries
                        context:(LCRouteContext *)context {
    self = [super init];
    if (self) {
        _uriHost = uriHost;
        _uriQueries = uriQueries;
        if ([context isKindOfClass:[LCRouteContext class]]) {
            _context = context;
        } else {
            _context = [[LCRouteContext alloc] init];
        }
    }
    return self;
}

@end
