//
//  LCRouteContext.m
//  LCRouter
//
//  Created by 刘彬 on 2020/8/5.
//

#import "LCRouteContext.h"

@implementation LCRouteContext

- (instancetype)init {
    self = [super init];
    if (self) {
        _supportedTransitions = LCRouteTransitionAuto;
    }
    return self;
}

@end
