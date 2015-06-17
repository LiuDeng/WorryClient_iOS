//
//  UserDetailController+Utils.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserDetailController.h"

@interface UserDetailController (Utils)

- (void)updateAvatar;
- (void)updateBGImage;
- (void)updateNick;
- (void)updateSignature;
- (void)updateGender;
- (void)updatePhone;
- (void)updateEmail;
- (void)verifyEmail;
- (void)refreshData;
- (void)updatePassword;

@end
