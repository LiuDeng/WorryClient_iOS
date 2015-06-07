//
//  UserInfoAvatarCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/7.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"

@interface UserInfoAvatarCell : UITableViewCell

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UIImageView *genderImageView;  
@property (nonatomic,strong) UILabel *signatureLabel;
@property (nonatomic,strong) UIButton *followingBtn;
@property (nonatomic,strong) UIButton *MSGBtn;              //  私信TA

@end
