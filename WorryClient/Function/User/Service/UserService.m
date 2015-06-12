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

#define kPBUserKey      @"pbUserData"
#define kAvatarName     @"avatar.jpeg"
#define kBGImageName    @"BGImage.jpeg"

//  暂时不用和User.proto中的一样

#define kNickKey        @"nick"
#define kAvatarKey      @"avatar"
#define kGenderKey      @"gender"
#define kBGImageKey     @"BGImage"
#define kSignatureKey   @"signature"
#define kLocationKey    @"location"
#define kCreditKey      @"credit"
#define kLevelKey       @"level"
#define kThanksNumKey   @"thanksNum"
#define kAgreeNumKey    @"agreeNum"

#define kQQIdKey        @"QQId"
#define kSinaIdKey      @"sinaId"


#define kEmailVerified  @"emailVerified"


const CGFloat kUpdateImageQuality = 0.5f;

@implementation UserService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(UserService)

- (void)requestSmsCodeWithPhone:(NSString *)phone
                       callback:(ServiceErrorResultBlock)block
{
    //  TODO换成mob的短信验证码
    [AVOSCloud requestSmsCodeWithPhoneNumber:phone callback:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)verifySmsCode:(NSString *)code mobilePhoneNumber:(NSString *)phoneNumber callback:(ServiceErrorResultBlock)block
{
    //  TODO换成mob的短信验证码
    [AVOSCloud verifySmsCode:code mobilePhoneNumber:phoneNumber callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self updatePhone:phoneNumber block:block];
        }else{
            EXECUTE_BLOCK(block,error);
        }
    }];
}

- (void)requestEmailVerify:(NSString*)email
                 withBlock:(ServiceErrorResultBlock)block
{
    [AVUser requestEmailVerify:email withBlock:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)signUpOrLogInWithPhoneInBackground:(NSString *)phone smsCode:(NSString *)code block:(ServiceErrorResultBlock)block
{
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:phone smsCode:code block:^(AVUser *user, NSError *error) {
        if (error == nil) {
            [self refreshPBUserWithAVUser:user];
        }
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)signUpByEmail:(NSString *)email password:(NSString *)password block:(ServiceBooleanResultBlock)block
{
    AVUser *avUser = [AVUser user];
    avUser.username = email;
    avUser.email = email;
    avUser.password = password;
    [avUser signUpInBackgroundWithBlock:block];
}

- (void)logInByValue:(NSString *)value password:(NSString *)password block:(ServiceErrorResultBlock)block
{
    [AVUser logInWithUsernameInBackground:value password:password block:^(AVUser *user, NSError *error) {
        if (error == nil) {
            [self refreshPBUserWithAVUser:user];
        }
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)refreshUser
{
    AVUser *avUser = [AVUser currentUser];
    [self refreshPBUserWithAVUser:avUser];
}

- (void)logOut
{
    [AVUser logOut];
    [[UserManager sharedInstance]removeUser];
}

#pragma mark - Update

- (void)updateAvatar:(UIImage *)image block:(ServiceErrorResultBlock)block
{
    [self updateImage:image imageName:kBGImageName block:^(NSError *error, NSString *url) {
        if (error == nil) {
            [self updateObject:url forKey:kAvatarKey block:block];
        }else{
            //  TODO update image error
        }
    }];
}

- (void)updateBGImage:(UIImage *)image block:(ServiceErrorResultBlock)block
{
    [self updateImage:image imageName:kBGImageName block:^(NSError *error, NSString *url) {
        if (error == nil) {
            [self updateObject:url forKey:kBGImageKey block:block];
        }else{
            //  TODO update image error
        }
    }];
}


- (void)updateNick:(NSString *)nick block:(ServiceErrorResultBlock)block
{
    [self updateObject:nick forKey:kNickKey block:block];
}

- (void)updateSignature:(NSString *)signature block:(ServiceErrorResultBlock)block
{
    [self updateObject:signature forKey:kSignatureKey block:block];
}

- (void)updateGender:(BOOL)gender block:(ServiceErrorResultBlock)block
{
    [self updateObject:[NSNumber numberWithBool:gender] forKey:kGenderKey block:block];}

- (void)updateLocation:(NSString *)location block:(ServiceErrorResultBlock)block
{
    [self updateObject:location forKey:kLocationKey block:block];
}

- (void)updateQQ:(NSString *)QQ block:(ServiceErrorResultBlock)block
{
    //  TODO
}

- (void)updateWeixinId:(NSString *)WeixinId block:(ServiceErrorResultBlock)block
{
    //  TODO
}

- (void)updateSinaId:(NSString *)sinaId block:(ServiceErrorResultBlock)block
{
    //  TODO
}

- (void)updateEmail:(NSString *)email block:(ServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser currentUser];
    avUser.email = email;
    [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self refreshPBUserWithAVUser:avUser];
        }
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)updatePhone:(NSString *)phone block:(ServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser currentUser];
    avUser.mobilePhoneNumber = phone;
    [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self refreshPBUserWithAVUser:avUser];
        }
        EXECUTE_BLOCK(block,error);
    }];
}

#pragma mark - Uitls

- (void)updateObject:(id)object forKey:(NSString *)key block:(ServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser currentUser];
    [avUser setObject:object forKey:key];
    [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self refreshPBUserWithAVUser:avUser];
        }
        EXECUTE_BLOCK(block,error);
    }];
}

- (BOOL)ifLogIn
{
    return [AVUser currentUser] == nil ? NO : YES;
}

- (void)refreshPBUserWithAVUser:(AVUser *)user
{
    NSString *nick  = [user objectForKey:kNickKey];
    NSString *avatar = [user objectForKey:kAvatarKey];
    NSNumber *genderNum = [user objectForKey:kGenderKey];
    BOOL gender = genderNum.boolValue;
    NSString *BGImage = [user objectForKey:kBGImageKey];
    NSString *signature = [user objectForKey:kSignatureKey];
    NSString *location = [user objectForKey:kLocationKey];
    NSNumber *emailVerifiedNum = [user objectForKey:kEmailVerified];    //  TODO always YES ,but emailVerified is false on the server.
    BOOL emailVerified = emailVerifiedNum.boolValue;
    int credit = (int)[user objectForKey:kCreditKey];
    int32_t creatAt = user.createdAt.timeIntervalSince1970;   //  may be false.
    int32_t updateAt = user.updatedAt.timeIntervalSince1970;
    
    PBUserBuilder *pbUserBuilder = [PBUser builder];
    
    [pbUserBuilder setUserId:user.objectId];
    [pbUserBuilder setPassword:user.password];
    [pbUserBuilder setNick:nick];
    [pbUserBuilder setAvatar:avatar];
    [pbUserBuilder setGender:gender];
    [pbUserBuilder setBgImage:BGImage];
    [pbUserBuilder setSignature:signature];
    [pbUserBuilder setLocation:location];
    [pbUserBuilder setPhone:user.mobilePhoneNumber];
    [pbUserBuilder setEmail:user.email];
    [pbUserBuilder setCreatedAt:creatAt];
    [pbUserBuilder setUpatedAt:updateAt];
    
    [pbUserBuilder setPhoneVerified:user.mobilePhoneVerified];
    [pbUserBuilder setEmailVerified:emailVerified];
    [pbUserBuilder setCredit:credit];
    
    PBUser *pbUser = [pbUserBuilder build];
    NSData *pbUserData = [pbUser data];
    [[UserManager sharedInstance]storeUser:pbUserData];
}
@end