//
//  UIViewController+Update.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "RequestCodeController.h"
#import "LogInController.h"
#import "EditController.h"

@implementation UIViewController (Update)

//  除了个人资料中使用，还有忘记密码中使用

- (void)phoneResetPWD
{
    //  TODO    记录手机号，areaCode
    RequestCodeController *vc = [[RequestCodeController alloc]initWithVerifySuccessAction:^(NSString *phone, NSString *areaCode) {
        EditController *vc = [[EditController alloc]initWithText:nil placeholder:@"请输入密码" tips:nil isMulti:NO saveActionBlock:^(NSString *text) {
            
            //  TODO save the password
            //  check password
            
            LogInController *logInC = [[LogInController alloc]init];
            NSArray *childControllers = self.navigationController.childViewControllers;
            BOOL hasLogInController = NO;
            for (UIViewController *controller in childControllers) {
                if ([controller class]==[LogInController class]) {
                    hasLogInController = YES;
                }
            }
            if (hasLogInController) {
                [self.navigationController popToViewController:logInC animated:YES];
            }else{
                [self.navigationController pushViewController:logInC animated:YES];
            }
            
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)isValidPWD:(NSString *)pwd
{
    return pwd.length > 0 ? YES : NO;
}

@end
