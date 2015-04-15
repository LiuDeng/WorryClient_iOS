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
        self.accountTextField = [[UITextField alloc]init];
        [self addSubview:self.accountTextField];
        self.accountTextField.placeholder = accountPlaceholder;
        self.accountTextField.textAlignment = NSTextAlignmentCenter;
        
//        self.accountTextField.delegate = controller;
        //  输入密码
        self.passwordTextField = [[UITextField alloc]init];
        self.passwordTextField.placeholder = passwordPlaceholder;
        [self addSubview:self.passwordTextField];
        
//        self.passwordTextField.secureTextEntry = YES;
        [self.passwordTextField setBackgroundColor:[UIColor whiteColor]];
        self.passwordTextField.returnKeyType = UIReturnKeyDone; //  键盘“换行”变成“完成”
        self.passwordTextField.textAlignment = NSTextAlignmentCenter;
        
//        self.passwordTextField.delegate = controller;
        
        //  提交按钮
        self.button = [[UIButton alloc]init];
        [self addSubview:self.button];
        [self.button setTitle:buttonTitle forState:UIControlStateNormal];
        
  //  点击提交按钮触发的事件
//        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(+kButtonPadding);
//        }];
        
//        [self.accountTextField layoutIfNeeded];
//        [self.passwordTextField layoutIfNeeded];
//        [self.button layoutIfNeeded];

        self.accountTextField.backgroundColor = [UIColor greenColor];
        self.passwordTextField.backgroundColor = [UIColor yellowColor];
        self.button.backgroundColor = [UIColor redColor];
    }
    return self;
}

#pragma mark - Private methods
- (void)layoutSubviews
{
    [super layoutSubviews];
//    CGRect frame = se?lf.bounds;
    CGRect frame = self.bounds;
//    CGFloat frameX = self.bounds.origin.x;
//    CGFloat frameY = self.bounds.origin.y;
//    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGRect accountTextFieldFrame = frame;
    accountTextFieldFrame.size.height = height/3;
    self.accountTextField.frame = accountTextFieldFrame;
    
    
    CGRect passwordTextFieldFrame = frame;
    passwordTextFieldFrame.origin.y = CGRectGetMaxY(accountTextFieldFrame);
    passwordTextFieldFrame.size.height = height/3;
    self.passwordTextField.frame = passwordTextFieldFrame;
    
    CGRect buttonFrame = frame;
    buttonFrame.origin.y = CGRectGetMaxY(passwordTextFieldFrame);
    buttonFrame.size.height = height/3;
    self.button.frame = buttonFrame;
    

}
//- (void)loadAccountTextField
//{
//    self.accessibility
//}
@end

