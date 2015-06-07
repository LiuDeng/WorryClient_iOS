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

- (void)setRoundCorner
{
    [self setRoundCornerWithRadius:kRadius];
}

- (void)setRoundCornerWithRadius:(CGFloat)radius
{
    [self.layer setCornerRadius:radius];
    [self.layer setMasksToBounds:YES];
}
- (void)setAsRound
{
    [self.layer setCornerRadius:CGRectGetWidth(self.frame)/2];
    [self.layer setMasksToBounds:YES];
    self.clipsToBounds = YES;
}
@end
