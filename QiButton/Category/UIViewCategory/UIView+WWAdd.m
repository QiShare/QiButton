//
//  UIView+WWAdd.m
//  QiButton
//
//  Created by wangyongwang on 2018/8/3.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "UIView+WWAdd.h"

@implementation UIView (WWAdd)
#if 0
- (UIImage *)ww_drawRectwithViewSize:(CGSize)viewSize roundedCorner:(CGFloat)corner borderWidth:(CGFloat)borderW backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor{
    UIGraphicsBeginImageContextWithOptions(viewSize, false, [UIScreen mainScreen].scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(currentContext, .0, .0);
    CGContextAddArcToPoint(currentContext, , <#CGFloat y1#>, <#CGFloat x2#>, <#CGFloat y2#>, <#CGFloat radius#>)
    return nil;
}
#endif
@end
