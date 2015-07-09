//
//  UserDetailController+Utils.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserDetailController+Utils.h"
#import "ActionSheetStringPicker.h"
#import "EditController.h"
#import "RequestCodeController.h"
#import "EditController.h"
#import "UpdatePWDController.h"

#define kUpdateSuccessMSG   @"修改成功"
#define kUpdateFailedMSG    @"修改失败"

@implementation UserDetailController (Utils)

#pragma mark - Utils

- (void)updateAvatar
{
    NSString *actionSheetTitle = @"请选择";
    self.updateImage = [[UpdateImage alloc]init];
    [self.updateImage showSelectionWithTitle:actionSheetTitle superViewController:self selectedImageBlock:^(UIImage *image) {
        if (image) {
            [[UserService sharedInstance]updateAvatar:image block:^(NSError *error) {
                if (error == nil) {
                    self.pbUser = [[UserService sharedInstance]currentPBUser];
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
                    self.pbUser = [[UserService sharedInstance]currentPBUser];
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
                                                                 if (error) {
                                                                     POST_ERROR_MSG(kUpdateFailedMSG);
                                                                 }else{
                                                                     POST_SUCCESS_MSG(kUpdateSuccessMSG);
                                                                     [editController.navigationController popViewControllerAnimated:YES];
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
                                                                 if (error) {
                                                                     POST_ERROR_MSG(kUpdateFailedMSG);
                                                                 }else{
                                                                     POST_SUCCESS_MSG(kUpdateSuccessMSG);
                                                                     [editController.navigationController popViewControllerAnimated:YES];
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
                                                     if (error) {
                                                         POST_ERROR_MSG(kUpdateFailedMSG);
                                                     }else{
                                                         POST_SUCCESS_MSG(kUpdateSuccessMSG);
                                                         [vc.navigationController popViewControllerAnimated:YES];
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
//    [[UserService sharedInstance]refreshUser];
//    self.pbUser = [[UserManager sharedInstance] pbUser];
    self.pbUser = [[UserService sharedInstance]currentPBUser];
    [self.tableView reloadData];
}

- (void)updatePassword
{
    UpdatePWDController *vc = [[UpdatePWDController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
