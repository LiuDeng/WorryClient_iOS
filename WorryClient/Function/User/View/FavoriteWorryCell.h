//
//  FavoriteWorryCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/28.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  心结

#import <UIKit/UIKit.h>

@interface FavoriteWorryCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *answerLabel;
@property (nonatomic,strong) UILabel *thanksLabel;  //  暂时隐藏
@property (nonatomic,strong) UILabel *commentLabel; //  暂时隐藏

@end
