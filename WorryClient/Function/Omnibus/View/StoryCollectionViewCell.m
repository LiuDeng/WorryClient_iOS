//
//  StoryCollectionViewCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "StoryCollectionViewCell.h"
#import "ViewDefault.h"

@implementation StoryCollectionViewCell

#pragma mark -Default methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}


#pragma mark - Private methods

- (void)loadView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.borderWidth = 0.5f;
   
    [self.contentView.layer setBorderColor:[OPAQUE_COLOR(0xE7, 0xE9, 0xE9)CGColor]];
    [self loadTitleLabel];
    [self loadAuthorLabel];
    [self loadDateLabel];
}

- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = kLabelBlackColor;
    self.titleLabel.font = kLargeLabelFont;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView).with.multipliedBy(0.7);
    }];
}

- (void)loadAuthorLabel
{
    self.authorLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.authorLabel];
    self.authorLabel.textColor = OPAQUE_COLOR(0Xdf,0Xdf,0Xdf);
    self.authorLabel.font = kMiddleLabelFont;
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(self.titleLabel).with.multipliedBy(0.5);
    }];
    
}

- (void)loadDateLabel
{
    self.dateLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.dateLabel];
    self.dateLabel.textColor = OPAQUE_COLOR(0Xdf,0Xdf,0Xdf);
    self.dateLabel.font = kMiddleLabelFont;
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.width.equalTo(self.titleLabel).with.multipliedBy(0.5);
        make.top.equalTo(self.contentView.mas_centerY);
    }];
}
@end
