//
//  NSDictionary+Addition.m
//  LCRouter
//
//  Created by 刘彬 on 2020/8/6.
//

#import "NSDictionary+Addition.h"
#import "LCRouterDefineHeader.h"

@implementation NSDictionary (Addition)

- (id)valueForKey:(NSString *)key withClass:(Class)aClass
{
    id value = [self objectForKey:key];
    return [value isKindOfClass:aClass] ? value : nil;
}

- (NSString *)stringForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    } else {
        return nil;
    }
}

- (NSDictionary *)dictionaryForKey:(NSString *)key
{
    return [self valueForKey:key withClass:[NSDictionary class]];
}

@end

@implementation NSMutableDictionary (YKSafeAccess)

-(void)yk_setObject:(id)anObject forKey:(id)aKey
{
    if(!aKey) {
        return;
    }
    if(!anObject){
        return;
    }
    [self setObject:anObject forKey:aKey];
}

-(void)yk_setValue:(id)value forKey:(NSString*)key
{
    if (!kIsValidStr(key)) {
        return;
    }
    [self setValue:value forKey:key];
}

@end
