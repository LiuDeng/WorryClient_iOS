//
//  UserService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
#import "User.pb.h"
#import "SynthesizeSingleton.h"
#import "AVOSCloud/AVOSCloud.h"
#import "CommonService.h"

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
- (void)logInByValue:(NSString *)value
            password:(NSString *)password
               block:(UserServiceErrorResultBlock)block;
- (void)logOut;

- (void)updateAvatar:(UIImage *)image block:(UserServiceErrorResultBlock) block;
- (void)updateBGImage:(UIImage *)image block:(UserServiceErrorResultBlock) block;
- (void)updateNick:(NSString *)nick block:(UserServiceErrorResultBlock)block;
- (void)updateSignature:(NSString *)signature block:(UserServiceErrorResultBlock)block;
- (void)updateGender:(BOOL)gender block:(UserServiceErrorResultBlock)block;
- (void)updateLocation:(NSString *)location block:(UserServiceErrorResultBlock)block;
- (void)updatePhone:(NSString *)phone block:(UserServiceErrorResultBlock)block;
- (void)updateEmail:(NSString *)email block:(UserServiceErrorResultBlock)block;
- (void)updateQQ:(NSString *)QQ block:(UserServiceErrorResultBlock)block;
- (void)updateWeixinId:(NSString *)WeixinId block:(UserServiceErrorResultBlock)block;
- (void)updateSinaId:(NSString *)sinaId block:(UserServiceErrorResultBlock)block;

- (BOOL)ifLogIn;
@end
