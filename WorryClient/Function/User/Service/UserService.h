//
//  UserService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonService.h"
#import "User.pb.h"

typedef void (^UserServiceCallBackBlock) (PBUser* pbUser, NSError* error);

@interface UserService : CommonService

- (void)signUpByValue:(NSString*)value
             WithType:(PBSignUpAndLoginType)signUpLoginType
             userName:(NSString*)userName
              password:(NSString*)password
              callback:(UserServiceCallBackBlock)callback;
- (void)quickSignUpByValue:(NSString*)value
                  password:(NSString*)password
                  userName:(NSString*)userName
                  callback:(UserServiceCallBackBlock)callback;
@end
