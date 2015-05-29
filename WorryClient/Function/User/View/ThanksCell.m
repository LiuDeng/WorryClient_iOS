//
//  ThanksCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "ThanksCell.h"
#import "ViewDefault.h"

@implementation ThanksCell

#pragma mark - Default methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadAvatarView];
        [self loadAnswerLabel];
        [self loadDescriptionLabel];
        [self loadDateLabel];
    }
    return self;
}

#pragma mark - Default methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_right).with.multipliedBy(0.03);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(0.7);
        make.height.equalTo(self.contentView).with.multipliedBy(0.7);
    }];
    
    float padding = 16;
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.avatarView.mas_right).with.offset(+padding);
    }];
    
    [self.answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descriptionLabel);
        make.top.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.multipliedBy(0.97);
        make.centerY.equalTo(self.answerLabel);
    }];
}

#pragma mark - Private methods
- (void)loadAvatarView
{
    self.avatarView = [[AvatarView alloc]initWithBorderWidth:kLayerBorderWidth];
    [self.contentView addSubview:self.avatarView];
}

- (void)loadDescriptionLabel
{
    self.descriptionLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.descriptionLabel];
}

- (void)loadAnswerLabel
{
    self.answerLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.answerLabel];
    self.answerLabel.font = kMiddleLabelFont;
    self.answerLabel.textColor = [UIColor grayColor];
}

- (void)loadDateLabel
{
    self.dateLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.dateLabel];
    self.dateLabel.textColor = [UIColor grayColor];
    self.dateLabel.font = kMiddleLabelFont;
}

@end
