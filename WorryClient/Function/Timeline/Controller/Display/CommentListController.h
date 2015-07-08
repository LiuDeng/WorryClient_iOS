//
//  CommentListController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/7/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  列表显示，但是cell的高度要根据文字多少变化
//  右上角，“写评论”
#import "UIViewController+Worry.h"

@class PBFeed;

@interface CommentListController : UIViewController

- (instancetype)initWithPBFeed:(PBFeed *)pbFeed;

@end
