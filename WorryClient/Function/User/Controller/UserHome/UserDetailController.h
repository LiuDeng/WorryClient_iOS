//
//  UserDetailController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  中文对应的是“个人资料页面”
#import "WTableViewController.h"
#import "UpdateImage.h"

@interface UserDetailController : WTableViewController

@property (nonatomic,strong) PBUser *pbUser;
@property (nonatomic,strong) UpdateImage *updateImage;

@end
