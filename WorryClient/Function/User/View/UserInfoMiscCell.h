//
//  UserInfoMiscCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/7.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoMiscCell : UITableViewCell
{
    CGFloat _count;
    NSMutableArray *_btns;
}

@property (nonatomic,strong) UIButton *herFollowingsBtn; //  关注
@property (nonatomic,strong) UIButton *herFollowersBtn; //  粉丝
@property (nonatomic,strong) UIButton *thankNumBtn;
@property (nonatomic,strong) UIButton *agreeNumBtn;

@end
