//
//  WorryAnswerCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/2.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "WorryAnswerCell.h"
#import "ViewDefault.h"

@implementation WorryAnswerCell

#pragma mark - Default methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_nickHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.width.equalTo(self.contentView).with.multipliedBy(0.9);
//        make.top.equalTo(self.contentView);
        make.top.equalTo(self.avatarView);
        make.height.equalTo(self.contentView).with.multipliedBy(0.3);
    }];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_nickHolderView);
        make.top.equalTo(_nickHolderView);
        make.left.equalTo(_nickHolderView);
    }];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.contentView).with.multipliedBy(0.38);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(0.38);
        make.top.equalTo(self.contentView.mas_bottom).with.multipliedBy(0.1);
        make.left.equalTo(self.contentView);
    }];
    
    [self.thanksButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_bottom).with.offset(+kVerticalPadding);
        make.centerX.equalTo(self.avatarView);
    }];
    
    [self.shortTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(_nickHolderView.mas_bottom);
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.avatarView.mas_right);
    }];
}

#pragma mark - Private methods

- (void)loadView
{
    self.contentView.layer.borderColor = [kLayerColor CGColor];
    self.contentView.layer.borderWidth = 0.5;
    [self loadAvatarView];
    [self loadTitleHolderView];
    [self loadShortTextLabel];
}

- (void)loadAvatarView
{
    self.avatarView = [[AvatarView alloc]initWithBorderWidth:kLayerBorderWidth];
    [self.contentView addSubview:self.avatarView];
    
}

- (void)loadTitleHolderView
{
    _nickHolderView = [[UIView alloc]init];
    [self.contentView addSubview:_nickHolderView];

    [self loadThanksButton];
    [self loadNickLabel];
}

- (void)loadThanksButton
{
    self.thanksButton = [[UIButton alloc]init];
    [_nickHolderView addSubview:self.thanksButton];
    [self.thanksButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"worry_detail_thanks"];
    [self.thanksButton setBackgroundImage:image forState:UIControlStateNormal];
    self.thanksButton.titleLabel.font = [UIFont systemFontOfSize:5];


}

- (void)loadNickLabel
{
    self.nickLabel = [[UILabel alloc]init];
    [_nickHolderView addSubview:self.nickLabel];
}


- (void)loadShortTextLabel
{
    self.shortTextLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.shortTextLabel];
    self.shortTextLabel.numberOfLines = 0;
    self.shortTextLabel.textColor = kLabelBlackColor;
    self.shortTextLabel.font = kMiddleLabelFont;
}


@end
