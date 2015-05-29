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
#import "Utils.h"
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
        [self loadTopicButton];
        [self loadReplyButton];
        [self loadBlessingButton];
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
    
    [self.topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).with.multipliedBy(0.9);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).with.multipliedBy(0.85);
        make.centerY.equalTo(self.topicButton);
    }];
    
    [self.blessingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).with.multipliedBy(0.75);
        make.centerY.equalTo(self.topicButton);
    }];
}

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
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

- (void)loadShortTextLabel
{
    self.shortTextLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.shortTextLabel];
    self.shortTextLabel.numberOfLines = 0;
    self.shortTextLabel.font = [UIFont systemFontOfSize:14];
    self.shortTextLabel.textColor = [UIColor grayColor];
}

- (void)loadReplyButton
{
    self.replyButton = [[UIButton alloc]init];
    [self.contentView addSubview:self.replyButton];
    UIImage *image = [UIImage imageNamed:@"comment"];
    [self.replyButton setImage:image forState:UIControlStateNormal];
    [self.replyButton setTitleColor:OPAQUE_COLOR(0x8E, 0xA0, 0x9A) forState:UIControlStateNormal];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    self.replyButton.titleEdgeInsets = edgeInsets;
//    [self.commentButton addTarget:self action:@selector(clickCommentButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadBlessingButton
{
    self.blessingButton = [[UIButton alloc]init];
    [self.contentView addSubview:self.blessingButton];
    UIImage *image = [UIImage imageNamed:@"blessing"];
    [self.blessingButton setImage:image forState:UIControlStateNormal];
    [self.blessingButton setTitleColor:OPAQUE_COLOR(0x8E, 0xA0, 0x9A) forState:UIControlStateNormal];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    self.blessingButton.titleEdgeInsets = edgeInsets;
//    [self.blessingButton addTarget:self action:@selector(clickBlessingButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadTopicButton
{
    self.topicButton = [[UIButton alloc]init];
    [self.contentView addSubview:self.topicButton];
    [self.topicButton setTitleColor:OPAQUE_COLOR(0x00, 0xAE, 0xE9) forState:UIControlStateNormal];
//    [self.topicButton addTarget:self action:@selector(clickTopicButton) forControlEvents:UIControlEventTouchUpInside];
    self.topicButton.titleLabel.font = [UIFont systemFontOfSize:14];
}

#pragma mark - Utils

//- (void)clickCommentButton
//{
//    EXECUTE_BLOCK(self.clickCommentButtonBlock);
//}
//
//- (void)clickBlessingButton
//{
//    EXECUTE_BLOCK(self.clickBlessingButtonBlock);
//}
//
//- (void)clickTopicButton
//{
//    EXECUTE_BLOCK(self.clickTopicButtonBlock);
//}

@end
