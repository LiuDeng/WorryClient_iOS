//
//  UserDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserDetailController.h"
#import "User.pb.h"
#import "UserDetailAvatarCell.h"
#import "UserDetailBGImageCell.h"
#import "UserService.h"
#import "UserDetailController+Utils.h"
#import "UIImageView+Worry.h"
#import "SettingController.h"

#define kUserDetailCell     @"kUserDetailCell"
#define kAvatarTitle        @"头像"
#define kBackgroundTitle    @"背景"
#define kNickTitle          @"昵称"
#define kSignatureTitle     @"签名"

#define kGenderTitle        @"性别"
#define kLocationTitle      @"位置"   //  暂时不做
#define kChangePwdTitle     @"密码"

#define kQQTitle            @"QQ"
#define kWeixinTitle        @"微信"   //  暂时不做
#define kSinaTitle          @"微博"
#define kEmailTitle         @"邮箱"
#define kPhoneTitle         @"手机"

@interface UserDetailController ()

@property (nonatomic,assign) int indexOfSection;  //  Section索引，计数功能
@property (nonatomic,assign) int sectionBasic;
@property (nonatomic,assign) int sectionMisc;
@property (nonatomic,assign) int sectionContact;
@property (nonatomic,strong) NSArray *sectionBasicItems;
@property (nonatomic,strong) NSArray *sectionMiscItems;
@property (nonatomic,strong) NSMutableArray *sectionContactItems;
@property (nonatomic,strong) NSMutableArray *sectionContactImages;    //  image names

@end

@implementation UserDetailController

#pragma mark - Default methods

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"个人资料"];
    [self addRightButtonWithImageName:@"setting" target:self action:@selector(clickRightButton)];
}

- (void)loadData
{
    [super loadData];
    self.sectionBasic = self.indexOfSection++;
    self.sectionMisc = self.indexOfSection++;
    self.sectionContact = self.indexOfSection++;
    self.sectionBasicItems = @[kAvatarTitle,kNickTitle,kSignatureTitle];
    self.sectionMiscItems = @[kGenderTitle,kChangePwdTitle];
    
    self.pbUser = [[UserService sharedInstance]currentPBUser];
    
    self.sectionContactImages = [[NSMutableArray alloc]init];
    self.sectionContactItems = [[NSMutableArray alloc]init];
    
    if (self.pbUser.phone.length>0) {
        [self.sectionContactItems addObject:kPhoneTitle];
        [self.sectionContactImages addObject:@"user_detail_phone"];
    }
    if (self.pbUser.email.length>0) {
        [self.sectionContactItems addObject:kEmailTitle];
        [self.sectionContactImages addObject:@"user_detail_email"];
    }
    if (self.pbUser.qqId.length>0) {
        [self.sectionContactItems addObject:kQQTitle];
        [self.sectionContactImages addObject:@"user_detail_qq"];
    }
    if (self.pbUser.sinaId.length>0) {
        [self.sectionContactItems addObject:kSinaTitle];
        [self.sectionContactImages addObject:@"user_detail_sina"];
    }
    
}

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
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kUserDetailCell];
    if (indexPath.section == self.sectionBasic) {
        NSString *title = self.sectionBasicItems[indexPath.row];
        if ([title isEqualToString:kAvatarTitle]) {
            
            UserDetailAvatarCell *detailAvatarCell = [[UserDetailAvatarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            detailAvatarCell.textLabel.text = title;
            [detailAvatarCell.avatarView setAvatarWithPBUser:self.pbUser];
            cell = detailAvatarCell;

        }else if([title isEqualToString:kBackgroundTitle]){
            
            UserDetailBGImageCell *detailBGImageCell = [[UserDetailBGImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            detailBGImageCell.textLabel.text = title;
            [detailBGImageCell.BGImageView setBGImageWithPBUser:self.pbUser];
            cell = detailBGImageCell;
            
        }else{
            
            cell.textLabel.text = title;
            NSString *text = @"未设置";
            if ([title isEqualToString:kNickTitle]) {
                text = self.pbUser.nick;
            }else if ([title isEqualToString:kSignatureTitle]){
                text = self.pbUser.signature;
            }else{
                
            }
            cell.detailTextLabel.text = text;
        }
    }else if (indexPath.section == self.sectionMisc){
        NSString *title = self.sectionMiscItems[indexPath.row];
        NSString *text = @"未设置";
        if ([title isEqualToString:kGenderTitle]) {
            text = self.pbUser.gender ? @"男" : @"女";
        }else if ([title isEqualToString:kLocationTitle]){
            text = self.pbUser.location;
        }else if ([title isEqualToString:kChangePwdTitle]){
            text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.detailTextLabel.text = text;
        cell.textLabel.text = title;
    }else if (indexPath.section == self.sectionContact){
        NSString *title = self.sectionContactItems[indexPath.row];
        NSString *imageNames = self.sectionContactImages[indexPath.row];
        NSString *text = @"未关联";
        
        if ([title isEqualToString:kQQTitle]) {
            text = self.pbUser.qqId;
        }else if ([title isEqualToString:kWeixinTitle]){
            text = self.pbUser.weixinId;
        }else if ([title isEqualToString:kSinaTitle]){
            text = self.pbUser.sinaId;
        }else if ([title isEqualToString:kEmailTitle]){
            text = self.pbUser.email;
        }else if ([title isEqualToString:kPhoneTitle]){
            text = self.pbUser.phone;
        }
        cell.imageView.image = [UIImage imageNamed:imageNames];
        cell.detailTextLabel.text = text;
    }else{
        
    }
    cell.detailTextLabel.font = kMiddleLabelFont;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.section == self.sectionBasic) {
        if ([kAvatarTitle isEqualToString:self.sectionBasicItems[indexPath.row]] || [kBackgroundTitle isEqualToString:self.sectionBasicItems[indexPath.row]]) {
            height = 67;
        }else{
            height = kTableViewRowHeight;
        }
    }else{
        height = kTableViewRowHeight;
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
        }else if ([title isEqualToString:kNickTitle]){
            [self updateNick];
        }else if ([title isEqualToString:kBackgroundTitle]){
            [self updateBGImage];
        }else if ([title isEqualToString:kSignatureTitle]){
            [self updateSignature];
        }else{
            //  TODO
        }
    }else if (section == self.sectionMisc){
        NSString *title = self.sectionMiscItems[indexPath.row];
        if ([title isEqualToString:kGenderTitle]) {
            [self updateGender];
        }else if ([title isEqualToString:kChangePwdTitle]){
            [self updatePassword];
        }
    }else{
        //  contact
        NSString *title = self.sectionContactItems[indexPath.row];
        if ([title isEqualToString:kPhoneTitle]) {
            [self updatePhone];
        }else if ([title isEqualToString:kEmailTitle]){
            if (self.pbUser.email.length == 0){
                [self updateEmail];
            }else {
                [self verifyEmail];
            }
        }
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

#pragma mark - Utils
- (void)clickRightButton
{
    SettingController *vc = [[SettingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
