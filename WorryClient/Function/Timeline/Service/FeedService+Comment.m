//
//  FeedService+Comment.m
//  WorryClient
//
//  Created by 蔡少武 on 15/7/2.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedService+Comment.h"

#define kReply          @"reply"
#define kCreatedFor     @"createdFor"

typedef void (^TypeBlock) (AVObject *comment);

@implementation FeedService (Comment)

- (void)createCommentWithText:(NSString *)text
                  isAnonymous:(BOOL)isAnonymous
                    typeBlock:(TypeBlock)typeBlock
                        block:(ServiceErrorResultBlock)block
{
    AVObject *comment = [AVObject objectWithClassName:kCommentClassName];
    
    typeBlock(comment);
    
    [comment setObject:text forKey:kText];
    AVUser *avCurrentUser = [AVUser currentUser];
    [comment setObject:avCurrentUser forKey:kCreatedUser];
    [comment setObject:text forKey:kText];

    NSNumber *anonymous = [NSNumber numberWithBool:isAnonymous];
    [comment setObject:anonymous forKey:kIsAnonymous];
    [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)addCommentForFeed:(NSString *)feedId
                     text:(NSString *)text
              isAnonymous:(BOOL)isAnonymous
                    block:(ServiceErrorResultBlock)block
{
    AVObject *feed = [AVObject objectWithoutDataWithClassName:kFeedClassName objectId:feedId];
    [self createCommentWithText:text isAnonymous:isAnonymous typeBlock:^(AVObject *comment) {
        NSNumber *typeNum = [NSNumber numberWithInt:PBCommentTypeToFeed];
        [comment setObject:typeNum forKey:kType];
        [comment setObject:feed forKey:kCreatedFor];
    } block:block];
}

- (void)addCommentForAnswer:(NSString *)answerId
                       text:(NSString *)text
                isAnonymous:(BOOL)isAnonymous
                      block:(ServiceErrorResultBlock)block
{
//    AVObject *feed = [AVObject objectWithoutDataWithClassName:kFeedClassName objectId:feedId];    //  answer
    [self createCommentWithText:text isAnonymous:isAnonymous typeBlock:^(AVObject *comment) {
//        NSNumber *typeNum = [NSNumber numberWithInt:type];
//        [comment setObject:typeNum forKey:kType];
//        [feed setObject:comment forKey:kComment];
    } block:block];
}

#pragma mark - Get comments

- (NSArray *)pbCommentsFromFeed:(NSString *)feedId
{
    AVQuery *query = [AVQuery queryWithClassName:kCommentClassName];
    AVObject *feed = [AVObject objectWithoutDataWithClassName:kFeedClassName objectId:feedId];
    [query whereKey:kCreatedFor equalTo:feed];
    
    NSMutableArray *pbComments = [[NSMutableArray alloc]init];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //  object from objects
        for (AVObject *object in objects) {
            //  pbComment from object
            PBComment *pbComment = [self pbCommentWithComment:object];
            //  pbComments add pbComment
            [pbComments addObject:pbComment];
        }
    }];
    
    return pbComments;
}

#pragma mark - Utils

/*
 *  @param comment An AVObject with kCommentClassName
 *  @return pbComment The pbComment with the base info:??
 */
- (PBComment *)pbCommentWithComment:(AVObject *)comment
{
    NSString *text = [comment objectForKey:kText];
    NSNumber *typeNum = [comment objectForKey:kType];
    int type = [typeNum intValue];
    AVUser *cretedUser = [comment objectForKey:kCreatedUser];
    //  pbUser from avUser,but only get the base info:avatar,nick
    
    NSNumber *isAnonymousNum = [comment objectForKey:kIsAnonymous];
    BOOL isAnonymous = [isAnonymousNum boolValue];
    
    
    PBCommentBuilder *builder = [PBComment builder];
    builder.commentId = comment.objectId;
    builder.text = text;
//    builder.type = type;
    builder.isAnonymous = isAnonymous;
    
    
    
    return [builder build];
}


@end
