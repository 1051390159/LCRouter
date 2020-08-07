//
//  NSDictionary+Addition.h
//  LCRouter
//
//  Created by 刘彬 on 2020/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Addition)

///若非NSString类型，返回对象stringValue或description，默认为nil
- (NSString *)stringForKey:(NSString *)key;

///默认为nil
- (NSDictionary *)dictionaryForKey:(NSString *)key;

@end

@interface NSMutableDictionary(YKSafeAccess)

///安全地设值，做了object以及key是否为nil的判断
-(void)yk_setObject:(id)anObject forKey:(id)aKey;

///安全地设值，做了key是否为NSString的判断
-(void)yk_setValue:(id)value forKey:(NSString*)key;
@end


NS_ASSUME_NONNULL_END
