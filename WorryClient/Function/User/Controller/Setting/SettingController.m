//
//  SettingController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/22.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "SettingController.h"
#import "UserService.h"

#define kAboutTitle @"关于"
#define kLogOut     @"注销"

#define kSettingCell    @"kSettingCell"


@interface SettingController ()

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,retain) NSArray *sectionMiscItems;
@property (nonatomic,assign) int sectionMisc;
@property (nonatomic,assign) int indexOfSection;

@end

@implementation SettingController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
}

- (void)loadData
{
    [super loadData];
    self.sectionMisc = self.indexOfSection++;
    self.sectionMiscItems = @[kAboutTitle,kLogOut];
}

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSettingCell];
    
}
#pragma mark Private methods

- (void)logOut
{
    [[UserService sharedInstance]logOut];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.sectionMisc) {
        NSString *title = self.sectionMiscItems[indexPath.row];
        if ([title isEqualToString:kAboutTitle]) {
            //
        }else if([title isEqualToString:kLogOut]){
            [self logOut];
        }
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    if (section == self.sectionMisc) {
        num = self.sectionMiscItems.count;
    }else{
        num = 0;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSettingCell];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingCell forIndexPath:indexPath];
    if (indexPath.section == self.sectionMisc) {
        cell.textLabel.text = self.sectionMiscItems[indexPath.row];
    }else{
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
