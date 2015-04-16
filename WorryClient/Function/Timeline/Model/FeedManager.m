//
//  FeedManager.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedManager.h"

#define kFeedDatakey @"kFeedDatakey"

@implementation FeedManager

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(FeedManager)

- (void)storeFeed:(NSData *)pbFeedData
{
    USER_DEFAULTS_SET(kFeedDatakey, pbFeedData);
}

- (PBFeed *)pbFeed
{
    if (_pbFeed == nil) {
        _pbFeed = [self readFeedFromStorage];
    }
    return _pbFeed;
}

- (PBFeed *)readFeedFromStorage
{
        NSData* data = USER_DEFAULTS_GET(kFeedDatakey);
        if (data == nil){
            return nil;
        }
        
        @try {
            PBFeed* newFeed = [PBFeed parseFromData:data];
            return newFeed;
        }
        @catch (NSException *exception) {
            NSLog(@"catch exception while parse user data, exception=%@", [exception description]);
            return nil;
        }

}
@end
