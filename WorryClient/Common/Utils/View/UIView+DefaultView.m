//
//  UIView+DefaultView.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIView+DefaultView.h"
#import "ViewDefault.h"

@implementation UIView (DefaultView)

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
/*
 *  生成默认textField。
 *  调用的时候记得得设置垂直方向的坐标
 */

+(UITextField*)defaultTextField:(NSString*)placeholder
                      superView:(UIView*)superView
{
    UITextField *textField = [[UITextField alloc]init];
    textField.font = kTextFieldPlaceholderFont;
    textField.textColor = kTextFieldTextColor;
    textField.backgroundColor = [UIColor whiteColor];   //  背景颜色：白色
    textField.placeholder = placeholder;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.layer.borderWidth = kLayerBorderWidth;
    textField.layer.borderColor = [kLayerColor CGColor];
    textField.clearButtonMode = UITextFieldViewModeAlways;     //  清除按钮
    [textField becomeFirstResponder];   //  第一响应者
    [superView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.width.equalTo(superView);
        make.height.equalTo(@(kTextFieldHeight));
    }];
    return textField;
}

+(UITextField*)textFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc]init];
    textField.font = kTextFieldPlaceholderFont;
    textField.textColor = kTextFieldTextColor;
    textField.backgroundColor = [UIColor whiteColor];   //  背景颜色：白色
    textField.placeholder = placeholder;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.layer.borderWidth = kLayerBorderWidth;
    textField.layer.borderColor = [kLayerColor CGColor];
    textField.clearButtonMode = UITextFieldViewModeAlways;     //  清除按钮
    [textField becomeFirstResponder];   //  第一响应者
    return textField;
}
+ (UIButton *)buttonWithNormalTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [UIView setRoundCorner:button];
    return button;
}
@end
