//
//  ContributionCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/27.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "ContributionCell.h"
#import "ViewDefault.h"

@implementation ContributionCell

#pragma mark - Public methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadTitleLabel];
        [self loadAnswerLabel];
    }
    return self;
}

#pragma mark - Default methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    [UIView setAsRound:self.imageView];

    CGFloat padding = 16;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView).with.multipliedBy(0.98);
        make.left.equalTo(self.imageView.mas_right).with.offset(+padding);
    }];
    
    [self.answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).with.offset(+padding);
        make.right.equalTo(self.contentView).with.multipliedBy(0.98);
        make.top.equalTo(self.contentView.mas_centerY);
    }];
}

#pragma mark - Private methods

- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
}

- (void)loadAnswerLabel
{
    self.answerLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.answerLabel];
    self.answerLabel.font = kMiddleLabelFont;
    self.answerLabel.textColor = OPAQUE_COLOR(0xbd, 0xbd, 0xbd);
}

@end
