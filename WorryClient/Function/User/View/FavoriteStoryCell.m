//
//  FavoriteStoryCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FavoriteStoryCell.h"
#import "ViewDefault.h"

@implementation FavoriteStoryCell
{
    UIImageView *_triangleImageView;
}
#pragma mark - Public methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadBackgroundView];
        [self loadTitleLabel];
        [self loadContentLabel];
        [self loadThanksLabel];
        [self loadCommentLabel];
    }
    return self;
}

#pragma mark - Default methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).with.multipliedBy(0.95);
        make.height.equalTo(self).with.multipliedBy(0.95);
    }];
    
    [_triangleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.height.equalTo(self.contentView).with.multipliedBy(0.5);
        make.width.equalTo(self.contentView).with.multipliedBy(0.9);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentLabel.mas_top);
        make.left.equalTo(self.contentView.mas_right).with.multipliedBy(0.045);
        make.width.equalTo(self.contentView).with.multipliedBy(0.8);
    }];
    
    [self.thanksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom);
        make.left.equalTo(self.contentLabel);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentLabel);
        make.centerY.equalTo(self.thanksLabel);
    }];
}

#pragma mark - Private methods

- (void)loadBackgroundView
{
    UIImage *image = [UIImage imageNamed:@"favorite_triangle_green"];
    _triangleImageView = [[UIImageView alloc]initWithImage:image];
    
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.backgroundColor = OPAQUE_COLOR(0xd0, 0xff, 0xe3);
    [self.backgroundView addSubview:_triangleImageView];
    
}

- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
}

- (void)loadContentLabel
{
    self.contentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.textColor = [UIColor grayColor];
    self.contentLabel.font = kMiddleLabelFont;
    self.contentLabel.numberOfLines = 0;
}

- (void)loadThanksLabel
{
    self.thanksLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.thanksLabel];
    self.thanksLabel.textColor = [UIColor grayColor];
    self.thanksLabel.font = kSmallLabelFont;
}

- (void)loadCommentLabel
{
    self.commentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.commentLabel];
    self.commentLabel.textColor = [UIColor grayColor];
    self.commentLabel.font = kSmallLabelFont;
}

@end
