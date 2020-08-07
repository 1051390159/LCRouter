# LCRouter

[![CI Status](https://img.shields.io/travis/liubin/LCRouter.svg?style=flat)](https://travis-ci.org/liubin/LCRouter)
[![Version](https://img.shields.io/cocoapods/v/LCRouter.svg?style=flat)](https://cocoapods.org/pods/LCRouter)
[![License](https://img.shields.io/cocoapods/l/LCRouter.svg?style=flat)](https://cocoapods.org/pods/LCRouter)
[![Platform](https://img.shields.io/cocoapods/p/LCRouter.svg?style=flat)](https://cocoapods.org/pods/LCRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

遵循协议：xx://aa?x=temp

安装
LCRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LCRouter'
```
注册
可以在appDelegate里进行注册，示例,(route这里是一个plist文件，大家可以在demo里进行下载，SchemeUrl不能为空，格式为：xx://)
```ruby
[[LCRouter sharedInstance] registerDefaultRoutingTableWithRoutePlistName:@"route" withSchemeUrl:@""];
```

支持自定义页面间的跳转逻辑
大家可以通过从route表里的class增加路由拦截，然后在继承LCRouterContext类，在代理方中返回no即可，请看实例
```ruby
#import "LCFirstViewControllerContext.h"

@implementation LCFirstViewControllerContext

- (BOOL)router:(LCRouter *)router
shouldRouteFrom:(UIViewController *)fromViewController
    parameters:(NSDictionary *)parameters
    transition:(LCRouteTransition)transition
      animated:(BOOL)animated {
    [[LCBaseTabBarViewController tabBarCtrl] switchToTabAtIndex:0];
    return NO;
}

@end
```
路由跳转方法：
目前提供两个API供大家使用
```ruby
/// url标准格式跳转
/// @param uri  xeample: 'schemeUrl://host?key=value'格式
- (BOOL)routeWithUri:(NSString *)uri;

/// host自定定义跳转
/// @param host 目标host
/// @param parameters 自定义参数
- (BOOL)routeWithHost:(NSString *)host parameters:(nullable NSDictionary *)parameters;
```

## Author

liubin, 1051390159@qq.com

## License

LCRouter is available under the MIT license. See the LICENSE file for more info.
