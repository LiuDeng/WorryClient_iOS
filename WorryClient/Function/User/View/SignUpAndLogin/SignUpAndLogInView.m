//
//  SignUpAndLogInView.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "SignUpAndLogInView.h"
#import "Masonry.h"
#import "UIView+DefaultView.h"
#import "ViewDefault.h"

const float kButtonPadding = 16.0f;  //  按钮间距
const float kButtonVerticalPadding = 5.0f;   // 垂直方向间距

@implementation SignUpAndLogInView

#pragma mark - Public methods
-(id)initWithAccountPlaceholder:(NSString*)accountPlaceholder
            passwordPlaceholder:(NSString*)passwordPlaceholder
                    buttonTitle:(NSString*)buttonTitle
{
    self = [super init];
    if (self) {
        //  输入账户
        self.accountTextField = [UITextField textFieldWithPlaceholder:accountPlaceholder];
        [self addSubview:self.accountTextField];
        
        //  输入密码
        self.passwordTextField = [UITextField textFieldWithPlaceholder:passwordPlaceholder];
        [self addSubview:self.passwordTextField];
        [self.passwordTextField resignFirstResponder];
        self.passwordTextField.secureTextEntry = YES;
        self.passwordTextField.returnKeyType = UIReturnKeyDone; //  键盘“换行”变成“完成”
        
        //  提交按钮
        self.button = [UIButton buttonWithNormalTitle:buttonTitle];
        [self addSubview:self.button];

        self.button.backgroundColor = [UIColor redColor];
    }
    return self;
}

#pragma mark - Private methods
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    CGRect accountTextFieldFrame = frame;
    accountTextFieldFrame.size.height = height/3;
    self.accountTextField.frame = accountTextFieldFrame;
    
    CGRect passwordTextFieldFrame = frame;
    passwordTextFieldFrame.origin.y = CGRectGetMaxY(accountTextFieldFrame);
    passwordTextFieldFrame.size.height = height/3;
    self.passwordTextField.frame = passwordTextFieldFrame;
    
    CGRect buttonFrame = frame;
    buttonFrame.origin.x = frame.origin.x + width * 0.05;
    buttonFrame.origin.y = CGRectGetMaxY(passwordTextFieldFrame) + (height/3)*0.1;
    buttonFrame.size.height = (height/3)*0.9;
    buttonFrame.size.width = width*0.9;
    self.button.frame = buttonFrame;
}
@end

