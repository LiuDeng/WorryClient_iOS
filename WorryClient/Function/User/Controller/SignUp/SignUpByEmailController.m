//
//  SignUpByEmailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "SignUpByEmailController.h"
#import "SignUpAndLogInView.h"
#import "UserService.h"

@interface SignUpByEmailController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *emailTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UIButton *signUpButton;
@property (nonatomic,strong) SignUpAndLogInView *signUpAndLogInView;
@end
@implementation SignUpByEmailController

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
    self.signUpAndLogInView = [[SignUpAndLogInView alloc]initWithAccountPlaceholder:@"请输入邮箱" passwordPlaceholder:@"请输入密码" buttonTitle:@"注册"];
    [self.view addSubview:self.signUpAndLogInView];
    
    [self.signUpAndLogInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.dividedBy(2);
        make.height.equalTo(self.view).with.dividedBy(3);
        make.width.equalTo(self.view);
    }];
    
    [self loadEmailTextField];
    [self loadPasswordTextField];
    [self loadSignUpButton];
}
- (void)loadEmailTextField
{
    self.emailTextField = self.signUpAndLogInView.accountTextField;
    self.emailTextField.delegate = self;
}
- (void)loadPasswordTextField
{
    self.passwordTextField = self.signUpAndLogInView.passwordTextField;
    self.passwordTextField.delegate = self;
}
- (void)loadSignUpButton
{
    self.signUpButton = self.signUpAndLogInView.button;
    [self.signUpButton addTarget:self
                          action:@selector(clickSignUpButton)
                forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - Utils
- (void)clickSignUpButton
{
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (email.length == 0 || password == 0) {
        //
    }else{
        [[UserService sharedInstance]signUpByEmail:email password:password block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // 
            }
        }];
    }
}
@end
