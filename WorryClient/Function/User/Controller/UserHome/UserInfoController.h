//
//  UserInfoController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  中文对应的是“用户详情页面”
#import "UIViewController+Worry.h"
@class PBUser;

@interface UserInfoController : UIViewController

- (instancetype)initWithPBUser:(PBUser *)pbUser;

@end
