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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_nickHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.width.equalTo(self.contentView).with.multipliedBy(0.9);
        make.top.equalTo(self.contentView);
        make.height.equalTo(self.contentView).with.multipliedBy(0.3);
    }];
    
    [self.thanksButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nickHolderView);
        make.centerY.equalTo(_nickHolderView);
    }];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nickHolderView);
        make.left.equalTo(self.thanksButton.mas_right);
        make.right.equalTo(_nickHolderView);
    }];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.contentView).with.multipliedBy(0.38);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(0.38);
        make.top.equalTo(self.contentView.mas_bottom).with.multipliedBy(0.1);
        make.left.equalTo(self.contentView);
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
    self.contentView.layer.borderWidth = kLayerBorderWidth;
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
    [self.thanksButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"worry_detail_thanks"];
    [self.thanksButton setBackgroundImage:image forState:UIControlStateNormal];
    self.thanksButton.titleLabel.font = [UIFont systemFontOfSize:15];

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
    self.shortTextLabel.textColor = OPAQUE_COLOR(0x53, 0x53, 0x53);
    self.shortTextLabel.font = [UIFont systemFontOfSize:14];
}


@end