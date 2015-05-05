//
//  TopicManager.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonManager.h"
#import "FMDB.h"

@interface TopicManager : CommonManager
{
    FMDatabase *_db;
    NSArray *_pbTopicArray;
    NSString *_dbPath;
}

DEFINE_SINGLETON_FOR_CLASS(TopicManager)

- (NSArray *)pbTopicArray;
- (void)storePBTopicDataArray:(NSArray *)pbTopicDataArray;
- (void)deleteOldDatabase;
- (void)dropTable;
- (void)deleteCache;

@end
