//
//  WWConfiguration.h
//  WWDaily
//
//  Created by wangyongwang on 2018/7/31.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 @[@"基础使用",@"Button ContentMode",@"Button多个状态点击",@"Button 动画",@"button 扩大点击区域",@"Button 图片文字排列",@"Button image缓存",@"Button 自己实现"];
 */
typedef NS_ENUM(NSInteger,WWButtonType){
    WWButtonTypeNormal,
    WWButtonTypeContentMode,
    WWButtonTypeClickState,
    WWButtonTypeAnimation,
    WWButtonTypeEnlargeClickedArea,
    WWButtonTypeImageTextArrange,
    WWButtonTypeImageCache,
    WWButtonTypeSelfRealize,
};
@interface WWConfiguration : NSObject

@end
