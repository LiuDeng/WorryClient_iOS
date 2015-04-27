//
//  UserAvatarCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"

@interface UserAvatarCell : UITableViewCell

@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UIImageView *backgroundImageView;

@end
