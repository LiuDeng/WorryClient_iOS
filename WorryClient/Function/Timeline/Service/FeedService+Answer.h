//
//  FeedService+Answer.h
//  WorryClient
//
//  Created by 蔡少武 on 15/7/4.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  代码命名，因为有一段时间追求简洁，使得命名很不规范，不作修改了，接下来的，会尽量往规范上靠 --2015/8/2

#import "FeedService.h"

#define kAnswerClassName    @"Answer"
#define kThanksClassName    @"Thanks"

@interface FeedService (Answer)

- (void)addAnswerForFeed:(NSString *)feedId
                    text:(NSString *)text
             isAnonymous:(BOOL)isAnonymous
                   block:(ServiceErrorResultBlock)block;
- (void)getPBAnswersFromFeed:(NSString *)feedId
                       block:(ServiceArrayResultBlock)block;
- (void)getPBAnswersFromPBUser:(NSString *)pbUserId
                       block:(ServiceArrayResultBlock)block;
- (void)thankAnswer:(PBAnswer *)pbAnswer
              block:(ServiceErrorResultBlock)block;
//- (void)getMyPBAnswersWithBlock:(ServiceArrayResultBlock)block;

- (PBAnswer *)simplePBAnswerWithAnswer:(AVObject *)answer;
- (void)getUser:(NSString *)userId favoriteAnswers:(ServiceArrayResultBlock)block;
- (void)getUser:(NSString *)userId pbThanksArray:(ServiceArrayResultBlock)block;
@end
