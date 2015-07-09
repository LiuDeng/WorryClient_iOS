//
//  RequestCodeController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "RequestCodeController.h"

#define kAreaCode @"86"

@interface RequestCodeController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIAlertView *frequentNextAlert;    //  click next step frequently
@property (nonatomic,strong) UIAlertView *confirmRequestAlert;  //  confirm the request of sending code
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *areaCode;  //  虽然没有使用sms，但是保留这个变量，以后可能用得上

@end

@implementation RequestCodeController

- (instancetype)initWithVerifySuccessAction:(VerifySuccessAction) verifySuccessAction
{
    self = [super init];
    if (self) {
        self.verifySuccessAction = verifySuccessAction;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = kBGColor;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self addRightButtonWithTitle:@"下一步" target:self action:@selector(clickNextStepBtn)];
    [self loadAreaTextField];
    [self loadTextField];
}

- (void)loadAreaTextField
{
    self.areaCodeField = [[UITextField alloc]init];
    [self.view addSubview:self.areaCodeField];
    self.areaCodeField.text = [NSString stringWithFormat:@"+%@",kAreaCode];
    
    [self.areaCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).with.multipliedBy(kLeftScale);
        make.height.equalTo(@kTextFieldHeight);
        make.top.equalTo(self.view).with.offset(+kVerticalPadding);
    }];
    
    self.areaCodeField.enabled = NO;
}

- (void)loadTextField
{
    self.textField = [UITextField textFieldWithPlaceholder:@"请输入11位手机号码"];
    [self.view addSubview:self.textField];
    self.textField.delegate = self;
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.areaCodeField);
        make.top.equalTo(self.areaCodeField);
        make.right.equalTo(self.view).with.multipliedBy(kRightScale);
        make.left.equalTo(self.areaCodeField.mas_right).with.offset(kHorizontalPadding);
    }];
    
    [self.textField setRoundCorner];
    [self.textField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
}

- (void)clickNextStepBtn
{
    NSLog(@"%d",self.timer.valid);
    NSString *text = self.textField.text;
    BOOL valid = [Utils isValidMobile:text];
    
    if (valid) {
        self.phone = text;
        self.areaCode = kAreaCode;  //  目前只有+86，往后会增加选择器，不会让用户手动输入的

        //  TODO
        if (self.timer) {  //  60s内
            self.frequentNextAlert = [[UIAlertView alloc]initWithTitle:@"操作过于频繁，请稍候再试"
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"好"
                                                     otherButtonTitles:nil];
            [self.frequentNextAlert show];
        }else{
            NSString *msg = [NSString stringWithFormat:@"我们将发送验证码短信到这个号码：\n+%@ %@",self.areaCode,self.phone];
            self.confirmRequestAlert = [[UIAlertView alloc]initWithTitle:@"确认手机号码"
                                                                 message:msg
                                                                delegate:self
                                                       cancelButtonTitle:@"取消"
                                                       otherButtonTitles:@"好", nil];
            [self.confirmRequestAlert show];
        }
    }else{
        POST_ERROR_MSG(@"请输入有效手机号码");
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger cancelIndex = alertView.cancelButtonIndex;
    if (cancelIndex==buttonIndex) {
        alertView.hidden = YES;
    }else{
        //  self.frequentNextAlert only has cancel button
        [self requestCode];
    }
}

#pragma mark - Utils

- (void)valueChanged:(UITextField *)textField
{
    if ([textField isEqual:self.textField]) {
        if (textField.text.length>0) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }else{
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
}

- (void)requestCode
{
    [[UserService sharedInstance]getCodeWithPhone:self.phone
                                         callback:^(NSError *error) {
                                            if (error==nil) {
                                                self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timeOver) userInfo:nil repeats:NO];
                                                VerifyCodeController *vc = [[VerifyCodeController alloc]initWithPhone:self.phone
                                                                                                             areaCode:self.areaCode
                                                                                                  verifySuccessAction:self.verifySuccessAction];
                                                [self.navigationController pushViewController:vc animated:YES];
                                            }else{
                                                POST_ERROR_MSG(@"发送验证码失败，请稍候再试");
                                            }
                                        }];
}

- (void)timeOver
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
