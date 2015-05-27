//
//  NewsCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/26.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"

@interface NewsCell : UITableViewCell

@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UILabel *descriptionLabel; //  description the notification detailly.
@property (nonatomic,strong) UILabel *timeLabel;

@end
