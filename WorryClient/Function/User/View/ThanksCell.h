//
//  ThanksCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"

@interface ThanksCell : UITableViewCell

@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,strong) UILabel *answerLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@end
