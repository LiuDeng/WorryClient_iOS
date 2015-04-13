//
//  UserManager.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/11.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserManager.h"
#import "User.pb.h"

#define kUserDataKey @"kUserDataKey"

@implementation UserManager

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(UserManager);

- (NSString *)userNick
{
    return  [[self pbUser] nick];
}

- (NSString *)userId
{
    return [[self pbUser] userId];
}

#pragma mark - Utils
- (PBUser*) pbUser
{
    if (_pbUser == nil) {
        _pbUser = [self readUserFromStorage];
    }
    return _pbUser;
}
- (PBUser*)readUserFromStorage
{
    NSData* data = USER_DEFAULTS_GET(kUserDataKey);
    if (data == nil){
        return nil;
    }
    
    @try {
        PBUser* newUser = [PBUser parseFromData:data];
        return newUser;
    }
    @catch (NSException *exception) {
        NSLog(@"catch exception while parse user data, exception=%@", [exception description]);
        return nil;
    }
}
@end
