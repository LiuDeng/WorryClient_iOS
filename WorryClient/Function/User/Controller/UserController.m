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

#define TITLE_TOPIC             @"话题"
#define TITLE_BLESSING          @"祝福"
#define TITLE_THANKS            @"感谢"
#define TITLE_KNOT              @"心结"
#define TITLE_WORRY             @"心事"
#define TITLE_CONTRIBUTTION     @"我的贡献"
#define TITLE_SETTING           @"设置"

@interface UserController ()

@property (nonatomic,strong)NSArray *itemsOfBasic;
@property (nonatomic,strong)NSArray *itemsOfBlessing;
@property (nonatomic,strong)NSArray *itemsOfTrouble;
@property (nonatomic,strong)NSArray *itemsOfMisc;
@property (nonatomic,strong)NSArray *itemsOfSetting;

@property (nonatomic,assign)int indexOfSection;
@property (nonatomic,assign)int sectionAvatar;
@property (nonatomic,assign)int sectionBasic;
@property (nonatomic,assign)int sectionBlessing;
@property (nonatomic,assign)int sectionTrouble;
@property (nonatomic,assign)int sectionMisc;
@property (nonatomic,assign)int sectionSetting;

@end

@implementation UserController

#pragma mark - Default methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
//    [self testAVOSCloud];
//    [self showAVOSCloudData];
}

- (void)loadView
{
    [super loadView];
    self.tableView.tableFooterView = [[UIView alloc]init];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - Private methods
- (void)loadData
{
    self.itemsOfBasic = @[TITLE_TOPIC];
    self.itemsOfBlessing = @[TITLE_BLESSING,TITLE_THANKS];
    self.itemsOfTrouble = @[TITLE_KNOT,TITLE_WORRY];
    self.itemsOfMisc = @[TITLE_CONTRIBUTTION];
    self.itemsOfSetting = @[TITLE_SETTING];
    
    self.sectionAvatar = self.indexOfSection++;
    self.sectionBasic = self.indexOfSection++;
    self.sectionBlessing = self.indexOfSection++;
    self.sectionTrouble = self.indexOfSection++;
    self.sectionMisc = self.indexOfSection++;
    self.sectionSetting = self.indexOfSection++;
}

- (void)testAVOSCloud
{
//    NSData *data = [UserManager sharedInstance]
    PBUserBuilder *pbUserBuilder = [PBUser builder];
//    [pbUserBuilder setUserId:@"id test"];
    [pbUserBuilder setNick:@"nick"];
    
    PBUser *pbUser = [pbUserBuilder build];
    

    
    NSData *data = [pbUser data];
    
    AVObject *bigObject = [AVObject objectWithClassName:@"BigObject"];
    [bigObject setObject:data forKey:@"myDate"];
    [bigObject saveInBackground];
}

- (void)showAVOSCloudData
{
    // both class name and objectId should not be nil
    AVObject *showObject = [AVObject objectWithoutDataWithClassName:@"BigObject" objectId:@"552a31bce4b00e097d82bae3"];
    
    [showObject fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if (object) {
            NSData *showData = (NSData*)[object objectForKey:@"myDate"];
            PBUser *showUser = [PBUser parseFromData:showData];
//            JDDebug(@"id = %@ ,nick = %@",showUser.,showUser.nick);
        }
    }];
    
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
    }else if(section == self.sectionBlessing){
        num = (int)self.itemsOfBlessing.count;
    }else if(section == self.sectionTrouble){
        num = (int)self.itemsOfTrouble.count;
    }else if(section == self.sectionMisc){
        num = (int)self.itemsOfMisc.count;
    }else if (section == self.sectionSetting){
        num = (int)self.itemsOfSetting.count;
    }else{
        //  TODO
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == self.sectionAvatar) {
        UserAvatarCell *userAvatarCell = [[UserAvatarCell alloc]init];
        userAvatarCell.nickNameLabel.text = [[UserManager sharedInstance] userNick];
        cell = userAvatarCell;
    }else{
        UITableViewCell *basicCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                                           reuseIdentifier:nil];
        basicCell.imageView.image = [UIImage imageNamed:@"test_first_page_selected"];
        if (indexPath.section == self.sectionBasic){
            
            basicCell.textLabel.text = self.itemsOfBasic[indexPath.row];
        }else if (indexPath.section == self.sectionBlessing){
            basicCell.textLabel.text = self.itemsOfBlessing[indexPath.row];
        }else if (indexPath.section == self.sectionMisc){
            basicCell.textLabel.text = self.itemsOfMisc[indexPath.row];
        }else if (indexPath.section == self.sectionTrouble){
            basicCell.textLabel.text = self.itemsOfTrouble[indexPath.row];
        }else if (indexPath.section == self.sectionSetting){
            basicCell.textLabel.text = self.itemsOfSetting[indexPath.row];
        }else{
            //  TODO
        }

        cell = basicCell;
    }
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLEVIEW_SECTION_HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == self.sectionAvatar ? AVATAR_CELL_ROW_HEIGHT : COMMON_TABLEVIEW_ROW_HEIGHT;
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
