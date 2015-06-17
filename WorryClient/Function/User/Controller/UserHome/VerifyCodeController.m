//
//  VerifyCodeController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "VerifyCodeController.h"
#import "UserDetailController.h"
#import "LogInController.h"

#define kNoticeTitle @"提示"

@interface VerifyCodeController ()<UIAlertViewDelegate>

@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic,strong) UIButton *noCodeBtn;       //  didn't require code msg
@property (nonatomic,strong) UITextField *textField;    //  code textField
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *areaCode;
@property (nonatomic,strong) UIButton *submitBtn;

@property (nonatomic,strong) UIAlertView *codeErrorAlert;
@property (nonatomic,strong) UIAlertView *verifyFailedAlert;
@property (nonatomic,strong) UIAlertView *noCodeAlert;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation VerifyCodeController

- (instancetype)initWithPhone:(NSString *)phone
                     areaCode:(NSString *)areaCode
          verifySuccessAction:(VerifySuccessAction)verifySuccessAction
{
    self = [super init];
    if (self) {
        self.areaCode = areaCode;
        self.phone = phone;
        self.verifySuccessAction = verifySuccessAction;
    }
    return self;
}

#pragma mark - Default methods

- (void)loadView
{
    [super loadView];
    self.title = @"填写验证码";
    self.view.backgroundColor = kBGColor;
    [self loadTipsLabel];
    [self loadTextField];
    [self loadNoCodeBtn];
    [self loadSubmitBtn];
}

- (void)loadTipsLabel
{
    self.tipsLabel = [[UILabel alloc]init];
    [self.view addSubview:self.tipsLabel];
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel.text = [NSString stringWithFormat:@"我们已发送验证码短信到:\n+%@ %@",self.areaCode,self.phone];
    self.tipsLabel.numberOfLines = 0;
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(+kVerticalPadding);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadTextField
{
    self.textField = [UITextField defaultTextField:@"请输入4位验证码" superView:self.view];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).with.offset(kVerticalPadding);
    }];
}

- (void)loadNoCodeBtn
{
    self.noCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.noCodeBtn];
    [self.noCodeBtn setTitle:@"收不到短信验证码?" forState:UIControlStateNormal];
    [self.noCodeBtn addTarget:self action:@selector(clickNoCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    self.noCodeBtn.hidden = YES;
    
    [self.noCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.textField.mas_bottom).with.offset(kVerticalPadding);
    }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30
                                                  target:self
                                                selector:@selector(timeOver)
                                                userInfo:nil
                                                 repeats:NO];
}

- (void)loadSubmitBtn
{
    self.submitBtn = [UIButton buttonWithNormalTitle:@"提交"];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside ];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.noCodeBtn.mas_bottom).with.offset(kVerticalPadding);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
    }];
}

#pragma mark - Utils

- (void)clickSubmitBtn
{
    if(self.textField.text.length!=4)
    {
        self.codeErrorAlert = [[UIAlertView alloc] initWithTitle:kNoticeTitle
                                                         message:@"验证码格式错误，请重新填写"
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [self.codeErrorAlert show];
    }else{
        [[UserService sharedInstance]commitVerifyCode:self.textField.text result:^(enum SMS_ResponseState state) {
            if (state==SMS_ResponseStateSuccess){
                POST_SUCCESS_MSG(@"验证成功");
                EXECUTE_BLOCK(self.verifySuccessAction,self.phone,self.areaCode);
            }else if(state==SMS_ResponseStateFail){
                NSString* str=[NSString stringWithFormat:kNoticeTitle];
                self.verifyFailedAlert =[[UIAlertView alloc] initWithTitle:str
                                                                   message:@"验证码无效，请重新输入验证码"
                                                                  delegate:self
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil, nil];
                [self.verifyFailedAlert show];
            }
        }];
    }
}

- (void)clickNoCodeBtn
{
    NSString* str=[NSString stringWithFormat:@"%@:%@",@"我们将重新发送验证码短信到这个号码",_phone];
    self.noCodeAlert=[[UIAlertView alloc] initWithTitle:@"确认手机号码"
                                                message:str
                                               delegate:self
                                      cancelButtonTitle:@"取消"
                                      otherButtonTitles:@"好",nil];
    [self.noCodeAlert show];
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger cancelIndex = alertView.cancelButtonIndex;
    if (buttonIndex==cancelIndex) {
        alertView.hidden = YES;
    }else{
        //  self.codeErrorAlert and self.verifyFailedAlert only have cancel button
        if (alertView==self.noCodeAlert) {
            //  no code
            [[UserService sharedInstance]requireVerifyCodeWithPhone:self.phone areaCode:self.areaCode resultBlock:^(NSError *error) {
                if (error==nil) {
                    POST_SUCCESS_MSG(@"发送成功");
                }else{
                    POST_ERROR_MSG(@"发送失败");
                }
            }];
        }
    }
}

#pragma mark - Utils

- (void)timeOver
{
    self.noCodeBtn.hidden = NO;
}

@end
