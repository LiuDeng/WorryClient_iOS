//
//  StoryDetailController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/1.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"
@class PBFeed;

@interface StoryDetailController : UIViewController

- (instancetype)initWithPBFeed:(PBFeed *)pbFeed;

@end
