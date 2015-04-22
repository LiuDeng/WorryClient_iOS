//
//  UserController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/2/18.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserController.h"
#import "UserAvatarCell.h"
#import "ViewInfo.h"
#import "UserManager.h"
#import "AVOSCloud/AVOSCloud.h"
#import "User.pb.h"
#import "LogInController.h"
#import "SettingController.h"


#define kTopicTitle             @"话题"
#define kBlessingTitle          @"祝福"
#define kThanksTitle            @"感谢"
#define kStoryTitle             @"故事"
#define kWorryTitle             @"心事"
#define kContributionTitle      @"贡献"
#define kFavoritesTitle         @"收藏"
//#define TITLE_SETTING           @"设置"

@interface UserController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *itemsOfBasic;

@property (nonatomic,assign)int indexOfSection;
@property (nonatomic,assign)int sectionAvatar;
@property (nonatomic,assign)int sectionBasic;
@property (nonatomic,assign)CGFloat avatarCellHeight;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,strong)PBUser *pbUser;

@end

@implementation UserController

#pragma mark - Default methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLogInAlertViewIfNeeded];
}

- (void)loadView
{
    [super loadView];
    [self addRightButtonWithTitle:@"logIn" target:self action:@selector(clickRightButton)];
//    [self loadTableView];
}
#pragma mark - Private methods

//- (void)loadTableView
//{
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    [self.view addSubview:self.tableView];
//    
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//}
- (void)loadData
{
    [super loadData];
    self.itemsOfBasic = @[kContributionTitle,kFavoritesTitle,kThanksTitle,kBlessingTitle,kWorryTitle,kStoryTitle,kTopicTitle];
    self.sectionAvatar = self.indexOfSection++;
    self.sectionBasic = self.indexOfSection++;
    self.cellHeight = self.view.frame.size.height*0.08;
    self.avatarCellHeight = self.view.frame.size.height*0.2;
}

- (void)loadLogInAlertViewIfNeeded
{
    if ([[UserManager sharedInstance]hasUser] == NO) {
        [self loadLogInAlertView];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int num;
    if (section == self.sectionAvatar) {
        num = 1;
    }else if(section == self.sectionBasic){
        num = (int)self.itemsOfBasic.count;
    }{
        //  TODO
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == self.sectionAvatar) {
        UserAvatarCell *userAvatarCell = [[UserAvatarCell alloc]init];
        self.pbUser = [[UserManager sharedInstance]pbUser];
        userAvatarCell.nickNameLabel.text = self.pbUser.nick;  // TODO
        cell = userAvatarCell;
    }else{
        UITableViewCell *basicCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                                           reuseIdentifier:nil];
        basicCell.imageView.image = [UIImage imageNamed:@"test_first_page_selected"];
        if (indexPath.section == self.sectionBasic){
            
            basicCell.textLabel.text = self.itemsOfBasic[indexPath.row];
        }else{
            //  TODO
        }

        cell = basicCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == self.sectionAvatar ? self.avatarCellHeight : self.cellHeight;
}

#pragma mark - Utils

- (void)clickRightButton
{
    SettingController *vc = [[SettingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
