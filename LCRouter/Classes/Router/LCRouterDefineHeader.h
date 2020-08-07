//
//  LCRouterDefineHeader.h
//  Pods
//
//  Created by 刘彬 on 2020/8/6.
//

#ifndef LCRouterDefineHeader_h
#define LCRouterDefineHeader_h

#define kIsNilOrNull(_str)   (((_str) == nil) || ([(_str) isEqual:[NSNull null]]) || ([(_str) isKindOfClass:[NSNull class]]) )
#define kIsValidStr(_str) ((kIsNilOrNull(_str)==NO) && ([_str length]>0))

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* LCRouterDefineHeader_h */
