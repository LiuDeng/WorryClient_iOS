//
//  CommentController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/26.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"
#import "FeedService+Comment.h"

@interface CommentController : UIViewController

- (id)initWithPBFeed:(PBFeed *)pbFeed;
- (id)initWithPBAnswer:(PBAnswer *)pbAnswer;
- (id)initWithPBComment:(PBComment *)pbComment;

@end
