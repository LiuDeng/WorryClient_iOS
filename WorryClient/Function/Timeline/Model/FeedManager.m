//
//  FeedManager.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedManager.h"
#import "UserManager.h"
#import "WorryConfigManager.h"
#import "Topic.pb.h"

#define kFeedTable              @"kFeedTable"
#define kFeedTableFieldId       @"id"
#define kFeedTableFieldFeed     @"feed"

@implementation FeedManager

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(FeedManager)

- (id)init
{
    self = [super init];
    if (self) {
        NSString *userId = [[UserManager sharedInstance]pbUser].userId;
        if (userId.length>0) {
            _dbPath = [NSString stringWithFormat:@"/tmp/%@_%@",kDBName,userId];   //  /tmp不能缺少
        }else{
            _dbPath = [NSString stringWithFormat:@"/tmp/%@_%@",kDBName,@"temp"];
        }

        _db = [FMDatabase databaseWithPath:_dbPath];
        [_db open];
        if (![_db tableExists:kFeedTable]) {
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ TEXT PRIMARY KEY,%@ BLOB);",kFeedTable,kFeedTableFieldId,kFeedTableFieldFeed];
            [_db executeStatements:sql];
        }
    }// if
    return self;
}

- (NSArray *)pbFeedArray
{
    _pbFeedArray = [self requireFeedArrayFromCache];
    return _pbFeedArray;
}

- (NSArray *)pbFeedArrayWithPBTopic:(PBTopic *)pbTopic
{
    NSMutableArray *pbFeedArray = [[NSMutableArray alloc]init];
    NSUInteger dataCount = pbTopic.feedId.count > kFeedDataCount ? kFeedDataCount : pbTopic.feedId.count;
    for (int i = 0 ;i < dataCount; i++) {
        NSString *pbFeedId = [pbTopic.feedId objectAtIndex:i];
        PBFeed *pbFeed = [self pbFeedWithPBFeedId:pbFeedId];
        [pbFeedArray addObject:pbFeed];
    }
    return pbFeedArray;
}

- (void)storePBFeedDataArray:(NSArray *)pbFeedDataArray
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
    
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ? where %@ = ?",kFeedTable,kFeedTableFieldFeed,kFeedTableFieldFeed];

    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@) VALUES (?,?)",kFeedTable,kFeedTableFieldId,kFeedTableFieldFeed];
    [queue inDatabase:^(FMDatabase *db) {
        for (NSData *pbFeedData in pbFeedDataArray) {
            FMResultSet *results;
            
            PBFeed *pbFeed = [PBFeed parseFromData:pbFeedData];
            NSString *querySql;
            if ([pbFeed hasFeedId]) {
                querySql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",kFeedTable,kFeedTableFieldId,pbFeed.feedId];
                results = [db executeQuery:querySql];
                if ( results.next) {
                    [db executeUpdate:updateSql,pbFeedData,pbFeed.feedId];
                }else{
                    [db executeUpdate:insertSql,pbFeed.feedId,pbFeedData];
                }
            }
            [results close];
        }
    }];
    
}

- (void)deleteOldDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:_dbPath error:nil];
}

- (void)dropTable
{
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@",kFeedTable];
    [_db executeUpdate:sql];
}

- (void)deleteCache
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FORM %@",kFeedTable];
    [_db executeUpdate:sql];
}

#pragma mark - Private methods

- (NSArray *)requireFeedArrayFromCache
{
    NSMutableArray *feedArray = [[NSMutableArray alloc]init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",kFeedTable];
    FMResultSet *rs = [_db executeQuery:sql];
    while (rs.next) {
        NSData *data = [rs dataForColumn:kFeedTableFieldFeed];
        PBFeed *pbFeed = [PBFeed parseFromData:data];
        [feedArray insertObject:pbFeed atIndex:0];
    }
    [rs close];
    return feedArray;
}

- (void)test
{
    PBFeedBuilder *pbFeedBuilder = [PBFeed builder];
    [pbFeedBuilder setTitle:@"title"];
    [pbFeedBuilder setFeedId:@"2"];
    PBFeed *pbFeed = [pbFeedBuilder build];
    NSData *data = [pbFeed data];
    
    //    NSString *sql = [NSString stringWithFormat:@"insert into %@ (id,feed) values ('%@',%@);",kFeedTable,pbFeed.feedId,data];
    //    [_db executeStatements:sql];
    //    [_db executeUpdate:@"insert into kFeedTable (id,feed) values (?,?)",pbFeed.feedId,data];
    
    //    NSString *executeStr = [NSString stringWithFormat:@"insert into %@ (id,feed) values (?,?)",kFeedTable];
    //    [_db executeUpdate:executeStr, pbFeed.feedId,data];
    [_db executeUpdate:@"insert into kFeedTable (id,feed) values (?,?)",pbFeed.feedId,data];
    
    NSString *sqlSet = [NSString stringWithFormat:@"select * from %@",kFeedTable];
    FMResultSet *rs = [_db executeQuery:sqlSet];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    int i = 0;
    while (rs.next) {
        
        
        [array addObject:[rs dataForColumn:@"feed"]];
        NSData *data2 = [array objectAtIndex:i];
        JDDebug(@"%@",data);
        JDDebug(@"%@",data2);
        PBFeed *pb = [PBFeed parseFromData:data2];
        JDDebug(@"id %@,title %@",pb.feedId,pb.title);
        
        i++;
    }
    
    
}


#pragma mark - Utils

- (PBFeed *)pbFeedWithPBFeedId:(NSString *)pbFeedId
{
    NSString *querySql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",kFeedTable,kFeedTableFieldId,pbFeedId];
    FMResultSet *results;
    
    results = [_db executeQuery:querySql];
    PBFeed *pbFeed;
    if (results.next) {
        NSData *data = [results dataForColumn:kFeedTableFieldFeed];
        pbFeed = [PBFeed parseFromData:data];
    }
    
    [results close];
    return pbFeed;
}

- (NSArray *)testFeedArray
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    return array;
}

@end
