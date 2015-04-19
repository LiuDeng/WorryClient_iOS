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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier //pbFeed:(PBFeed *)pbFeed
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadBackgroundView];
        [self loadTitleLabel];
        [self loadShortTextLabel];
        [self loadTopicLabel];
        [self loadCommentNumLabel];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).with.multipliedBy(0.95);
        make.height.equalTo(self).with.multipliedBy(0.9);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).with.multipliedBy(0.1);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.contentView).with.multipliedBy(0.25);
    }];
    
    [self.shortTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.equalTo(self.contentView).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.contentView).with.multipliedBy(0.5);
    }];
    
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).with.multipliedBy(0.9);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(self.contentView).with.multipliedBy(0.5);
        make.height.equalTo(self.contentView).with.multipliedBy(0.25);
    }];
    
    [self.commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.topicLabel);
        make.width.equalTo(@20);//  TODO
        make.height.equalTo(self.topicLabel);
    }];
}

#pragma mark - Public methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier pbFeed:(PBFeed *)pbFeed
{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _pbFeed = pbFeed;
        self.titleLabel.text = _pbFeed.title ? _pbFeed.title : @"2";
        self.shortTextLabel.text = _pbFeed.text ? _pbFeed.text : @"1";
        
        NSMutableString *topicString = [[NSMutableString alloc]init];
        if (_pbFeed.topic) {
            for (int i = 0; i<_pbFeed.topic.count; i++) {
                NSString *topic = [_pbFeed.topic objectAtIndex:i];
                if (i == _pbFeed.topic.count-1) {
                    
                    [topicString appendFormat:@"%@",topic];
                }else{
                    [topicString appendFormat:@"%@，",topic];
                }
            }
        }
        self.topicLabel.text = topicString;
        self.commentNumLabel.text = @"32";
    }
    return self;
}

#pragma mark - Private methods

- (void)loadBackgroundView
{
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.borderWidth = kLayerBorderWidth;
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

@end
