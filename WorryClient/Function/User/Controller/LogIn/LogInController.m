//
//  LogInController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "LogInController.h"
#import "SignUpAndLogInView.h"

@interface LogInController()

@property (nonatomic,strong) UITextField *accountTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UIButton *logInButton;

@property (nonatomic,strong) SignUpAndLogInView *signUpAndLogInView;

@end

@implementation LogInController

#pragma mark - Default methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)loadView
{
    [super loadView];
    [self loadSignUpAndLogInView];
}
#pragma mark - Private methods

- (void)loadSignUpAndLogInView
{
    self.signUpAndLogInView = [[SignUpAndLogInView alloc]initWithAccountPlaceholder:@"请输入用户名/手机/邮箱"
                                                                passwordPlaceholder:@"请输入密码"
                                                                        buttonTitle:@"登录"];
    [self.view addSubview:self.signUpAndLogInView];
    
    [self.signUpAndLogInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(self.view).with.dividedBy(3);
        make.width.equalTo(self.view);
    }];
}

- (void)loadAccountTextField
{
    self.accountTextField = self.signUpAndLogInView.accountTextField;

}
- (void)loadPasswordTextField
{
    self.passwordTextField = self.signUpAndLogInView.passwordTextField;
}

- (void)loadLogInButton
{
    self.logInButton = self.signUpAndLogInView.button;
    [self.logInButton addTarget:self
                         action:@selector(clickLogInButton)
               forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - Utils
- (void)clickLogInButton
{
    //  TODO    
}
@end
