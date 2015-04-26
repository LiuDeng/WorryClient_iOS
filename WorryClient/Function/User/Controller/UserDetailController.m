//
//  UserDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserDetailController.h"
#import "User.pb.h"
#import "UserManager.h"
#import "UserDetailAvatarCell.h"
#import "UserDetailBGImageCell.h"
#import "UpdateImage.h"

#define kUserDetailCell     @"kUserDetailCell"
#define kAvatarTitle        @"头像"
#define kBackgroundTitle    @"背景"
#define kNickTitle          @"昵称"
#define kSinatureTitle      @"签名"

#define kGenderTitle        @"性别"
#define kLocationTitle      @"位置"
#define kChangePwdTitle     @"密码"

#define kQQTitle            @"QQ"
#define kWeixinTitle        @"微信"
#define kSinaTitle          @"微博"
#define kEmailTitle         @"邮箱"
#define kMobileTitle        @"手机"

@interface UserDetailController ()
{
    NSArray *currentLanguageArray;
}
@property (nonatomic,assign) int indexOfSection;  //  Section索引，计数功能
@property (nonatomic,assign) int sectionBasic;
@property (nonatomic,assign) int sectionMisc;
@property (nonatomic,assign) int sectionContact;
@property (nonatomic, strong) NSArray *sectionBasicItems;
@property (nonatomic, strong) NSArray *sectionMiscItems;
@property (nonatomic, strong) NSArray *sectionContactItems;
@property (nonatomic,strong) PBUser *pbUser;
@property (nonatomic,strong) UpdateImage *updateImage;
//@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation UserDetailController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.pbUser = [[UserManager sharedInstance] pbUser];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"个人资料"];
}

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kUserDetailCell];
}
- (void)loadData
{
    [super loadData];
    self.sectionBasic = self.indexOfSection++;
    self.sectionMisc = self.indexOfSection++;
    self.sectionContact = self.indexOfSection++;
    self.sectionBasicItems = @[kAvatarTitle,kBackgroundTitle,kNickTitle,kSinatureTitle];
    self.sectionMiscItems = @[kGenderTitle,kLocationTitle,kChangePwdTitle];
    self.sectionContactItems = @[kQQTitle,kWeixinTitle,kSinaTitle,kMobileTitle,kEmailTitle];
}

#pragma mark - Private methods


#pragma mark - UITableviewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows;
    switch (section) {
        case 0:
            rows = (int)[self.sectionBasicItems count];
            break;
        case 1:
            rows = (int)[self.sectionMiscItems count];
            break;
        case 2:
            rows = (int)[self.sectionContactItems count];
            break;
        default:
            rows = 0;
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == self.sectionBasic) {
        NSString *title = self.sectionBasicItems[indexPath.row];
        if ([title isEqualToString:kAvatarTitle]) {
            UserDetailAvatarCell *detailAvatarCell = [[UserDetailAvatarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            detailAvatarCell.textLabel.text = title;
            cell = detailAvatarCell;
        }else if([title isEqualToString:kBackgroundTitle]){
            UserDetailBGImageCell *detailBGImageCell = [[UserDetailBGImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            detailBGImageCell.textLabel.text = title;
            cell = detailBGImageCell;
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:kUserDetailCell forIndexPath:indexPath];
            cell.textLabel.text = title;
        }
    }else if (indexPath.section == self.sectionMisc){
        NSString *title = self.sectionMiscItems[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:kUserDetailCell forIndexPath:indexPath];
        cell.textLabel.text = title;
    }else if (indexPath.section == self.sectionContact){
        NSString *title = self.sectionContactItems[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:kUserDetailCell forIndexPath:indexPath];
        cell.textLabel.text = title;
    }else{
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.section == self.sectionBasic) {
        if ([kAvatarTitle isEqualToString:self.sectionBasicItems[indexPath.row]] || [kBackgroundTitle isEqualToString:self.sectionBasicItems[indexPath.row]]) {
            height = self.view.frame.size.height * 0.1;
        }else{
            height = self.view.frame.size.height * 0.07;
        }
    }else{
        height = self.view.frame.size.height * 0.07;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == self.sectionBasic) ? kGroupTableViewHeaderHeight : 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == self.sectionBasic) {
        NSString *title = self.sectionBasicItems[indexPath.row];
        if ([title isEqualToString:kAvatarTitle]) {
            [self updateAvatar];
        }
    }
}

#pragma mark - Utils

- (void)updateAvatar
{
    NSString *actionSheetTitle = @"请选择";
    self.updateImage = [[UpdateImage alloc]init];
    [self.updateImage showSelectionWithTitle:actionSheetTitle superViewController:self selectedImageBlock:^(UIImage *image) {
        //
    }];
}

@end
