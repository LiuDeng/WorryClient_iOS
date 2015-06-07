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
        [self.contentView addSubview:self.avatarView];
        [self.avatarView addTapGestureWithClickType:AvatarViewClickTypeZoom];
        
        self.nickLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.nickLabel];
        self.nickLabel.textColor = [UIColor whiteColor];
        self.nickLabel.textAlignment = NSTextAlignmentCenter;
        
        self.genderImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.genderImageView];
        
        self.signatureLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.signatureLabel];
        self.signatureLabel.textColor = [UIColor whiteColor];
        self.signatureLabel.textAlignment = NSTextAlignmentCenter;
        
        self.MSGBtn = [UIButton buttonWithNormalTitle:@""];
        [self.contentView addSubview:self.MSGBtn];
        self.MSGBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        
        self.followingBtn = [UIButton buttonWithNormalTitle:@""];
        [self.contentView addSubview:self.followingBtn];
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
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(0.4);
        make.height.equalTo(self.contentView).with.multipliedBy(0.4);
    }];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.avatarView.mas_bottom);
        make.width.equalTo(self.contentView).with.multipliedBy(0.5);
    }];
    
    [self.genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nickLabel);
        make.left.equalTo(self.nickLabel.mas_right);
    }];
    
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.nickLabel.mas_bottom);
        make.width.equalTo(self.contentView).with.multipliedBy(0.5);
    }];
    
    [self.MSGBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).with.multipliedBy(0.95);
        make.bottom.equalTo(self.contentView).with.multipliedBy(0.95);
    }];
    
    [self.followingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).with.multipliedBy(1.05);
        make.centerY.equalTo(self.MSGBtn);
    }];
}

@end
