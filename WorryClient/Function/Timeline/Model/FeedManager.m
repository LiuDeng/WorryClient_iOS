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
//    USER_DEFAULTS_SET(kFeedDatakey, pbFeedData);
//    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values ('%@');",kFeedTable,];
//    if ([_db open]) {
        [_db executeUpdateWithFormat:@"insert into %@ values ('%@','%@');",kFeedTable,pbFeed.feedId,pbFeed];
//    }
}

- (NSArray *)readFeedListFromCache
{
//    NSArray *feedArray = [_db re];

    FMResultSet *rs = [_db executeQueryWithFormat:@"select count(*) from %@",kFeedTable];
    if (rs.next) {
        JDDebug(@"%@",[rs intForColumnIndex:0]);
    }
    return nil;
}
@end
