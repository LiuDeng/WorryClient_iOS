//
//  UIView+Utils.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)
+ (void)setRoundCorner:(UIView *)view;
+ (void)setRoundCorner:(UIView *)view radius:(CGFloat)radius;
+ (void)setAsRound:(UIView *)view;
@end
