//
//  UserAvatarCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AvatarView;

@interface UserAvatarCell : UITableViewCell

@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UILabel *userIdLabel;
@property (nonatomic,strong) UILabel *followersNumLabel;
@property (nonatomic,strong) UILabel *followersTittleLabel;
@property (nonatomic,strong) UILabel *followingNumLabel;
@property (nonatomic,strong) UILabel *followingTittleLabel;
@property (nonatomic,strong) UIImageView *followersImageView;
@property (nonatomic,strong) UIImageView *followingImageView;

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier pbUser:(PBUser *)pbUser;

@end
