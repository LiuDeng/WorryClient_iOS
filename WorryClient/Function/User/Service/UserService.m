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

- (void)signUpByValue:(NSString*)value
             WithType:(PBSignUpAndLoginType)signUpLoginType
             userName:(NSString*)userName
             password:(NSString*)password
             callback:(UserServiceCallBackBlock)callback
{
    AVUser *avUser = [AVUser user];
    avUser.username = userName;
    avUser.password = password;
    avUser.mobilePhoneNumber = value;
    NSError *error = nil;
    [avUser signUp:&error];
//    [AVUser verifyMobilePhone:value withBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            //  TODO
//        }
//    }];

    
//    switch (signUpLoginType) {
//        case PBSignUpAndLoginTypeEmail:
////            [pbUserBuilder setEmail:value];
//            avUser.email = value;
//            break;
//        case PBSignUpAndLoginTypePhone:
//            [pbUserBuilder setPhone:value];
            //  phone shoud be valify
//            [AVUser verifyMobilePhone:value withBlock:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    avUser.mobilePhoneNumber = value;
//                }
//            }];
//            break;
//        default:
//            //  TODO
//            break;
//    }

  
//    PBUserBuilder *pbUserBuilder = [PBUser builder];
//    [pbUserBuilder setNick:a];
//    PBUser *pbUser = [pbUserBuilder build];
//    NSData *pbUserData = [pbUser data];
    

//    AVObject *userObject = [AVObject objectWithClassName:@"_user"];
//    [userObject fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
//        if (object) {
//            [object setObject:pbUserData forKey:@"pbUser"];
//        }else{
//            NSLog(@"Error: %@",[error description]);
//        }
//    }];
//    
//    [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            //  TODO
//        }else{
//            //  TODO
//        }
//    }];
    //  store the pbUser
}

- (void)quickSignUpWithAVUser:(AVUser *)avUser password:(NSString *)password withBlock:(UserServiceCallBackBlock)block
{
//    avUser.username = avUser.mobilePhoneNumber;
//    avUser.password = password;
//    [AVUser signUpOrLoginWithMobilePhoneNumber:<#(NSString *)#> smsCode:<#(NSString *)#> error:<#(NSError *__autoreleasing *)#>]
}
//
//- (void)verifyPhone:(NSString *)phone withBlock:(UserServiceVerifyBlock)block
//{
//    AVUser *avUser = [[AVUser alloc]init];
//    avUser.mobilePhoneNumber = phone;
//    NSError *error = nil;
//    [avUser signUp:&error];
//
//}



- (void)requestSmsCodeWithPhone:(NSString *)phone
                       callback:(UserServiceBooleanResultBlock)block
{
    [AVOSCloud requestSmsCodeWithPhoneNumber:phone callback:block];
}

- (void)requestEmailVerify:(NSString*)email
                 withBlock:(UserServiceBooleanResultBlock)block
{
    [AVUser requestEmailVerify:email withBlock:block];
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

@end
