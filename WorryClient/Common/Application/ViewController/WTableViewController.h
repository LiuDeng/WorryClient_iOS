//
//  WTableViewController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/22.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  Worry这个工程专属
//  改成GroupTableViewController可能会更好    -- 蔡少武 15/6/6

#import "UIViewController+Worry.h"

@interface WTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

- (void)loadTableView;

@end
