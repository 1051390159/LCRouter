//
//  NSString+QueryDictionary.m
//  LCRouter
//
//  Created by 刘彬 on 2020/8/6.
//

#import "NSString+QueryDictionary.h"
#import "NSDictionary+Addition.h"

@implementation NSString (QueryDictionary)

- (NSDictionary *)queryDictionary{
    NSArray *array = [self componentsSeparatedByString:@"?"];
    NSString *queryString = array.count <= 1 ? array[0] : array[1];
    NSString *urlString =  array[0];
    NSArray *hostArray = [urlString componentsSeparatedByString:@"//"];
    NSString *hostString = hostArray.count <= 1 ? hostArray[0] : hostArray[1];
    //处理参数
    NSArray *querys = [queryString componentsSeparatedByString:@"&"];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSString *item in querys) {
        NSArray *strings = [item componentsSeparatedByString:@"="];
        if (strings.count == 2) {
            NSString *key = strings[0];
            NSString *value = [((NSString *)strings[1]) stringByRemovingPercentEncoding];
            [dictionary yk_setValue:value forKey:key];
        }
    }
    //处理web参数
    if ([hostString isEqualToString:@"web"]) {
        return [self dealWithDictionnary:dictionary urlParameterTagStr:@"stringUrl"];
    }
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

/// 拆解web链接格式
/// @param sourceDic 源参数集合
/// @param tagertUrl 目标链接
- (NSDictionary *)dealWithDictionnary:(NSDictionary *)sourceDic urlParameterTagStr:(NSString *)tagertUrl{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:sourceDic];
    NSMutableDictionary *webDictionary = [NSMutableDictionary dictionary];
    NSString *webUrl ;
    if ([tempDic.allKeys containsObject:tagertUrl]) {
        webUrl = [NSString stringWithFormat:@"%@",[sourceDic objectForKey:tagertUrl]];
        [tempDic removeObjectForKey:tagertUrl];
        for (int i = 0; i<tempDic.allValues.count; i++) {
            NSString * separateString = i == 0 ? @"?":@"&";
            webUrl = [NSString stringWithFormat:@"%@%@%@=%@",webUrl,separateString,tempDic.allKeys[i],tempDic.allValues[i]];
        }
        [webDictionary yk_setValue:webUrl forKey:tagertUrl];
    }
    return [NSDictionary dictionaryWithDictionary:webDictionary];
}
@end
