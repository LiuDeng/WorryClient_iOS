//
//  UIView+Utils.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIView+Utils.h"

const CGFloat kRadius = 4;  //  if is ipad,should be 8

@implementation UIView (Utils)

+ (void)setRoundCorner:(UIView *)view
{
    [self setRoundCorner:view radius:kRadius];
}

+ (void)setRoundCorner:(UIView *)view radius:(CGFloat)radius
{
    [view.layer setCornerRadius:radius];
    [view.layer setMasksToBounds:YES];
}
+ (void)setAsRound:(UIView *)view
{
    [view.layer setCornerRadius:CGRectGetWidth(view.frame)/2];
    [view.layer setMasksToBounds:YES];
    view.clipsToBounds = YES;
}
@end
