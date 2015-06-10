//
//  WSegmentController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/31.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  the segment controller of Worry.app

#import "UIViewController+Worry.h"

@interface WSegmentController : UIViewController

@property (nonatomic,strong) NSArray *segmentTitles;    //  segment control titles
@property (nonatomic,strong) NSMutableArray *holderViews;      //  holderView added on scrollView

@end



