//
//  UserManager.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/11.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserManager.h"

#define kUserDataKey @"kUserDataKey"

@implementation UserManager

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(UserManager);

- (void)storeUser:(NSData *)pbUserData
{
    USER_DEFAULTS_SET(kUserDataKey, pbUserData);
    [self reloadUserFromCache];
}

- (void)removeUser
{
    USER_DEFAULTS_REMOVE(kUserDataKey);
    _pbUser = nil;
}

- (BOOL)hasUser
{
    return ([self pbUser] != nil);
}
- (PBUser*)pbUser
{
    if (_pbUser == nil) {
        _pbUser = [self readUserFromCache];
    }
    return _pbUser;
}

#pragma mark - Utils

- (PBUser*)readUserFromCache
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

- (void)reloadUserFromCache
{
    _pbUser = [self readUserFromCache];
}
@end
