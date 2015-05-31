//
//  CommonCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/30.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonCell : UITableViewCell

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *descriptionLabel; //  description the notification detailly.
@property (nonatomic,strong) UILabel *additionalLabel;

@end
