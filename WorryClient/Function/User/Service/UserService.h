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
typedef void (^UserServiceSignUpBooleanBolck) (BOOL succeeded);
typedef AVBooleanResultBlock UserServiceBooleanResultBlock;
typedef AVUserResultBlock UserServiceResultBlock;

@interface UserService : CommonService

DEFINE_SINGLETON_FOR_CLASS(UserService)

- (void)signUpByValue:(NSString *)value
             WithType:(PBSignUpAndLoginType)signUpLoginType
             userName:(NSString *)userName
              password:(NSString *)password
              callback:(UserServiceCallBackBlock)callback;
- (void)quickSignUpWithAVUser:(AVUser *)avUser password:(NSString *)password withBlock:(UserServiceCallBackBlock)block;

//- (void)verifyPhone:(NSString *)phone withBlock:(UserServiceBooleanResultBlock)block;
- (void)requestSmsCodeWithPhone:(NSString *)phone
                      callback:(UserServiceBooleanResultBlock)block;
- (void)requestEmailVerify:(NSString*)email
                 withBlock:(UserServiceBooleanResultBlock)block;

- (void)signUpOrLogInWithPhoneInBackground:(NSString *)phone smsCode:(NSString *)code block:(UserServiceSignUpBooleanBolck)block;
@end
