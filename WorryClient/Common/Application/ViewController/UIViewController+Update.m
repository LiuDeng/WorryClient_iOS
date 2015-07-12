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
#import "UIViewController+LogInSignUp.h"

@implementation UIViewController (Update)

//  忘记密码中使用

- (void)phoneResetPWD
{
//    //  TODO    记录手机号，areaCode
//    RequestCodeController *vc = [[RequestCodeController alloc]initWithVerifySuccessAction:^(NSString *phone, NSString *areaCode) {
//        EditController *editControler = [[EditController alloc]initWithText:nil
//                                                     placeholder:@"请输入密码"
//                                                            tips:nil
//                                                         isMulti:NO
//                                                 saveActionBlock:^(NSString *text) {
//                                                     [[UserService sharedInstance]phoneResetPWD:text block:^(NSError *error) {
//                                                         if (error) {
//                                                             POST_ERROR_MSG(@"修改失败");
//                                                         }else{
//                                                             POST_SUCCESS_MSG(@"修改成功");
//                                                             [self goToLogIn];
//                                                         }
//                                                     }];
//                                                 }];
//        editControler.textField.secureTextEntry = YES;
//        [self.navigationController pushViewController:editControler animated:YES];
//    }];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    [[UserService sharedInstance]phoneResetPWD:@"111111" block:nil];    //  测试代码
}

- (BOOL)isValidPWD:(NSString *)pwd
{
    return pwd.length > 0 ? YES : NO;
}

@end
