//
//  UserManager.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/11.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonManager.h"
@class PBUser;

@interface UserManager : CommonManager
{
    PBUser *_pbUser;
}

DEFINE_SINGLETON_FOR_CLASS(UserManager)

//- (void)storeUser:(PBUser*)pbUser;
- (NSString *)userNick;
- (NSString *)userId;
@end
