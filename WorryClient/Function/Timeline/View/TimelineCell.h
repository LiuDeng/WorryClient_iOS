//
//  TimelineCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/17.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *shortTextLabel;
@property (nonatomic,strong) UILabel *topicLabel;
@property (nonatomic,strong) UIImageView *commentImageView;
@property (nonatomic,strong) UILabel *commentNumLabel;
@property (nonatomic,strong) UIImageView *blessingImageView;
@property (nonatomic,strong) UILabel *blessingNumLabel;
@end
