//
//  FeedService+Answer.h
//  WorryClient
//
//  Created by 蔡少武 on 15/7/4.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

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
//- (void)getMyPBAnswersWithBlock:(ServiceArrayResultBlock)block;

- (PBAnswer *)simplePBAnswerWithAnswer:(AVObject *)answer;
- (void)getUser:(NSString *)userId favoriteAnswers:(ServiceArrayResultBlock)block;
- (void)getUser:(NSString *)userId pbThanksArray:(ServiceArrayResultBlock)block;
@end
