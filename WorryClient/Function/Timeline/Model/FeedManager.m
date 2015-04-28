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
//    if (_pbFeedArray == nil) {
        _pbFeedArray = [self readFeedListFromCache];
//    }
    return _pbFeedArray;
}
- (void)storeFeed:(PBFeed *)pbFeed
{
    NSData *pbFeedData = [pbFeed data];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@) VALUES (?,?)",kFeedTable,kFeedTableFieldId,kFeedTableFieldFeed];
    [_db executeUpdate:sql, pbFeed.feedId,pbFeedData];
}

- (void)storePBFeedDataArray:(NSArray *)pbFeedDataArray
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
     NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@) VALUES (?,?)",kFeedTable,kFeedTableFieldId,kFeedTableFieldFeed];
    
    [queue inDatabase:^(FMDatabase *db) {
        for (NSData *pbFeedData in pbFeedDataArray) {
            PBFeed *pbFeed = [PBFeed parseFromData:pbFeedData];
            NSString *querySql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = %@",kFeedTable,kFeedTableFieldId,pbFeed.feedId];
            if ([db executeQuery:querySql] == nil) {
                [db executeUpdate:sql,pbFeed.feedId,pbFeedData];
            }
//            [db executeUpdate:sql,pbFeed.feedId,pbFeedData];
        }
    }];
}

- (NSArray *)readFeedListFromCache
{
    NSMutableArray *feedArray = [[NSMutableArray alloc]init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",kFeedTable];
    FMResultSet *rs = [_db executeQuery:sql];
    while (rs.next) {
        [feedArray insertObject:[rs dataForColumn:kFeedTableFieldFeed] atIndex:0];
    }
    return feedArray;
}

- (void)deleteOldDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:_dbPath error:nil];
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

- (void)dealloc
{
    [_db close];
}
- (void)dropTable
{
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@",kFeedTable];
    [_db executeUpdate:sql];
}
@end
