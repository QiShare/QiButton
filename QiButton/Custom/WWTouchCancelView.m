//
//  WWTouchCancelView.m
//  WWDaily
//
//  Created by wangyongwang on 2018/8/2.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "WWTouchCancelView.h"

@implementation WWTouchCancelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return nil;
}

@end
