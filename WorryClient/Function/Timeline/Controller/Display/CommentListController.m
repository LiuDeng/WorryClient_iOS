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
    [self.tableView registerClass:[WorryAnswerCell class] forCellReuseIdentifier:kCommentCell];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.tableView registerClass:[WorryAnswerCell class] forCellReuseIdentifier:kCommentCell];
//    //  根据pbComment.text内容多少改变高度
//    WorryAnswerCell *cell = (WorryAnswerCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //  447换成width
//    return 30 + [cell.shortTextLabel suggestedSizeForWidth:447].height;
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
    return 100;
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorryAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCell forIndexPath:indexPath];
    PBComment *pbComment = self.pbComments[indexPath.row];
    
    PBUser *pbUser = pbComment.createdUser;
    
    [cell.avatarView setAvatarWithPBUser:pbUser];
    [cell.avatarView addTapGestureWithClickType:AvatarViewClickTypeUserInfo];
//
//    NSString *text = [NSString stringWithFormat:@"%@\n\n",pbComment.text];   //  加2个"\n"的目的是，为了让文字置顶
   NSString *text = @"其主要出发点就是我有一个label，然后我要把这个label展示出来，我根据字体的大小还有行数来获取一个高度，这样cell的高度就有啦。其主要出发点就是我有一个label，然后我要把这个label展示出来，我根据字体的大小还有行数来获取一个高度，这样cell的高度就有啦。";
    cell.shortTextLabel.text = text;
    cell.nickLabel.text = pbUser.nick;
    cell.thanksButton.hidden = YES;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCell];
//    cell = [[WorryAnswerCell alloc] initWithFrame:CGRectZero];
//    CGRect cellFrame = [cell frame];
////    cellFrame.origin = CGPointMake(0, 0);
//    
////    CGFloat totalHeight = [cell.shortTextLabel suggestedSizeForWidth:self.view.bounds.size.width].height;
////    cellFrame.size.height = totalHeight+30;
//    cellFrame.size.height = 100;
//    [cell setFrame:cellFrame];
//    
    return cell;
}

#pragma mark - Utils

- (void)addComment
{
    CommentController *vc = [[CommentController alloc]initWithPBFeed:self.pbFeed];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
