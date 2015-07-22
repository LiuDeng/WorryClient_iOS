//
//  CommentListController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/7/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommentListController.h"
#import "CommentController.h"
#import "WorryAnswerCell.h"
#import "UILabel+SuggestSize.h"

#define kCommentCell    @"commentCell"

@interface CommentListController ()

@property (nonatomic,strong) PBFeed *pbFeed;
@property (nonatomic,strong) NSArray *pbComments;
@end

@implementation CommentListController

#pragma mark - Public methods

- (instancetype)initWithPBFeed:(PBFeed *)pbFeed
{
    self = [super init];
    if (self) {
        self.pbFeed = pbFeed;
    }
    return self;
}

#pragma mark - Default methods

- (void)loadView
{
    [super loadView];
    [self addRightButtonWithTitle:@"写评论" target:self action:@selector(addComment)];
}

- (void)loadTableView
{
    [super loadTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pbComments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  动态高度
    WorryAnswerCell *cell = (WorryAnswerCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGFloat width = CGRectGetWidth(self.view.frame)-kAvatarWidth-15;    //  15是WorryAnswerCell里面的padding*3
    NSDictionary *attrbute = @{NSFontAttributeName:kMiddleLabelFont};
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:cell.shortTextLabel.text attributes:attrbute];
    CGFloat height = [cell.shortTextLabel suggestSizeForAttributedString:attributeStr width:width].height;
    return kTitleHolderViewHeight+height;
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorryAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCell];
    if (cell==nil) {
        cell = [[WorryAnswerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCommentCell];
    }
    PBComment *pbComment = self.pbComments[indexPath.row];
    
    PBUser *pbUser = pbComment.createdUser;
    
    [cell.avatarView setAvatarWithPBUser:pbUser];
    [cell.avatarView addTapGestureWithClickType:AvatarViewClickTypeUserInfo];
    NSString *text = [NSString stringWithFormat:@"%@\n",pbComment.text];   //  加"\n"的目的是，动态计算高度时，多一行，会好一点。
    cell.shortTextLabel.text = text;
    cell.nickLabel.text = pbUser.nick;
    cell.thanksButton.hidden = YES;
    return cell;
}

#pragma mark - Utils

- (void)addComment
{
    CommentController *vc = [[CommentController alloc]initWithPBFeed:self.pbFeed];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
