//
//  DefaultViewController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
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

@interface DefaultViewController : UIViewController

/**
 *  default is NO.
 *  if is YES,
 *  hideTabBar will be called in loadView,
 *  showTabBar will be called in viewWillDisappear:.
 */
@property (nonatomic,assign) BOOL isHideTabBar;

- (void)loadLogInAlertView;
- (void)loadData;
- (void)hideTabBar;
- (void)showTabBar;
- (void)customizeNavigationBar;

@end
