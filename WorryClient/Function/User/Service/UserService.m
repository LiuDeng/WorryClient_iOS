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

#define kPBUserKey @"kPBUserKey"
#define kAvatarKey @"Avatar"

const CGFloat kUpdateImageQuality = 1.0f;

@implementation UserService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(UserService)

- (void)requestSmsCodeWithPhone:(NSString *)phone
                       callback:(UserServiceBooleanResultBlock)block
{
    [AVOSCloud requestSmsCodeWithPhoneNumber:phone callback:block];
}

- (void)requestEmailVerify:(NSString*)email
                 withBlock:(UserServiceErrorResultBlock)block
{
//    AVUser *avUser = [AVUser currentUser];

//    [AVUser requestEmailVerify:email withBlock:block];
}

- (void)signUpOrLogInWithPhoneInBackground:(NSString *)phone smsCode:(NSString *)code block:(UserServiceErrorResultBlock)block
{
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:phone smsCode:code block:^(AVUser *user, NSError *error) {
        if (error == nil) {
            PBUserBuilder *pbUserBuilder = [PBUser builder];
            [pbUserBuilder setPhone:phone];
            PBUser *pbUser = [pbUserBuilder build];
        
            NSData *pbUserData = [pbUser data];
            [user setObject:pbUserData forKey:kPBUserKey];
            [user saveEventually];
            EXECUTE_BLOCK(block,error);
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
    [pbUserBuilder setPassword:avUser.password];
    [pbUserBuilder setEmail:email];
    
    PBUser *pbUser = [pbUserBuilder build];
    NSData *pbUserData = [pbUser data];
    
    [avUser setObject:pbUserData forKey:kPBUserKey];
    [avUser signUpInBackgroundWithBlock:block];
}
- (void)logInByValue:(NSString *)value password:(NSString *)password block:(UserServiceErrorResultBlock)block
{
    [AVUser logInWithUsernameInBackground:value password:password block:^(AVUser *user, NSError *error) {
        if (error == nil) {
            NSData *pbUserData = [user objectForKey:kPBUserKey];
            [[UserManager sharedInstance]storeUser:pbUserData];
            EXECUTE_BLOCK(block,error);
        }
    }];
}

- (void)logOut
{
    [AVUser logOut];
    [[UserManager sharedInstance]removeUser];
}

#pragma mark - Update

- (void)updateObject:(id)object forKey:(NSString *)key block:(UserServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser currentUser];
    [avUser setObject:object forKey:key];
    [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            EXECUTE_BLOCK(block,error);
        }
    }];
}
- (void)updatePBUser:(void(^)(PBUserBuilder *pbUserBuilder))updatePBUserblock block:(UserServiceErrorResultBlock)block
{
    PBUser *pbUser = [[UserManager sharedInstance]pbUser];
    PBUserBuilder *pbUserBuilder = [pbUser toBuilder];
    updatePBUserblock(pbUserBuilder);
    pbUser = [pbUserBuilder build];
    NSData *pbUserData = [pbUser data];
    [[UserManager sharedInstance]storeUser:pbUserData];
    [self updateObject:pbUserData forKey:kPBUserKey block:block];
}

- (void)updateAvatar:(UIImage *)image block:(UserServiceErrorResultBlock)block
{
    NSData *imageData = UIImageJPEGRepresentation(image, kUpdateImageQuality);
    AVFile *avFile = [AVFile fileWithName:@"avatar.jpeg" data:imageData];
    [avFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self updateObject:avFile forKey:kAvatarKey block:block];
            
            [self updatePBUser:^(PBUserBuilder *pbUserBuilder) {
                [pbUserBuilder setAvatar:avFile.url];
            } block:block];
            
        }else{
            EXECUTE_BLOCK(block,error);
        }
    }];
}

- (void)updateNick:(NSString *)nick block:(UserServiceErrorResultBlock)block
{
    [self updatePBUser:^(PBUserBuilder *pbUserBuilder) {
        [pbUserBuilder setNick:nick];
    } block:block];
}

@end