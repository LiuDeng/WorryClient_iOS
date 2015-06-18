//
//  UpdatePWDController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  普通方式
//  其他方式：暂时只有手机短信
//  手机短信:请求验证码 通过之后 输入新密码（EditController）

#import "UpdatePWDController.h"
#import "UIViewController+LogInSignUp.h"

@interface UpdatePWDController ()

@property (nonatomic,strong) UITextField *oldPWDField;  //  old password field
@property (nonatomic,strong) UITextField *pwdField;     // new password field,newPWDField is similar to propery form Cocoa

@end

@implementation UpdatePWDController

- (void)loadView
{
    [super loadView];
    self.title = @"修改密码";
    self.view.backgroundColor = kBGColor;
    [self addRightButtonWithTitle:@"提交" target:self action:@selector(submit)];
    
    self.oldPWDField = [UITextField defaultTextField:@"请输入旧密码" superView:self.view];
    [self.oldPWDField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(+kVerticalPadding*2);
    }];
    
    self.pwdField = [UITextField defaultTextField:@"请输入新密码" superView:self.view];
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oldPWDField.mas_bottom);
    }];

    [self.oldPWDField becomeFirstResponder];
    
}

#pragma mark - Utils

- (void)submit
{
    //  check old password
    
    NSString *oldPWD = self.oldPWDField.text;
    NSString *newPWD = self.pwdField.text;
    
    [[UserService sharedInstance]updatePWD:oldPWD newPWD:newPWD block:^(NSError *error) {
        if (error) {
            POST_ERROR_MSG(@"修改失败");
        }else{
            POST_SUCCESS_MSG(@"修改成功");
            [[UserService sharedInstance]logOut];
            [self goToLogIn];
        }
    }];
}




@end
