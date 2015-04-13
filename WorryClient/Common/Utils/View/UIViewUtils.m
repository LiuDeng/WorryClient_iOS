//
//  UIViewUtils.m
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewUtils.h"
#import "ViewInfo.h"
#import "Masonry.h"

@implementation UIView(UIViewUtils)


+ (void)setAsRound:(UIView *)view
{
    [view.layer setCornerRadius:CGRectGetWidth(view.frame)/2.0f];
    [view.layer setMasksToBounds:YES];
    view.clipsToBounds = YES;
}
#pragma mark - Line
//  普通横线
+(UIView*)creatSingleLineWithColor:(UIColor *)color
                       borderWidth:(CGFloat)borderWidth
                         superView:(id)superView
{
    UIView *view = [[UIView alloc]init];
    [superView addSubview:view];
    view.backgroundColor = color;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(borderWidth));
        make.width.equalTo(superView);
        make.centerX.equalTo(superView);
    }];
    return view;
}

//  上方横线
+(void)addTopLineWithColor:(UIColor *)color
               borderWidth:(CGFloat)borderWidth
                 superView:(id)superView
{
    UIView *view = [UIView creatSingleLineWithColor:color
                                        borderWidth:borderWidth
                                          superView:superView];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
    }];
}

//  下方横线
+(void)addBottomLineWithColor:(UIColor *)color
                  borderWidth:(CGFloat)borderWidth
                    superView:(id)superView
{
    UIView *view = [UIView creatSingleLineWithColor:color
                                        borderWidth:borderWidth
                                          superView:superView];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView);
    }];
}


@end
