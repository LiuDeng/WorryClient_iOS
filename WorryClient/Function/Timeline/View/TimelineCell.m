//
//  TimelineCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/17.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "TimelineCell.h"
#import "Feed.pb.h"
#import "ViewDefault.h"
#import "UIColor+UIColorExt.h"

//const CGFloat kWidthScale = 0.9;
@implementation TimelineCell

#pragma mark - Default methods

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadBackgroundView];
        [self loadTitleLabel];
        [self loadShortTextLabel];
        [self loadTopicLabel];
        [self loadCommentNumLabel];
        [self loadCommentImageView];
        [self loadBlessingNumLabel];
        [self loadBlessingImageView];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).with.multipliedBy(0.95);
        make.height.equalTo(self).with.multipliedBy(0.95);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).with.multipliedBy(0.1);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.contentView).with.multipliedBy(0.2);
    }];
    
    [self.shortTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.equalTo(self.contentView).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.contentView).with.multipliedBy(0.4);
    }];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).with.multipliedBy(0.9);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(self.contentView).with.multipliedBy(0.6);
        make.height.equalTo(self.contentView).with.multipliedBy(0.2);
    }];
    //    self.topicLabel.backgroundColor  = [UIColor greenColor];
    
    
    [self.commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shortTextLabel);
        make.bottom.equalTo(self.topicLabel);
        make.width.equalTo(self.contentView).with.multipliedBy(0.05);//  TODO
        make.centerY.equalTo(self.topicLabel);
    }];
    
    [self.commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentNumLabel.mas_left);
        make.height.equalTo(self.contentView.mas_width).with.multipliedBy(0.042);
        make.width.equalTo(self.contentView).with.multipliedBy(0.042);
        make.centerY.equalTo(self.topicLabel);
    }];
    
    [self.blessingNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentImageView.mas_left);
        make.centerY.equalTo(self.topicLabel);
        make.width.equalTo(self.contentView).with.multipliedBy(0.05);//  TODO
        make.height.equalTo(self.topicLabel);
    }];
    
    [self.blessingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.blessingNumLabel.mas_left);
        make.height.equalTo(self.contentView.mas_width).with.multipliedBy(0.042);
        make.width.equalTo(self.contentView).with.multipliedBy(0.042);
        make.centerY.equalTo(self.topicLabel);
    }];
}

#pragma mark - Public methods

#pragma mark - Private methods

- (void)loadBackgroundView
{
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.borderWidth = kLayerBorderWidth*2;
    self.backgroundView.layer.borderColor = [kLayerColor CGColor];
}
- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor = OPAQUE_COLOR(0x69, 0x69, 0x69);
    self.titleLabel.font = kLargeLabelFont;
}

- (void)loadShortTextLabel
{
    self.shortTextLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.shortTextLabel];
    self.shortTextLabel.numberOfLines = 0;
    self.shortTextLabel.font = kSmallLabelFont;
    self.shortTextLabel.textColor = OPAQUE_COLOR(0x7C, 0x86, 0x92);
}

- (void)loadTopicLabel
{
    self.topicLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.topicLabel];
    self.topicLabel.font = kMiddleLabelFont;
    self.topicLabel.textColor = OPAQUE_COLOR(0x00, 0xAE, 0xE9);
}

- (void)loadCommentNumLabel
{
    self.commentNumLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.commentNumLabel];
    self.commentNumLabel.font = kLargeLabelFont;
    self.commentNumLabel.textAlignment = NSTextAlignmentCenter;
    self.commentNumLabel.textColor = OPAQUE_COLOR(0x8E, 0xA0, 0x9A);
}

- (void)loadBlessingNumLabel
{
    self.blessingNumLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.blessingNumLabel];
    self.blessingNumLabel.font = kLargeLabelFont;
    self.blessingNumLabel.textAlignment = NSTextAlignmentCenter;
    self.blessingNumLabel.textColor = OPAQUE_COLOR(0x8E, 0xA0, 0x9A);
}

- (void)loadBlessingImageView
{
    UIImage *image = [UIImage imageNamed:@"blessing"];
    self.blessingImageView = [[UIImageView alloc]initWithImage:image];
    [self.contentView addSubview:self.blessingImageView];
}

- (void)loadCommentImageView
{
    UIImage *image = [UIImage imageNamed:@"comment"];
    self.commentImageView = [[UIImageView alloc]initWithImage:image];
    [self.contentView addSubview:self.commentImageView];
}
@end
