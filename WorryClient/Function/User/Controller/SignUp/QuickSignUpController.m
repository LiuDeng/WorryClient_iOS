//
//  QuickSignUpController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "QuickSignUpController.h"
#import "SignUpAndLogInView.h"
#import "UserService.h"
#import "UIView+DefaultView.h"

@interface QuickSignUpController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *smsCodeTextField;
@property (nonatomic,strong) UIButton *submitButton;
@property (nonatomic,strong) UIButton *signUpButton;
@property (nonatomic,copy) NSString *phoneString;   //  strong -> copy?


@end

@implementation QuickSignUpController

#pragma mark - Default methods

- (void)loadView
{
    [super loadView];
//    [self loadPhoneTextField];
//    [self loadSubmitButton];
    [self loadSmsCodeTextField];
    [self loadSignUpButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)loadPhoneTextField
{
    NSString *placeholder = @"请输入手机号码";
    self.phoneTextField = [UITextField textFieldWithPlaceholder:placeholder];
    [self.view addSubview:self.phoneTextField];
    self.phoneTextField.delegate = self;
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.multipliedBy(0.3);
        make.height.equalTo(self.view).with.dividedBy(9);
        make.width.equalTo(self.view);
    }];
}

- (void)loadSubmitButton
{
    self.submitButton = [UIButton buttonWithNormalTitle:@"获取验证码"];
    [self.view addSubview:self.submitButton];
    [self.submitButton addTarget:self
                          action:@selector(clickSubmitButton)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.view).with.dividedBy(9);
        make.width.equalTo(self.view).with.multipliedBy(0.9);
        make.centerY.equalTo(self.view).with.multipliedBy(0.5);
    }];
}

- (void)loadSmsCodeTextField
{
    self.smsCodeTextField = [UITextField textFieldWithPlaceholder:@"验证码"];
    [self.view addSubview:self.smsCodeTextField];
    self.smsCodeTextField.delegate = self;
    [self.smsCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.view).with.dividedBy(9);
        make.width.equalTo(self.view);//.with.multipliedBy(0.9);
    }];
    
}

- (void)loadSignUpButton
{
    self.signUpButton = [UIButton buttonWithNormalTitle:@"注册"];
    [self.view addSubview:self.signUpButton];
    [self.signUpButton addTarget:self
                          action:@selector(clickSignUpButton)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.multipliedBy(1.2);
        make.height.equalTo(self.view).with.dividedBy(9);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
    }];
}

#pragma mark - Utils

- (void)clickSubmitButton
{
    //  TODO
    self.phoneString = self.phoneTextField.text;
    
    if (self.phoneString.length == 0 ) {
        //  TODO add tips
    }else{
        [[UserService sharedInstance]requestSmsCodeWithPhone:self.phoneString callback:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                //
                [self loadSmsCodeTextField];
                [self loadSignUpButton];
            }else{
//                JDDebug(@"error: %@",error);
            }
        }];

    }
}

- (void)clickSignUpButton
{
    NSString *smsCode = self.smsCodeTextField.text;

//    NSString *testPhoneString = @"15625987607";
    if (smsCode.length != 0) {
        [[UserService sharedInstance]signUpOrLogInWithPhoneInBackground:self.phoneString smsCode:smsCode block:^(NSError *error) {
            if (error == nil) {
                //
            }
        }];
    }
}
#pragma mark - UITextFieldDelegate

//  点击“return”或者“Done”执行的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        [self clickSubmitButton];
        return [textField resignFirstResponder];
    }else{
        return YES;
    }
}

//  textField完成编辑之后
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        [textField resignFirstResponder];
    }else{
        
    }
}
@end
