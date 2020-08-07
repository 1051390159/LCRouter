//
//  LCRouterDefineHeader.h
//  Pods
//
//  Created by 刘彬 on 2020/8/6.
//

#ifndef LCRouterDefineHeader_h
#define LCRouterDefineHeader_h

#define isNilOrNull(_str)   (((_str) == nil) || ([(_str) isEqual:[NSNull null]]) || ([(_str) isKindOfClass:[NSNull class]]) )
#define isValidStr(_str) ((isNilOrNull(_str)==NO) && ([_str length]>0))

#endif /* LCRouterDefineHeader_h */
