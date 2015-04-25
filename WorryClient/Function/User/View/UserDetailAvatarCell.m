//
//  UserDetailAvatarCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserDetailAvatarCell.h"
#import "ViewDefault.h"

@implementation UserDetailAvatarCell

#pragma mark - Public methods

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat borderWidth = 1.0f;
        self.avatarView = [[AvatarView alloc]initWithBorderWidth:borderWidth];
        self.avatarView.imageView.image = [UIImage imageNamed:@"avatar01"];
        [self.contentView addSubview:self.avatarView];
    }
    return  self;
}

#pragma mark - Default methods

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
    
    CGFloat avatarViewHeightScale = 0.9;
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(avatarViewHeightScale);
        make.height.equalTo(self.contentView).with.multipliedBy(avatarViewHeightScale);
        make.right.equalTo(self.contentView).with.multipliedBy(0.95);
    }];
}

#pragma mark - Private methods

@end
