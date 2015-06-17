//
//  UIViewController+LogInSignUp.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"

@interface UIViewController (LogInSignUp)

- (void)phoneSignUp;

- (void)QQLogIn;    //  QQ
- (void)sinaLogIn;  //  Sina
- (void)emailSignUp;    //  Email

- (void)goToLogIn;

@end
