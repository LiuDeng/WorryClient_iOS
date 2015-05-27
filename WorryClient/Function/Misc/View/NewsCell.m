//
//  NewsCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/26.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "NewsCell.h"
#import "ViewDefault.h"

@implementation NewsCell

#pragma mark - Public methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadAvatarView];
        [self loadNickLabel];
        [self loadDescriptionLabel];
        [self loadTimeLabel];
    }
    return self;
}

#pragma mark - Private methods

- (void)loadAvatarView
{
    self.avatarView = [[AvatarView alloc]initWithBorderWidth:kLayerBorderWidth];
    [self.contentView addSubview:self.avatarView];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_right).with.multipliedBy(0.03);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(0.7);
        make.height.equalTo(self.contentView).with.multipliedBy(0.7);
    }];
    
}

- (void)loadNickLabel
{
    self.nickLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nickLabel];
    float padding = 16;
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.avatarView.mas_right).with.offset(+padding);
    }];
}

- (void)loadDescriptionLabel
{
    self.descriptionLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.descriptionLabel];
    self.descriptionLabel.font = kMiddleLabelFont;
    self.descriptionLabel.textColor = OPAQUE_COLOR(0xbd, 0xbd, 0xbd);
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickLabel);
        make.top.equalTo(self.contentView.mas_centerY);
    }];
}

- (void)loadTimeLabel
{
    self.timeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.textColor = OPAQUE_COLOR(0xbd, 0xbd, 0xbd);
    self.timeLabel.font = kMiddleLabelFont;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.multipliedBy(0.97);
        make.centerY.equalTo(self.descriptionLabel);
    }];
}

@end

