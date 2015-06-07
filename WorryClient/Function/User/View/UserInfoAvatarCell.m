//
//  UserInfoAvatarCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/7.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserInfoAvatarCell.h"
#import "ViewDefault.h"

@implementation UserInfoAvatarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bgImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.bgImageView];
        
        self.avatarView = [[AvatarView alloc]initWithBorderWidth:1.0f];
        [self.bgImageView addSubview:self.avatarView];
        [self.avatarView addTapGestureWithClickType:AvatarViewClickTypeZoom];
        
        self.nickLabel = [[UILabel alloc]init];
        [self.bgImageView addSubview:self.nickLabel];
        self.nickLabel.textColor = [UIColor whiteColor];
        
        self.genderImageView = [[UIImageView alloc]init];
        [self.bgImageView addSubview:self.genderImageView];
        
        self.signatureLabel = [[UILabel alloc]init];
        [self.bgImageView addSubview:self.signatureLabel];
        self.signatureLabel.textColor = [UIColor whiteColor];
        
        self.MSGBtn = [UIButton buttonWithNormalTitle:@""];
        [self.bgImageView addSubview:self.MSGBtn];
        self.MSGBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        
        self.followingBtn = [UIButton buttonWithNormalTitle:@""];
        [self.bgImageView addSubview:self.followingBtn];
        self.followingBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.contentView);
        make.center.equalTo(self.contentView);
    }];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.bottom.equalTo(self.bgImageView.mas_centerY);
        make.width.equalTo(self.bgImageView.mas_height).with.multipliedBy(0.4);
        make.height.equalTo(self.bgImageView).with.multipliedBy(0.4);
    }];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.top.equalTo(self.avatarView.mas_bottom);
    }];
    
    [self.genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nickLabel);
        make.left.equalTo(self.nickLabel.mas_right);
    }];
    
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.top.equalTo(self.nickLabel.mas_bottom);
    }];
    
    [self.MSGBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_centerX).with.multipliedBy(0.95);
        make.bottom.equalTo(self.bgImageView).with.multipliedBy(0.95);
    }];
    
    [self.followingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_centerX).with.multipliedBy(1.05);
        make.centerY.equalTo(self.MSGBtn);
    }];
}

@end
