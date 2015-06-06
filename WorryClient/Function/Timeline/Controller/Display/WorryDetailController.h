//
//  WorryDetailController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/2.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"
@class PBFeed;

@interface WorryDetailController : UIViewController

- (instancetype)initWithPBFeed:(PBFeed *)pbFeed;

@end
