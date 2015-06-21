//
//  FeedManager.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
#import "CommonManager.h"
#import "Feed.pb.h"
#import "FMDB.h"

@class PBTopic;

@interface FeedManager : CommonManager
{
    FMDatabase *_db;
    NSArray *_pbFeedArray;
    NSString *_dbPath;
}

DEFINE_SINGLETON_FOR_CLASS(FeedManager)

- (void)storePBFeedDataArray:(NSArray *)pbFeedDataArray;
- (void)storePBFeedArray:(NSArray *)pbFeedArray;
- (NSArray *)pbFeedArray;
- (NSArray *)pbFeedArrayWithPBTopic:(PBTopic *)pbTopic;
- (void)deleteOldDatabase;
- (void)dropTable;
- (void)deleteCache;

#ifdef DEBUG
- (NSArray *)testFeedArray;
#endif

@end
