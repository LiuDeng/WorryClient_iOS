//
//  TimelineCell.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/17.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TimelineCellBlock) ();

@interface TimelineCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *shortTextLabel;
@property (nonatomic,strong) UIButton *topicButton;
/**
 *  if PBFeedType is PBFeedWorry,replyButton stands for answer,
 *  if PBFeedType is PBFeedStory,replyButton stands for comment.
 */
@property (nonatomic,strong) UIButton *replyButton;
@property (nonatomic,strong) UIButton *blessingButton;
//@property (nonatomic,strong) TimelineCellBlock clickTopicButtonBlock;
//@property (nonatomic,strong) TimelineCellBlock clickCommentButtonBlock;
//@property (nonatomic,strong) TimelineCellBlock clickBlessingButtonBlock;

@end
