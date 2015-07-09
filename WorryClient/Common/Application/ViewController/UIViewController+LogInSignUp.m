//
//  UIViewController+LogInSignUp.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+LogInSignUp.h"
#import "RequestCodeController.h"
#import "LogInController.h"
#import "SignUpByEmailController.h"
#import "EditController.h"
#import "UserController.h"

@implementation UIViewController (LogInSignUp)

- (void)phoneSignUp
{
    RequestCodeController *vc = [[RequestCodeController alloc]initWithVerifySuccessAction:^(NSString *phone, NSString *smsCode) {
        EditController *vc = [[EditController alloc]initWithText:nil
                                                     placeholder:@"请输入密码"
                                                            tips:nil
                                                         isMulti:NO
                                                 saveActionBlock:^(NSString *text) {
                                                     [[UserService sharedInstance]phoneSignUp:phone password:text smsCode:smsCode block:^(NSError *error) {
                                                             if (error) {
                                                                 POST_ERROR_MSG(@"注册失败，请稍候尝试");
                                                             }else{
                                                                 [self afterSignUpSuccess];
                                                             }
                                                     }];
                                                 }];
        vc.textField.secureTextEntry = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)QQLogIn
{
    //  log in by QQ
    //  真机测试
    [[UserService sharedInstance]qqLogInWithBlock:^(BOOL succeed) {
        if (succeed) {
            //  succeed push to TimeLineController or pop to rootView?
        }else {
            //  fail
        }
    }];
}

- (void)sinaLogIn
{
    //  log in by Sina
    [[UserService sharedInstance]sinaLogInWithBlock:^(BOOL succeed) {
        if (succeed) {
            //  succeed push to TimeLineController or pop to rootView?
        }else {
            //  fail
        }
    }];
    
}

- (void)emailSignUp
{
    //  暂时不做
    SignUpByEmailController *vc = [[SignUpByEmailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Utils

- (void)goToLogIn
{
    NSArray *childControllers = self.navigationController.childViewControllers;
    NSInteger count = childControllers.count;
    for (int i = 0;i<count;i++) {
        UIViewController *controller = (UIViewController *)childControllers[i];
        if ([controller class]==[LogInController class]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }else if(i==count-1){
            LogInController *logInC = [[LogInController alloc]init];
            [self.navigationController pushViewController:logInC animated:YES];
            break;
        }
    }
}

- (void)goToUser
{
    //  应该得用tab bar，跳转到userController
    NSArray *childControllers = self.navigationController.childViewControllers;
    NSInteger count = childControllers.count;
    for (int i = 0;i<count;i++) {
        UIViewController *controller = (UIViewController *)childControllers[i];
        if ([controller class]==[UserController class]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }else if(i==count-1){
            UserController *userC = [[UserController alloc]init];
            [self.navigationController pushViewController:userC animated:YES];
            break;
        }
    }
}

- (void)afterSignUpSuccess
{
    //  TODO 等待测试
   [self goToUser];
    NSString *title = @"注册成功，用户名为手机号码\n请点击背景，设置个人资料";
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alert show];
 
}

@end
