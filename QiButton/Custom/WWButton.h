//
//  WWButton.h
//  WWDaily
//
//  Created by wangyongwang on 2018/8/2.
//  Copyright © 2018年 WYW. All rights reserved.
//
//学习地址：https://www.jianshu.com/p/43c22fa3b42c

#import <UIKit/UIKit.h>

@interface WWButton : UIButton

/*! @brief 点击范围的扩充值 次值目前只是为了演示 把较大按钮的点击范围变小 */
@property (nonatomic,assign) CGFloat ww_expandValue;

@end
