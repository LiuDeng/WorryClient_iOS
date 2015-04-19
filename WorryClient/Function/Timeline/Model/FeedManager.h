//
//  FeedManager.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
#import "CommonManager.h"
#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "Feed.pb.h"
#import "FMDB.h"

@interface FeedManager : CommonManager
{
    FMDatabase *_db;
    NSArray *_pbFeedArray;
    NSString *_dbPath;
}

DEFINE_SINGLETON_FOR_CLASS(FeedManager)
- (void)deleteOldDatabase;
- (void)storeFeed:(PBFeed *)pbFeed;
- (void)storePBFeedDataArray:(NSArray *)pbFeedDataArray;
- (NSArray *)pbFeedArray;

@end
