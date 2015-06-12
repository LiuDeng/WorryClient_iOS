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
#import "UserService.h"
#import "EditController.h"
#import "ActionSheetStringPicker.h"
#import "UpdatePhoneController.h"

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

#define kUpdateSuccessMSG   @"修改成功"
#define kUpdateFailedMSG    @"修改失败"

@interface UserDetailController ()

@property (nonatomic,assign) int indexOfSection;  //  Section索引，计数功能
@property (nonatomic,assign) int sectionBasic;
@property (nonatomic,assign) int sectionMisc;
@property (nonatomic,assign) int sectionContact;
@property (nonatomic,strong) NSArray *sectionBasicItems;
@property (nonatomic,strong) NSArray *sectionMiscItems;
@property (nonatomic,strong) NSArray *sectionContactItems;
@property (nonatomic,strong) NSArray *sectionContactImages;    //  image names
@property (nonatomic,strong) PBUser *pbUser;
@property (nonatomic,strong) UpdateImage *updateImage;

@end

@implementation UserDetailController

#pragma mark - Default methods

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
//    [[UserService sharedInstance]refreshUser];
//    self.pbUser = [[UserManager sharedInstance] pbUser];
//    [self.tableView reloadData];
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"个人资料"];
}

- (void)loadData
{
    [super loadData];
    self.sectionBasic = self.indexOfSection++;
    self.sectionMisc = self.indexOfSection++;
    self.sectionContact = self.indexOfSection++;
    self.sectionBasicItems = @[kAvatarTitle,kBackgroundTitle,kNickTitle,kSignatureTitle];
    self.sectionMiscItems = @[kGenderTitle,kChangePwdTitle];
    self.sectionContactItems = @[kQQTitle,kSinaTitle,kPhoneTitle,kEmailTitle];
    self.sectionContactImages = @[@"user_detail_qq",@"user_detail_sina",@"user_detail_phone",@"user_detail_email"];
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
            [detailAvatarCell.avatarView sd_setImageWithURL:[NSURL URLWithString:self.pbUser.avatar]];
            cell = detailAvatarCell;

        }else if([title isEqualToString:kBackgroundTitle]){
            
            UserDetailBGImageCell *detailBGImageCell = [[UserDetailBGImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            detailBGImageCell.textLabel.text = title;
            [detailBGImageCell.BGImageView sd_setImageWithURL:[NSURL URLWithString:self.pbUser.bgImage]];
            cell = detailBGImageCell;
            
        }else{
            
            cell.textLabel.text = title;
            NSString *text = @"未设置";
            if ([title isEqualToString:kNickTitle]) {
                text = self.pbUser.nick.length == 0 ? text : self.pbUser.nick;
            }else if ([title isEqualToString:kSignatureTitle]){
                text = self.pbUser.signature.length == 0 ? text : self.pbUser.signature;
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
            text = self.pbUser.location.length == 0 ? text : self.pbUser.location;
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
            text = self.pbUser.qqId.length == 0 ? text : self.pbUser.qqId;
        }else if ([title isEqualToString:kWeixinTitle]){
            text = self.pbUser.weixinId.length == 0 ? text : self.pbUser.weixinId;
        }else if ([title isEqualToString:kSinaTitle]){
            text = self.pbUser.sinaId.length == 0 ? text : self.pbUser.sinaId;
        }else if ([title isEqualToString:kEmailTitle]){
            text = self.pbUser.emailVerified ? self.pbUser.email : @"未验证";
        }else if ([title isEqualToString:kPhoneTitle]){
            text = self.pbUser.phoneVerified ? self.pbUser.phone : @"未验证";
        }
        
        cell.imageView.image = [UIImage imageNamed:imageNames];
        cell.detailTextLabel.text = text;
//        cell.textLabel.text = title;
    }else{
        
    }
    cell.detailTextLabel.font = kMiddleLabelFont;
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

- (void)updateAvatar
{
    NSString *actionSheetTitle = @"请选择";
    self.updateImage = [[UpdateImage alloc]init];
    [self.updateImage showSelectionWithTitle:actionSheetTitle superViewController:self selectedImageBlock:^(UIImage *image) {
        if (image) {
            [[UserService sharedInstance]updateAvatar:image block:^(NSError *error) {
                if (error == nil) {
                    self.pbUser = [[UserManager sharedInstance]pbUser];
                    [self.tableView reloadData];
                    POST_SUCCESS_MSG(kUpdateSuccessMSG);    //  TODO
                }
            }];
        }
    }];
}

- (void)updateBGImage
{
    NSString *actionSheetTitle = @"请选择";
    self.updateImage = [[UpdateImage alloc]init];
    [self.updateImage showSelectionWithTitle:actionSheetTitle superViewController:self selectedImageBlock:^(UIImage *image) {
        if (image) {
            [[UserService sharedInstance]updateBGImage:image block:^(NSError *error) {
                if (error == nil) {
                    self.pbUser = [[UserManager sharedInstance]pbUser];
                    [self.tableView reloadData];
                    POST_SUCCESS_MSG(kUpdateSuccessMSG);    //  TODO
                }
            }];
        }
    }];
}

- (void)updateNick
{
    EditController *editController = [[EditController alloc]initWithText:self.pbUser.nick
                                                             placeholder:@"请输入昵称"
                                                                    tips:@"来吧，取个炫酷的名字！"
                                                                 isMulti:NO
                                                         saveActionBlock:^(NSString *text) {
        [[UserService sharedInstance]updateNick:text block:^(NSError *error) {
            if (error == nil) {
                POST_SUCCESS_MSG(kUpdateSuccessMSG);
            }else{
                POST_ERROR_MSG(kUpdateFailedMSG);
            }
        }];
    }];
    [self.navigationController pushViewController:editController animated:YES];
}

- (void)updateSignature
{
    EditController *editController = [[EditController alloc]initWithText:self.pbUser.signature
                                                             placeholder:@"请输入签名"
                                                                    tips:@"签名，签的就是我的心事"
                                                                 isMulti:NO
                                                         saveActionBlock:^(NSString *text) {
        [[UserService sharedInstance]updateSignature:text block:^(NSError *error) {
            if (error == nil) {
                POST_SUCCESS_MSG(kUpdateSuccessMSG);
            }else{
                POST_ERROR_MSG(kUpdateFailedMSG);
            }
        }];
    }];
    [self.navigationController pushViewController:editController animated:YES];
}

- (void)updateGender
{
    NSArray *genderTexts = @[@"男",@"女"];
    BOOL gender = self.pbUser.gender;
    NSInteger selection = gender ? 0 : 1;
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc]initWithTitle:nil
                                                                               rows:genderTexts
                                                                   initialSelection:selection
                                                                          doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                              if (selectedIndex != selection) {
                                                                                  [[UserService sharedInstance]updateGender:!gender block:^(NSError *error) {
                                                                                      if (error == nil) {
                                                                                          POST_SUCCESS_MSG(kUpdateSuccessMSG);
                                                                                          [self refreshData];
                                                                                      }else{
                                                                                          POST_ERROR_MSG(kUpdateFailedMSG);
                                                                                      }
                                                                                  }];
                                                                              }
    } cancelBlock:nil origin:self.view];
    
    UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:nil];
    [picker setCancelButton:cancelBarItem];
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:nil];
    [picker setDoneButton:doneBarItem];
    [picker showActionSheetPicker];
}

- (void)updatePhone
{
    //  TODO pbUser 得传过去?
    UpdatePhoneController *vc = [[UpdatePhoneController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateEmail
{
    NSString *emailText = self.pbUser.email;
    NSString *placeholder = @"请输入常用邮箱";
    NSString *tips = @"邮箱验证之后，可以用于找回密码";
    EditController *vc = [[EditController alloc]initWithText:emailText
                                                 placeholder:placeholder
                                                        tips:tips
                                                     isMulti:NO
                                             saveActionBlock:^(NSString *text) {
                                                 [[UserService sharedInstance]updateEmail:text block:^(NSError *error) {
                                                     if (error == nil) {
                                                         POST_SUCCESS_MSG(kUpdateSuccessMSG);
                                                     }else{
                                                         POST_ERROR_MSG(kUpdateFailedMSG);
                                                     }
                                                 }];
                        }];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)verifyEmail
{
    [[UserService sharedInstance]requestEmailVerify:self.pbUser.email withBlock:^(NSError *error) {
        if (error == nil) {
            POST_SUCCESS_MSG(@"验证链接已发送到邮箱");
            [self.tableView reloadData];
        }else {
            POST_ERROR_MSG(@"验证失败，请稍候再试");
        }
    }];
}

- (void)refreshData
{
    [[UserService sharedInstance]refreshUser];
    self.pbUser = [[UserManager sharedInstance] pbUser];
    [self.tableView reloadData];
}

@end
