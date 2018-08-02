//
//  WWButton.m
//  WWDaily
//
//  Created by wangyongwang on 2018/8/2.
//  Copyright © 2018年 WYW. All rights reserved.
//
//学习地址：https://www.jianshu.com/p/43c22fa3b42c

#import "WWButton.h"


@implementation WWButton



- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (_ww_expandValue) {
        CGRect bounds = CGRectInset(self.bounds, _ww_expandValue, _ww_expandValue);
        return CGRectContainsPoint(bounds, point);
    }
    //获取bounds 实际大小
    CGRect bounds = self.bounds;
    
    //若热区小于 44 * 44 则放大热区 否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, .0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, .0);
    //扩大bounds
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    //点击的点在新的bounds 中 就会返回YES
    return CGRectContainsPoint(bounds, point);
}



@end
