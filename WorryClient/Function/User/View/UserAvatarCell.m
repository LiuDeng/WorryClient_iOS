//
//  UserAvatarCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserAvatarCell.h"
#import "Masonry.h"
#import "FontInfo.h"
#import "ViewInfo.h"
#import "AvatarView.h"
//#import "User.pb.h"

#define AVTARVIEW_HEIGHT_WIDTH 80
#define FOLLOWING_VIEW_HEIGHT_WIDTH 30
#define FOLLOWERS_VIEW_HEIGHT_WIDTH 30

@implementation UserAvatarCell
{
    UIView *followingHoldView;
    UIView *followersHoldView;
    UIImageView *followingShadowImageView;
    UIImageView *followersShadowImageView;
//    PBUser *_pbUser;
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier pbUser:(PBUser *)pbUser
//{
//    
//}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadData];
        [self.contentView addSubview:_avatarView];
        [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(+kLeftPadding);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@(AVTARVIEW_HEIGHT_WIDTH));
            make.width.equalTo(@(AVTARVIEW_HEIGHT_WIDTH));
        }];
        
        [self.contentView addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarView.mas_right).with.offset(+kLeftPadding);
            make.bottom.equalTo(self.contentView.mas_centerY);
        }];

        [self.contentView addSubview:_userIdLabel];
        [_userIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nickNameLabel);
            make.top.equalTo(self.contentView.mas_centerY);
        }];
        
        followersShadowImageView = [[UIImageView alloc]initWithImage:nil];
        followersShadowImageView.backgroundColor = [UIColor grayColor];
        
        followingShadowImageView = [[UIImageView alloc]initWithImage:nil];
        followingShadowImageView.backgroundColor = [UIColor grayColor];
        
        [self loadFollowingHoldView];
        [self loadFollowersHoldView];

        
    }
    return self;
}

-(void)loadData
{
    CGRect avatarViewFrame = CGRectMake(0, 0, AVTARVIEW_HEIGHT_WIDTH, AVTARVIEW_HEIGHT_WIDTH);
    CGFloat borderWidth = 1.0f;
    self.avatarView = [[AvatarView alloc]initWithFrame:avatarViewFrame borderWidth:borderWidth];
    self.avatarView.imageView.image = [UIImage imageNamed:@"avatar01"];
    
    self.nickNameLabel = [[UILabel alloc]init];
    self.nickNameLabel.text = @"涵涵涵_茹";  // TODO
//    self.nickNameLabel.font = ;
    
    self.userIdLabel = [[UILabel alloc]init];
    NSString *userIdStr = @"000000";
    self.userIdLabel.text = [NSString stringWithFormat:@"心事号：%@",userIdStr];
    self.userIdLabel.font = USER_ID_LABEL_FONT;
    
    self.followingImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test_first_page_normal"]];
    
    self.followingTittleLabel = [[UILabel alloc]init];
    self.followingTittleLabel.text = @"我在乎";
    self.followingTittleLabel.tintColor = [UIColor blackColor];
    self.followingTittleLabel.font = LABEL_SMALL_FONT;
    self.followingTittleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.followingNumLabel = [[UILabel alloc]init];
    self.followingNumLabel.text = @"23";
    self.followingNumLabel.textColor = [UIColor redColor];
    self.followingNumLabel.textAlignment = NSTextAlignmentCenter;
    
    self.followersImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test_first_page_normal"]];

    self.followersNumLabel = [[UILabel alloc]init];
    self.followersNumLabel.text = @"12";
    self.followersNumLabel.textColor = [UIColor redColor];
    self.followersNumLabel.textAlignment = NSTextAlignmentCenter;
    
    self.followersTittleLabel = [[UILabel alloc]init];
    self.followersTittleLabel.text = @"在乎我";
    self.followersTittleLabel.font = LABEL_SMALL_FONT;
    self.followersTittleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)manageHoldView:(UIView *)holdView
             ImageView:(UIImageView *)imgView
              NumLabel:(UILabel *)numLabel
       shadowImageView:(UIImageView *)shadowImgView
            styleLabel:(UILabel *)styleLabel
{
    [holdView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(holdView);
        make.centerY.equalTo(holdView);
        make.height.equalTo(holdView);
        make.width.equalTo(holdView).with.dividedBy(2);
    }];
    
    [holdView addSubview:shadowImgView];
    [shadowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(holdView);
        make.top.equalTo(holdView);
        make.height.equalTo(holdView).with.dividedBy(2);
        make.width.equalTo(holdView).with.dividedBy(2);
    }];
    
    [shadowImgView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(shadowImgView);
        make.height.equalTo(shadowImgView);
        make.width.equalTo(shadowImgView);
    }];
    
    [holdView addSubview:styleLabel];
    [styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shadowImgView);
        make.top.equalTo(shadowImgView.mas_bottom);
        make.width.equalTo(shadowImgView);
        make.height.equalTo(shadowImgView);
    }];
    
}
- (void)loadFollowingHoldView
{
    followingHoldView = [[UIView alloc]init];
    [self.contentView addSubview:followingHoldView];
    [followingHoldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView).with.offset(-kRightPadding);
        make.height.equalTo(self.contentView).with.dividedBy(3);
        make.width.equalTo(self.contentView).with.dividedBy(4);
    }];
    
    [self manageHoldView:followingHoldView
               ImageView:_followingImageView
                NumLabel:_followingNumLabel
         shadowImageView:followingShadowImageView
              styleLabel:_followingTittleLabel];
}
- (void)loadFollowersHoldView
{
    followersHoldView = [[UIView alloc]init];
    [self.contentView addSubview:followersHoldView];
    [followersHoldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView).with.offset(-kRightPadding);
        make.height.equalTo(self.contentView).with.dividedBy(3);
        make.width.equalTo(self.contentView).with.dividedBy(4);
    }];
    
    [self manageHoldView:followersHoldView
               ImageView:_followersImageView
                NumLabel:_followersNumLabel
         shadowImageView:followersShadowImageView
              styleLabel:_followersTittleLabel];
}
@end
