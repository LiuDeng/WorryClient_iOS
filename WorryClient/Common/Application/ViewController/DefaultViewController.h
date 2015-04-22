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

@interface DefaultViewController : UIViewController

- (void)loadLogInAlertView;
- (void)loadData;
@end
