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

const CGFloat kWidthScale = 0.9;
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
    
    [self.blessingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).with.multipliedBy(1.6);
        make.height.equalTo(self.topicLabel);
        make.width.equalTo(self.contentView).with.multipliedBy(0.06);
        make.bottom.equalTo(self.topicLabel);
    }];
    
    [self.blessingNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.blessingImageView);
        make.bottom.equalTo(self.topicLabel);
        make.width.equalTo(self.contentView).with.multipliedBy(0.05);//  TODO
        make.height.equalTo(self.topicLabel);
    }];
    
    [self.commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentNumLabel.mas_leading);
        make.height.equalTo(self.topicLabel);
        make.width.equalTo(self.contentView).with.multipliedBy(0.06);
        make.bottom.equalTo(self.topicLabel);
    }];
    
    [self.commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.topicLabel);
        make.width.equalTo(self.contentView).with.multipliedBy(0.05);//  TODO
        make.height.equalTo(self.topicLabel);
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
}

- (void)loadShortTextLabel
{
    self.shortTextLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.shortTextLabel];
    self.shortTextLabel.numberOfLines = 0;
    self.shortTextLabel.font = kSmallLabelFont;
}

- (void)loadTopicLabel
{
    self.topicLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.topicLabel];
    self.topicLabel.font = kMiddldLabelFont;
}

- (void)loadCommentNumLabel
{
    self.commentNumLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.commentNumLabel];
    self.commentNumLabel.font = kSmallLabelFont;
}

- (void)loadBlessingNumLabel
{
    self.blessingNumLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.blessingNumLabel];
    self.blessingNumLabel.font = kSmallLabelFont;
}

- (void)loadBlessingImageView
{
    UIImage *image = [UIImage imageNamed:@""];
    self.blessingImageView = [[UIImageView alloc]initWithImage:image];
    [self.contentView addSubview:self.blessingImageView];
}

- (void)loadCommentImageView
{
    UIImage *image = [UIImage imageNamed:@""];
    self.commentImageView = [[UIImageView alloc]initWithImage:image];
    [self.contentView addSubview:self.commentImageView];
}
@end
