//
//  UpdatePhoneController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/8.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UpdatePhoneController.h"
#import "ViewDefault.h"

@interface UpdatePhoneController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *getCodeBtn;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,assign) NSInteger secondsCountDown;

@end

@implementation UpdatePhoneController

#pragma mark - Default methods

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = kBGColor;
    [self loadTextField];
    [self loadVerifyBtn];
    [self loadCodeTextField];
    [self addRightButtonWithTitle:@"验证" target:self action:@selector(clickVerifyBtn)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - Private methods

- (void)loadTextField
{
    self.textField = [UITextField defaultTextField:@"11位手机号" superView:self.view];
    self.textField.delegate = self;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(+kVerticalPadding);
    }];
    
    [self.textField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
}

- (void)loadVerifyBtn
{
    self.getCodeBtn = [UIButton buttonWithNormalTitle:@"获取验证码"];
    [self.view addSubview:self.getCodeBtn];
    [self.getCodeBtn addTarget:self action:@selector(clickGetCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.getCodeBtn.enabled = NO;
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).with.offset(+kVerticalPadding);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadCodeTextField
{
    self.codeTextField = [UITextField textFieldWithPlaceholder:@"x位验证码"];
    [self.view addSubview:self.codeTextField];
    [self.codeTextField setRoundCorner];
    [self.codeTextField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.getCodeBtn.mas_bottom).with.offset(+kVerticalPadding);
        make.width.equalTo(self.view).with.multipliedBy(0.3);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kTextFieldHeight);
    }];
}

#pragma mark - Utils

- (void)clickGetCodeBtn:(UIButton *)button
{
    NSString *text = self.textField.text;
    BOOL valid = [Utils isValidMobile:text];
    __block NSTimer *timer;
    self.secondsCountDown = 60;    //  60s
    if (valid) {
        [[UserService sharedInstance]requestSmsCodeWithPhone:text callback:^(NSError *error) {
            if (error == nil) {
                POST_SUCCESS_MSG(@"验证码已经发送");
                [self.codeTextField becomeFirstResponder];
                
                timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(countDown)
                                                       userInfo:nil
                                                        repeats:YES];
    
            }else{
                POST_ERROR_MSG(@"出错了，请稍候再试");
            }
        }];
    }else{
        POST_ERROR_MSG(@"请输入有效手机号码");
    }
    
}

- (void)clickVerifyBtn
{
    NSString *code = self.codeTextField.text;
    NSString *phone = self.textField.text;
    [[UserService sharedInstance]verifySmsCode:code mobilePhoneNumber:phone callback:^(NSError *error) {
        if (error == nil) {
            POST_SUCCESS_MSG(@"验证成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            POST_ERROR_MSG(@"验证失败");
        }
    }];
}

- (void)valueChanged:(UITextField *)textField
{
    if ([textField isEqual:self.textField]) {
        if (textField.text.length>0) {
            self.getCodeBtn.enabled = YES;
            [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            self.getCodeBtn.enabled = NO;
            [self.getCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }else {
        if (textField.text.length>0) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }else{
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
    
}

- (void)countDown
{
    NSString *title;
    if (self.secondsCountDown == 0) {
        title = @"获取验证码";
        self.getCodeBtn.enabled = YES;
    }else{
        title = [NSString stringWithFormat:@"%ld秒之后再次发送",self.secondsCountDown--];
        self.getCodeBtn.enabled = NO;
    }
    [self.getCodeBtn setTitle:title forState:UIControlStateNormal];
}

@end
