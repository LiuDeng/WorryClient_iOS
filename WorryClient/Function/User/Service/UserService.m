//
//  UserService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserService.h"
#import "UserManager.h"
#import "WorryConfigManager.h"
#import "Utils.h"

@implementation UserService

IMPLEMENT_SINGLETON_FOR_CLASS(UserService)

#pragma mark - Public methods

- (void)requestSmsCodeWithPhone:(NSString *)phone
                       callback:(UserServiceBooleanResultBlock)block
{
    [AVOSCloud requestSmsCodeWithPhoneNumber:phone callback:block];
}

- (void)requestEmailVerify:(NSString*)email
                 withBlock:(UserServiceBooleanResultBlock)block
{
//    AVUser *avUser = [AVUser currentUser];

//    [AVUser requestEmailVerify:email withBlock:block];
}

- (void)signUpOrLogInWithPhoneInBackground:(NSString *)phone smsCode:(NSString *)code block:(UserServiceSignUpBooleanBolck)block
{
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:phone smsCode:code block:^(AVUser *user, NSError *error) {
        if (error == nil) {
            PBUserBuilder *pbUserBuilder = [PBUser builder];
            [pbUserBuilder setPhone:phone];
            PBUser *pbUser = [pbUserBuilder build];
        
            NSData *pbUserData = [pbUser data];
            [user setObject:pbUserData forKey:@"pbUser"];
            [user saveEventually];
            EXECUTE_BLOCK(block,YES);
        }
    }];
}

- (void)signUpByEmail:(NSString *)email password:(NSString *)password block:(UserServiceBooleanResultBlock)block
{
    AVUser *avUser = [AVUser user];
    avUser.username = email;
    avUser.email = email;
    avUser.password = password;
    PBUserBuilder *pbUserBuilder = [PBUser builder];
    [pbUserBuilder setUserName:avUser.username];
    [pbUserBuilder setPassword:avUser.password];
    [pbUserBuilder setEmail:email];
    
    PBUser *pbUser = [pbUserBuilder build];
    
    NSData *pbUserData = [pbUser data];
    
    [avUser setObject:pbUserData forKey:@"pbUser"];
    [avUser signUpInBackgroundWithBlock:block];

}
@end
