//
//  UIViewController+Worry.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/6.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  给Worry这个工程用的
//  其他专属这个工程的controller会加上前缀"W"

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "LogUtils.h"
#import "MessageCenter.h"
#import "LogInController.h"
#import "UIViewController+Utils.h"
#import "ViewDefault.h"
#import "LocaleUtils.h"
#import "UserManager.h"
#import "UserService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RDVTabBarController.h"

@interface UIViewController (Worry)<UIAlertViewDelegate>

- (void)loadLogInAlertView;
- (void)loadData;
- (void)hideTabBar;
- (void)showTabBar;
- (void)customizeNavigationBar;

@end
