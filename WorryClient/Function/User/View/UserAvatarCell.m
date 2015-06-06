//
//  UserAvatarCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserAvatarCell.h"
#import "ViewDefault.h"
#import "AvatarView.h"

@implementation UserAvatarCell

#pragma mark - Public methods

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.backgroundImageView];
        
        CGFloat borderWidth = 1.0f;
        self.avatarView = [[AvatarView alloc]initWithBorderWidth:borderWidth];
        [self.avatarView addTapGestureWithClickType:AvatarViewClickTypeZoom];
        [self.contentView addSubview:self.avatarView];
        
        self.nickNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.nickNameLabel];
        self.nickNameLabel.textColor = [UIColor whiteColor];    //  TODO
        self.nickNameLabel.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}
#pragma mark - Default methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom).with.multipliedBy(0.1);
        make.height.equalTo(self.contentView).with.multipliedBy(0.4);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(0.4);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom).with.multipliedBy(0.6);
        make.height.equalTo(self.contentView).with.multipliedBy(0.2);
        make.width.equalTo(self.contentView).with.multipliedBy(0.3);
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.equalTo(self.contentView);
    }];
}

@end
