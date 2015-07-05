//
//  FeedService+Answer.m
//  WorryClient
//
//  Created by 蔡少武 on 15/7/4.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedService+Answer.h"

#define kForAnswer  @"forAnswer"
#define kFromUser   @"fromUser"
#define kToUser     @"toUser"

@implementation FeedService (Answer)

- (void)addAnswerForFeed:(NSString *)feedId
                    text:(NSString *)text
             isAnonymous:(BOOL)isAnonymous
                   block:(ServiceErrorResultBlock)block
{
    AVObject *feed = [AVObject objectWithoutDataWithClassName:kFeedClassName objectId:feedId];
    AVObject *answer = [AVObject objectWithClassName:kAnswerClassName];
    AVUser *avCurrentUser = [AVUser currentUser];
    [answer setObject:avCurrentUser forKey:kCreatedUser];
    [answer setObject:text forKey:kText];
    [answer setObject:feed forKey:kCreatedFor];
    
    NSNumber *anonymous = [NSNumber numberWithBool:isAnonymous];
    [answer setObject:anonymous forKey:kIsAnonymous];
    [answer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //  TODO if succeeded,tell the created user of feed
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)thankAnswer:(PBAnswer *)pbAnswer
              block:(ServiceErrorResultBlock)block
{
    AVObject *answer = [AVObject objectWithoutDataWithClassName:kAnswerClassName objectId:pbAnswer.answerId];
    AVObject *thanks = [AVObject objectWithClassName:kThanksClassName];
    
    [thanks setObject:answer forKey:kForAnswer];
    
    [thanks saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
    
}

- (void)getMyPBThanksArray:(ServiceArrayResultBlock)block
{
    AVQuery *query = [AVQuery queryWithClassName:kThanksClassName];
    
    NSMutableArray *pbThanksArray = [[NSMutableArray alloc]init];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //  objects->object
        for (AVObject *object in objects) {
            //  object->pbObject
            PBThanks *pbThanks = [self pbThanksWithThanks:object];
            //  pbThanksArray add pbObject
            [pbThanksArray addObject:pbThanks];
        }
        
    }];
}

#pragma mark - Get comments

- (void)getPBAnswersFromFeed:(NSString *)feedId block:(ServiceArrayResultBlock)block
{
    AVQuery *query = [AVQuery queryWithClassName:kAnswerClassName];
    AVObject *feed = [AVObject objectWithoutDataWithClassName:kFeedClassName objectId:feedId];
    [query whereKey:kCreatedFor equalTo:feed];
    
    NSMutableArray *pbAnswers = [[NSMutableArray alloc]init];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //  object from objects
        for (AVObject *object in objects) {
            //  pbComment from object
            PBAnswer *pbAnswer = [self pbAnswerWithAnswer:object];
            //  pbComments add pbComment
            [pbAnswers addObject:pbAnswer];
        }
        EXECUTE_BLOCK(block,pbAnswers,error);
    }];
    
}

#pragma mark - Utils

/*
 *  @param answer An AVObject with kCommentClassName
 *  @return pbAnswer The pbComment with the base info:??
 */
- (PBAnswer *)pbAnswerWithAnswer:(AVObject *)answer
{
    NSString *text = [answer objectForKey:kText];
    AVUser *createdUser = [answer objectForKey:kCreatedUser];
    //  pbUser from avUser,but only get the base info:objectId,avatar,nick
    PBUser *pbUser = [[UserService sharedInstance]simplePBUserWithUser:createdUser];
    
    NSNumber *isAnonymousNum = [answer objectForKey:kIsAnonymous];
    BOOL isAnonymous = [isAnonymousNum boolValue];
    
    SInt32 updateAt = [answer.updatedAt timeIntervalSince1970];
    SInt32 createdAt = [answer.createdAt timeIntervalSince1970];
    
    PBAnswerBuilder *builder = [PBAnswer builder];
    builder.answerId = answer.objectId;
    builder.text = text;
    builder.isAnonymous = isAnonymous;
    builder.createdUser = pbUser;
    builder.updatedAt = updateAt;
    builder.createdAt = createdAt;
    
    return [builder build];
}

/*
 @param answer AVObject
 @return PBAnswer with base info:objectId,text
 */

- (PBAnswer *)simplePBAnswerWithAnswer:(AVObject *)answer
{
    NSString *text = [answer objectForKey:kText];

    PBAnswerBuilder *builder = [PBAnswer builder];
    builder.answerId = answer.objectId;
    builder.text = text;
    return [builder build];
}

- (PBThanks *)pbThanksWithThanks:(AVObject *)thanks
{
    int createdAt = [thanks.createdAt timeIntervalSince1970];

    AVUser *fromUser = [thanks objectForKey:kFromUser];
    AVUser *toUser = [thanks objectForKey:kToUser];
    //  get simple pbUser with base info:objectId,nick,avatar
    PBUser *fromPBUser = [[UserService sharedInstance]simplePBUserWithUser:fromUser];
    PBUser *toPBUser = [[UserService sharedInstance]simplePBUserWithUser:toUser];
    
    AVObject *answer = [thanks objectForKey:kCreatedFor];
    //  get simple pbAnswer with base info:objectId,text
    PBAnswer *forAnswer = [self simplePBAnswerWithAnswer:answer];
    
    PBThanksBuilder *builder = [PBThanks builder];
    builder.thanksId = thanks.objectId;
    builder.fromUser = fromPBUser;
    builder.toUser = toPBUser;
    builder.createdAt = createdAt;
    builder.forAnswer = forAnswer;
    
    return [builder build];
}



@end
