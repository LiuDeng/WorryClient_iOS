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
    CGFloat padding = 5;
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAvatarWidth));
        make.height.equalTo(@(kAvatarWidth));
        make.top.equalTo(self.contentView).with.offset(+padding);
        make.left.equalTo(self.contentView).with.offset(+padding);
    }];
    
    [_titleHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.left.equalTo(self.avatarView.mas_right).with.offset(+padding);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@kTitleHolderViewHeight);
    }];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView);
        make.left.equalTo(_titleHolderView);
    }];
    
    [self.thanksButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_bottom).with.offset(+padding);
        make.centerX.equalTo(self.avatarView);
    }];
    
    [self.shortTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-padding);
        make.top.equalTo(_titleHolderView.mas_bottom);//.with.offset(+padding);
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.avatarView.mas_right).with.offset(+padding);
    }];
}

#pragma mark - Private methods

- (void)loadView
{
    self.contentView.layer.borderColor = [kLayerColor CGColor];
    self.contentView.layer.borderWidth = 0.5;
    [self loadAvatarView];
    [self loadTitleHolderView];
    [self loadThanksButton];
    [self loadShortTextLabel];
}

- (void)loadAvatarView
{
    self.avatarView = [[AvatarView alloc]initWithBorderWidth:kLayerBorderWidth];
    [self.contentView addSubview:self.avatarView];
}

- (void)loadTitleHolderView
{
    _titleHolderView = [[UIView alloc]init];
    [self.contentView addSubview:_titleHolderView];

    [self loadNickLabel];
}

- (void)loadThanksButton
{
    self.thanksButton = [[UIButton alloc]init];
    [self.contentView addSubview:self.thanksButton];
    [self.thanksButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"thanks"];
    [self.thanksButton setBackgroundImage:image forState:UIControlStateNormal];
    self.thanksButton.titleLabel.font = [UIFont systemFontOfSize:8];
}

- (void)loadNickLabel
{
    self.nickLabel = [[UILabel alloc]init];
    [_titleHolderView addSubview:self.nickLabel];
}

- (void)loadShortTextLabel
{
    self.shortTextLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.shortTextLabel];
    self.shortTextLabel.numberOfLines = 0;
    self.shortTextLabel.textColor = kLabelBlackColor;
    self.shortTextLabel.font = kMiddleLabelFont;
    self.shortTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
}


@end
