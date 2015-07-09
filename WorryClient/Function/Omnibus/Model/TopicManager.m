//
//  TopicManager.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "TopicManager.h"
#import "WorryConfigManager.h"
#import "Topic.pb.h"
#import "UserService.h"

#define kTopicTable              @"kTopicTable"
#define kTopicTableFieldId       @"id"
#define kTopicTableFieldTopic    @"topic"

@implementation TopicManager

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(TopicManager)

- (id)init
{
    self = [super init];
    if (self) {
        NSString *userId = [[UserService sharedInstance]currentPBUser].userId;
        if (userId.length>0) {
            _dbPath = [NSString stringWithFormat:@"/tmp/%@_%@",kDBName,userId];   //  /tmp不能缺少
        }else{
            _dbPath = [NSString stringWithFormat:@"/tmp/%@_%@",kDBName,@"temp"];
        }
        
        _db = [FMDatabase databaseWithPath:_dbPath];
        [_db open];
        if (![_db tableExists:kTopicTable]) {
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ TEXT PRIMARY KEY,%@ BLOB);",kTopicTable,kTopicTableFieldId,kTopicTableFieldTopic];
            [_db executeStatements:sql];
        }
    }// if
    return self;
}

- (NSArray *)pbTopicArray
{
    _pbTopicArray = [self requireTopicArrayFromCache];
    return _pbTopicArray;
}

//- (void)storePBTopicDataArray:(NSArray *)pbTopicDataArray
//{
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
//    
//    NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ? where %@ = ?",kTopicTable,kTopicTableFieldTopic,kTopicTableFieldTopic];
//    
//    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@) VALUES (?,?)",kTopicTable,kTopicTableFieldId,kTopicTableFieldTopic];
//    [queue inDatabase:^(FMDatabase *db) {
//        for (NSData *pbTopicData in pbTopicDataArray) {
//            FMResultSet *results;
//            
//            PBTopic  *pbTopic = [PBTopic parseFromData:pbTopicData];
//            NSString *querySql;
//            if ([pbTopic hasTopicId]) {
//                querySql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",kTopicTable,kTopicTableFieldId,pbTopic.topicId];
//                results = [db executeQuery:querySql];
//                if ( results.next) {
//                    [db executeUpdate:updateSql,pbTopicData,pbTopic.topicId];
//                }else{
//                    [db executeUpdate:insertSql,pbTopic.topicId,pbTopicData];
//                }
//            }
//            
//            [results close];
//        }
//    }];
//    
//}

- (void)storePBTopicDataArray:(NSArray *)pbTopicDataArray
{
    [self deleteCache];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
    
    
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@) VALUES (?,?)",kTopicTable,kTopicTableFieldId,kTopicTableFieldTopic];
    [queue inDatabase:^(FMDatabase *db) {
        for (NSData *pbTopicData in pbTopicDataArray) {
            FMResultSet *results;
            
            PBTopic  *pbTopic = [PBTopic parseFromData:pbTopicData];
//            NSString *querySql;
//            if ([pbTopic hasTopicId]) {
//                querySql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",kTopicTable,kTopicTableFieldId,pbTopic.topicId];
//                results = [db executeQuery:querySql];
//                if ( results.next) {
//                    [db executeUpdate:updateSql,pbTopicData,pbTopic.topicId];
//                }else{
//                    [db executeUpdate:insertSql,pbTopic.topicId,pbTopicData];
//                }
//            }
            [db executeUpdate:insertSql,pbTopic.topicId,pbTopicData];
            [results close];
        }
    }];
    
}


- (void)storePBTopicData:(NSData *)pbTopicData
{
    PBTopic *pbTopic = [PBTopic parseFromData:pbTopicData];
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ? where %@ = ?",kTopicTable,kTopicTableFieldTopic,kTopicTableFieldTopic];
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@) VALUES (?,?)",kTopicTable,kTopicTableFieldId,kTopicTableFieldTopic];
    NSString *selectSql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",kTopicTable,kTopicTableFieldId,pbTopic.topicId];
    
    if ([pbTopic hasTopicId]) {
        FMResultSet *results = [_db executeQuery:selectSql];
        if (results.next) {
            [_db executeUpdate:updateSql,pbTopicData,pbTopic.topicId];
        }else{
            [_db executeUpdate:insertSql,pbTopic.topicId,pbTopicData];
        }
        [results close];
    }
}

- (void)deleteOldDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:_dbPath error:nil];
}


- (void)dealloc
{
    [_db close];
}
- (void)dropTable
{
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@",kTopicTable];
    [_db executeUpdate:sql];
}

- (void)deleteCache
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",kTopicTable];
    [_db executeUpdate:sql];
}
#pragma mark - Private methods

- (NSArray *)requireTopicArrayFromCache
{
    NSMutableArray *topicArray = [[NSMutableArray alloc]init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",kTopicTable];
    FMResultSet *rs = [_db executeQuery:sql];
    while (rs.next) {
        NSData *data = [rs dataForColumn:kTopicTableFieldTopic];
        PBTopic *pbTopic = [PBTopic parseFromData:data];
        [topicArray insertObject:pbTopic atIndex:0];
    }
    [rs close];
    return topicArray;
}

@end
