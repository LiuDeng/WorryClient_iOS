//
//  WorryAnswerCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/2.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarView.h"

#define kTitleHolderViewHeight 25

@interface WorryAnswerCell : UITableViewCell
{
    UIView *_titleHolderView;    
}
@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UIButton *thanksButton;
@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UILabel *shortTextLabel;

@end
