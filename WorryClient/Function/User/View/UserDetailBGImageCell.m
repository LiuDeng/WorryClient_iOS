//
//  UserDetailBGImageCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserDetailBGImageCell.h"
#import "Masonry.h"
#import "ViewDefault.h"

@implementation UserDetailBGImageCell

#pragma mark - Default methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadBGImageView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.BGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(kCellHeightScale);
        make.height.equalTo(self.contentView).with.multipliedBy(kCellHeightScale);
        make.right.equalTo(self.contentView).with.multipliedBy(kCellRightScale);
    }];
}

#pragma mark - Private methods

- (void)loadBGImageView
{
    self.BGImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.BGImageView];
    
}

@end
