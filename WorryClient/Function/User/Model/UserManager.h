//
//  UserManager.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/11.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonManager.h"
#import "User.pb.h"

@interface UserManager : CommonManager
{
    PBUser *_pbUser;
}

DEFINE_SINGLETON_FOR_CLASS(UserManager)
- (BOOL)hasUser;
- (PBUser*)pbUser;
- (void)storeUser:(NSData *)pbUserData;
- (void)removeUser;

- (void)reloadUserFromCache;
@end
