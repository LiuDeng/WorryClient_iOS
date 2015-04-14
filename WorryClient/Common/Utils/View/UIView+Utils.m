//
//  UIView+Utils.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

+ (void)setAsRound:(UIView *)view
{
    [view.layer setCornerRadius:CGRectGetWidth(view.frame)/2];
    [view.layer setMasksToBounds:YES];
    view.clipsToBounds = YES;
}
@end
