//
//  FeedManager.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedManager.h"

#import "UserManager.h"

#define kFeedDatakey @"kFeedDatakey"
#define kFeedDBKey      @"kFeedDBKey"
#define kFeedTable  @"kFeedTable"

@implementation FeedManager

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(FeedManager)

- (id)init
{
    self = [super init];
    if (self) {
        NSString *userName = [[UserManager sharedInstance]pbUser].userName;
        NSString *dbPath = [NSString stringWithFormat:@"/tmp/%@_%@",kFeedDatakey,userName];
        
        // delete the old db.
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:dbPath error:nil];
        
        _db = [FMDatabase databaseWithPath:dbPath];
        if ([_db open]) {
            NSString *sql = [NSString stringWithFormat:@"create table %@ (id text primary key,feed blob);",kFeedTable];
            BOOL *isSeccess = [_db executeStatements:sql];  //  TODO
        }

    
    }
    return self;
}

- (NSArray *)pbFeedArray
{
    if (_pbFeedArray == nil) {
        _pbFeedArray = [self readFeedListFromCache];
    }
    return _pbFeedArray;
}
- (void)storeFeed:(PBFeed *)pbFeed
{
//    SELECT typeof(t), typeof(nu), typeof(i), typeof(r), typeof(no) FROM t1;
//    newItem.picData = [rs dataForColumn:@"photo"];
    
//    USER_DEFAULTS_SET(kFeedDatakey, pbFeedData);INSERT INTO myTable VALUES (%d)
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (id,feed) values ('%@','%@');",kFeedTable,pbFeed.feedId,pbFeed];
//    if ([_db open]) {
//        [_db executeUpdateWithFormat:@"insert into %@ values ('%@',%@);",kFeedTable,pbFeed.feedId,pbFeed];
    [_db executeUpdate:sql];
//    }
}

- (NSArray *)readFeedListFromCache
{
    NSMutableArray *feedArray = [[NSMutableArray alloc]init];
    NSString *sql = [NSString stringWithFormat:@"select * from %@",kFeedTable];
    FMResultSet *rs = [_db executeQuery:sql];
    if (rs.next) {
        for (int i = 0; i<rs.columnCount; i++) {
            [feedArray addObject:[rs dataForColumnIndex:i]];
        }
    }
    return feedArray;
}
@end
