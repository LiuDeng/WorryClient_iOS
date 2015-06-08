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
@property (nonatomic,strong) UIButton *verifyBtn;
@property (nonatomic,strong) UITextField *codeTextField;

@end

@implementation UpdatePhoneController

#pragma mark - Default methods

- (void)loadView
{
    [super loadView];
    [self loadTextField];
    [self loadVerifyBtn];
    [self loadCodeTextField];
    [self addRightButtonWithTitle:@"保存" target:self action:@selector(clickSaveBtn)];
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
    //  TODO 再次获取呢？
    self.verifyBtn = [UIButton buttonWithNormalTitle:@"获取验证码"];
    [self.view addSubview:self.verifyBtn];
    [self.verifyBtn addTarget:self action:@selector(clickVerifyBtn) forControlEvents:UIControlEventTouchUpInside];
    self.verifyBtn.enabled = NO;
    
    [self.verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(self.verifyBtn.mas_bottom).with.offset(+kVerticalPadding);
        make.width.equalTo(self.view).with.multipliedBy(0.3);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@kTextFieldHeight);
    }];
}

#pragma mark - Utils

- (void)clickVerifyBtn
{
    //  TODO 这里得对textField再加一次验证，防止出错。验证textField.text.length
}

- (void)clickSaveBtn
{
    //  save the phone num,update phoneVerify(true)
}

- (void)valueChanged:(UITextField *)textField
{
    if ([textField isEqual:self.textField]) {
        if (textField.text.length>0) {
            self.verifyBtn.enabled = YES;
            [self.verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            self.verifyBtn.enabled = NO;
            [self.verifyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }else {
        if (textField.text.length>0) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }else{
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
    
}

@end
