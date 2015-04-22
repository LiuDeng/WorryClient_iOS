//
//  DefaultTableViewController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/22.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "DefaultViewController.h"

@interface DefaultTableViewController : DefaultViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

- (void)loadTableView;

@end
