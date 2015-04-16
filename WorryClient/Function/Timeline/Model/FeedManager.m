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
//    NSArray *feedArray = [_db re];
    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@",kFeedTable];
    FMResultSet *rs = [_db executeQuery:sql];
    if (rs.next) {
        NSLog(@"%d",[rs intForColumnIndex:0]);
    }
    return nil;
}
@end
