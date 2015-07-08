//
//  FeedService+Comment.h
//  WorryClient
//
//  Created by 蔡少武 on 15/7/2.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedService.h"

#define kCommentClassName   @"Comment"


@interface FeedService (Comment)

- (void)addCommentForFeed:(NSString *)feedId
                     text:(NSString *)text
              isAnonymous:(BOOL)isAnonymous
                    block:(ServiceErrorResultBlock)block;

- (void)addCommentForAnswer:(NSString *)answerId
                       text:(NSString *)text
                isAnonymous:(BOOL)isAnonymous
                      block:(ServiceErrorResultBlock)block;

- (NSArray *)pbCommentsFromFeed:(NSString *)feedId;
- (void)getPBCommentsFromFeed:(NSString *)feedId block:(ServiceArrayResultBlock)block;

@end
