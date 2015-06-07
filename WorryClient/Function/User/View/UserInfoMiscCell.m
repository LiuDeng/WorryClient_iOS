//
//  UserInfoMiscCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/7.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserInfoMiscCell.h"
#import "ViewDefault.h"

@implementation UserInfoMiscCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *imageNames = @[@"",@"",@"user_info_thanks",@"user_info_agree"];
        _count = imageNames.count;
        
        _btns = [[NSMutableArray alloc]init];
        for (int i = 0; i<_count; i++) {
            UIImage *image = [UIImage imageNamed:[imageNames objectAtIndex:i]];
            UIButton *button = [[UIButton alloc]init];
            [self.contentView addSubview:button];
            [button setImage:image forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [_btns addObject:button];
        }
        
        self.herFollowingsBtn = [_btns objectAtIndex:0];
        self.herFollowersBtn = [_btns objectAtIndex:1];
        self.thankNumBtn = [_btns objectAtIndex:2];
        self.agreeNumBtn = [_btns objectAtIndex:3];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0;i<_count;i++) {
        UIButton *button = (UIButton *)[_btns objectAtIndex:i];
        CGFloat scale = (2*i+1)/_count;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView).with.multipliedBy(scale);
        }];

    }}

@end
