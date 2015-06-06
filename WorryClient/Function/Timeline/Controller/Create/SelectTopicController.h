//
//  SelectTopicController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"


typedef void (^SelectTopicBlock) (NSArray *selectedPBTopicArray);

@interface SelectTopicController : UIViewController

@property (nonatomic,strong) SelectTopicBlock selectTopicBlock;
@property (nonatomic,strong) NSMutableArray *selectedPBTopicArray;

@end
