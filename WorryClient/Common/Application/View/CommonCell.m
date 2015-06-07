//
//  CommonCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/30.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonCell.h"
#import "ViewDefault.h"

@implementation CommonCell

#pragma mark - Public methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadContentLabel];
        [self loadDescriptionLabel];
        [self loadAdditionalLabel];
    }
    return self;
}

#pragma mark - Default methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setAsRound];
    
    float padding = 16;
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.imageView.mas_right).with.offset(+padding);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descriptionLabel);
        make.top.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.additionalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.multipliedBy(0.97);
        make.centerY.equalTo(self.contentLabel);
    }];
}

#pragma mark - Private methods



- (void)loadDescriptionLabel
{
    self.descriptionLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.descriptionLabel];
    
}

- (void)loadContentLabel
{
    self.contentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.font = kMiddleLabelFont;
    self.contentLabel.textColor = [UIColor grayColor];
    
    
}

- (void)loadAdditionalLabel
{
    self.additionalLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.additionalLabel];
    self.additionalLabel.textColor = [UIColor grayColor];
    self.additionalLabel.font = kMiddleLabelFont;
}

@end
