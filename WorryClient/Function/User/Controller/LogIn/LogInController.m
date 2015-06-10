//
//  LogInController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "LogInController.h"
#import "SignUpAndLogInView.h"
#import "UserService.h"
#import "UIViewController+Utils.h"
#import "SignUpByEmailController.h"
#import "RDVTabBarController.h"
#import "ViewDefault.h"
#import "UIView+DefaultView.h"

#import <ShareSDK/ShareSDK.h>

#define kSignUpPhoneTitle     @"手机注册"
#define kSignUpEmailTitle     @"邮箱注册"
#define kFindByPhoneTitle     @"手机找回"
#define kFindByEmailTitle     @"邮箱找回"
#define kCancelTitle          @"取消"

@interface LogInController()<UIActionSheetDelegate>

@property (nonatomic,strong) UITextField *accountTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UIButton *logInButton;
@property (nonatomic,strong) UIButton *signUpButton;
@property (nonatomic,strong) UIButton *forgetButton;    //  forget password
@property (nonatomic,strong) UILabel *orLabel;      //  “或者”
@property (nonatomic,strong) UIActionSheet *signUpSheet;
@property (nonatomic,strong) UIActionSheet *forgetSheet;
@property (nonatomic,strong) NSArray *signUpSheetTitles;
@property (nonatomic,strong) NSArray *forgetSheetTitles;

@property (nonatomic,strong) SignUpAndLogInView *signUpAndLogInView;
@property (nonatomic,strong) UIImageView *logoImageView;

@end

@implementation LogInController

#pragma mark - Default methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)loadView
{
    [super loadView];
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    self.view.backgroundColor = OPAQUE_COLOR(0xea, 0xf1, 0xf1);
//    [self loadLogoImageView];
    [self loadSignUpAndLogInView];
    
    [self loadSignUpButton];
    [self loadForgetButton];
    [self loadOrLabel];
    [self loadElseLogInWayButtons];
}
#pragma mark - Private methods

- (void)loadSignUpAndLogInView
{
    self.signUpAndLogInView = [[SignUpAndLogInView alloc]initWithAccountPlaceholder:@"请输入用户名/手机/邮箱"
                                                                passwordPlaceholder:@"请输入密码"
                                                                        buttonTitle:@"登录"];
    [self.view addSubview:self.signUpAndLogInView];
//    CGFloat padding = 30;
    [self.signUpAndLogInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(padding);
        make.centerY.equalTo(self.view).with.multipliedBy(0.4);
        make.height.equalTo(self.view).with.dividedBy(3);
        make.width.equalTo(self.view);
    }];
    
//    [self loadAccountTextField];
//    [self loadPasswordTextField];
//    [self loadLogInButton];

    self.accountTextField = self.signUpAndLogInView.accountTextField;
    self.passwordTextField = self.signUpAndLogInView.passwordTextField;
    self.logInButton = self.signUpAndLogInView.button;
    [self.logInButton addTarget:self
                         action:@selector(clickLogInButton)
               forControlEvents:UIControlEventTouchUpInside];
}

//- (void)loadLogoImageView
//{
//    UIImage *image = [UIImage imageNamed:@"log_in_logo"];
//    self.logoImageView = [[UIImageView alloc]initWithImage:image];
//    [self.view addSubview:self.logoImageView];
//    
//    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view).with.multipliedBy(0.25);
//    }];
//}

- (void)loadSignUpButton
{
    self.signUpButton = [[UIButton alloc]init];
    [self.view addSubview:self.signUpButton];
    [self.signUpButton setTitle:@"<快速注册" forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.signUpButton addTarget:self action:@selector(clickSignUpButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logInButton);
        make.top.equalTo(self.logInButton.mas_bottom);
    }];
}

- (void)loadForgetButton
{
    self.forgetButton = [[UIButton alloc]init];
    [self.view addSubview:self.forgetButton];
    [self.forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.forgetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.forgetButton addTarget:self action:@selector(clickForgetButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.logInButton);
        make.centerY.equalTo(self.signUpButton);
    }];
}

- (void)loadOrLabel
{
    self.orLabel = [[UILabel alloc]init];
    [self.view addSubview:self.orLabel];
    self.orLabel.text = @"或";
    self.orLabel.textColor = kMainColor;
    
    [self.orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.signUpButton.mas_bottom);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    [self.view addSubview:line1];
    line1.backgroundColor = kMainColor;
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orLabel);
        make.right.equalTo(self.orLabel.mas_left);
        make.left.equalTo(self.logInButton);
        make.height.equalTo(@1);
    }];

    UIView *line2 = [[UIView alloc]init];
    [self.view addSubview:line2];
    line2.backgroundColor = kMainColor;
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line1);
        make.right.equalTo(self.logInButton);
        make.height.equalTo(@1);
//        make.left.equalTo(self.orLabel.mas_right);    //  这个加了会有异常，原因不明，换成下面一行。
        make.width.equalTo(line1);
    }];
}

- (void)loadElseLogInWayButtons
{
    NSArray *imageNames = @[@"log_in_qq",@"log_in_weixin",@"log_in_sina"];
    NSMutableArray *buttons = [[NSMutableArray alloc]init];
    CGFloat count = imageNames.count;   //  to guarantee the precision of xScale
    for (int i=0;i<count;i++) {
        NSString *imageName = [imageNames objectAtIndex:i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIButton *button = [[UIButton alloc]init];
        [self.view addSubview:button];
        [button setImage:image forState:UIControlStateNormal];
        [buttons addObject:button];
        
        CGFloat xScale = (i+2)/count; //  (2,3,4)/3
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orLabel.mas_bottom);
            make.centerX.equalTo(self.view).with.multipliedBy(xScale);
        }];

    }
    
    UIButton *qqButton = (UIButton *)[buttons objectAtIndex:0];
    UIButton *weixinButton = (UIButton *)[buttons objectAtIndex:1];
    UIButton *sinaButton = (UIButton *)[buttons objectAtIndex:2];
    
    [qqButton addTarget:self action:@selector(clickQQButton) forControlEvents:UIControlEventTouchUpInside];
    [weixinButton addTarget:self action:@selector(clickWeixinButton) forControlEvents:UIControlEventTouchUpInside];
    [sinaButton addTarget:self action:@selector(clickSinaButton) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Utils
- (void)clickLogInButton
{
    NSString *account = self.accountTextField.text;
    NSString *password = self.passwordTextField.text;
    if (account.length == 0 || password.length == 0) {
        
    }else{
        [[UserService sharedInstance]logInByValue:account password:password block:^(NSError *error) {
            if (error == nil) {
                POST_SUCCESS_MSG(@"登录成功");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                POST_ERROR_MSG(@"登录失败");
            }
        }];
    }
}


- (void)clickForgetButton
{
    //  actionSheet,show find back by phone or email
    self.forgetSheetTitles = @[kFindByEmailTitle,kFindByPhoneTitle,kCancelTitle];
    
    self.forgetSheet = [[UIActionSheet alloc]init];
    self.forgetSheet.delegate = self;
    for (NSString *title in self.forgetSheetTitles) {
        [self.forgetSheet addButtonWithTitle:title];
    }
    [self.forgetSheet setCancelButtonIndex:[self.forgetSheetTitles indexOfObject:kCancelTitle]];
    [self.forgetSheet showInView:self.view];
}

- (void)clickSignUpButton
{
    //  actionSheet,show sign up by phone or email
    self.signUpSheetTitles = @[kSignUpEmailTitle,kSignUpPhoneTitle,kCancelTitle];
    
    self.signUpSheet = [[UIActionSheet alloc]init];
    self.signUpSheet.delegate = self;
    for (NSString *title in self.signUpSheetTitles) {
        [self.signUpSheet addButtonWithTitle:title];
    }
    [self.signUpSheet setCancelButtonIndex:[self.signUpSheetTitles indexOfObject:kCancelTitle]];
    [self.signUpSheet showInView:self.view];
}

#pragma mark Else log in ways

- (void)clickQQButton
{
    //  log in by QQ
    //  真机测试
    [ShareSDK getUserInfoWithType:ShareTypeQQ
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                if (result) {
                                    JDDebug(@"userInfo uid %@",[userInfo uid]);
                                    JDDebug(@"userInfo nickname %@",[userInfo nickname]);
                                }
                           }];
}

- (void)clickWeixinButton
{
    //  log in by Weixin
    //  真机测试
    [ShareSDK getUserInfoWithType:ShareTypeWeixiTimeline
                      authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                          if (result) {
                              JDDebug(@"userInfo uid %@",[userInfo uid]);
                              JDDebug(@"userInfo nickname %@",[userInfo nickname]);
                          }
                      }];
}

- (void)clickSinaButton
{
    //  log in by Sina
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                            if (result) {
                                JDDebug(@"userInfo uid %@",[userInfo uid]);
                                JDDebug(@"userInfo nickname %@",[userInfo nickname]);
                            }
                        }];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        actionSheet.hidden = YES;
    }else if ([actionSheet isEqual:self.forgetSheet]) {
        NSString *title = [self.forgetSheetTitles objectAtIndex:buttonIndex];
        if ([title isEqualToString:kFindByEmailTitle]) {
            //  find by email
        }else{
            //  find by phone
        }
    }else{
        NSString *title = [self.signUpSheetTitles objectAtIndex:buttonIndex];
        if ([title isEqualToString:kSignUpEmailTitle]) {
            //  sign up by email
        }else{
            //  sign up by phone
        }
    }
    
}

@end
