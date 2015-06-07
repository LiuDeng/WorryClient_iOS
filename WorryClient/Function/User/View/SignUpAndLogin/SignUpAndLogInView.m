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
    }
    return self;
}

#pragma mark - Private methods
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat heightScale = 0.3;
    CGFloat widthScale = 0.9;
    
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(self).with.multipliedBy(widthScale);
        make.height.equalTo(self).with.multipliedBy(heightScale);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.accountTextField.mas_bottom);
        make.width.equalTo(self).with.multipliedBy(widthScale);
        make.height.equalTo(self).with.multipliedBy(heightScale);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(self).with.multipliedBy(widthScale);
        make.height.equalTo(self).with.multipliedBy(heightScale);
    }];
    
//    [UIView setRoundCorner:self.accountTextField];
//    [UIView setRoundCorner:self.passwordTextField];
    [self.accountTextField setRoundCorner];
    [self.passwordTextField setRoundCorner];
}
@end

