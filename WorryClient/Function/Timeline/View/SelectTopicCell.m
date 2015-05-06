//
//  SelectTopicCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "SelectTopicCell.h"
#import "ViewDefault.h"

@implementation SelectTopicCell

#pragma mark - Default methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height = self.contentView.bounds.size.height;
    [UIView setRoundCorner:self.contentView radius:height/2];
    self.contentView.layer.borderColor = [kLayerColor CGColor];
    self.contentView.layer.borderWidth = kLayerBorderWidth;
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

#pragma  mark - Private methods

- (void)loadView
{
    [self loadTitleLabel];
}

- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = kLargeLabelFont;
}

@end
