//
//  UserService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonService.h"
#import "User.pb.h"
#import "SynthesizeSingleton.h"
#import "AVOSCloud/AVOSCloud.h"

typedef void (^UserServiceCallBackBlock) (PBUser* pbUser, NSError* error);
typedef void (^UserServiceErrorResultBlock) (NSError *error);
typedef AVBooleanResultBlock UserServiceBooleanResultBlock;
typedef AVUserResultBlock UserServiceResultBlock;

@interface UserService : CommonService

DEFINE_SINGLETON_FOR_CLASS(UserService)

- (void)requestSmsCodeWithPhone:(NSString *)phone
                      callback:(UserServiceBooleanResultBlock)block;
- (void)requestEmailVerify:(NSString*)email
                 withBlock:(UserServiceErrorResultBlock)block;

- (void)signUpOrLogInWithPhoneInBackground:(NSString *)phone
                                   smsCode:(NSString *)code
                                     block:(UserServiceErrorResultBlock)block;
- (void)signUpByEmail:(NSString *)email
             password:(NSString *)password
                block:(UserServiceBooleanResultBlock)block;
- (void)logInByValue:(NSString *)value password:(NSString *)password block:(UserServiceErrorResultBlock)block;
@end
