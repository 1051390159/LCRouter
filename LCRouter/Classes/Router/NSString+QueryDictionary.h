//
//  NSString+QueryDictionary.h
//  LCRouter
//
//  Created by 刘彬 on 2020/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QueryDictionary)

/// 解析路由url参数
- (NSDictionary *)queryDictionary;

@end

NS_ASSUME_NONNULL_END
