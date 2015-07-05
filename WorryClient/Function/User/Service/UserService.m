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

#define kDefaultNick           @"还没有昵称"
#define kDefaultSignature      @"这个人很懒"

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
#define kPhoneKey       @"phone"
#define kPhoneVerified  @"phoneVerified"

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
//    [avUser signUpInBackgroundWithBlock:block];   //  修改了ServiceBooleanResultBlock，需要做相应调整
}

- (void)phoneSignUp:(NSString *)phone password:(NSString *)password block:(ServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser user];
    avUser.username = phone;
    avUser.password = password;
    [avUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error==nil) {
            [avUser setObject:phone forKey:kPhoneKey];
            NSNumber *num = [NSNumber numberWithBool:YES];
            [avUser setObject:num forKey:kPhoneVerified];
            
            [avUser setObject:kDefaultNick forKey:kNickKey];
            [avUser setObject:kDefaultSignature forKey:kSignatureKey];
            
            [avUser saveEventually];
            [self refreshPBUserWithAVUser:avUser];
        }
        EXECUTE_BLOCK(block,error);
    }];
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

- (void)qqLogInWithBlock:(ServiceBooleanResultBlock)block
{
    [ShareSDK getUserInfoWithType:ShareTypeQQ
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result) {
//                                   JDDebug(@"userInfo uid %@",[userInfo uid]);
//                                   JDDebug(@"userInfo nickname %@",[userInfo nickname]);
                               }
                               EXECUTE_BLOCK(block,result);
                           }];
}

- (void)sinaLogInWithBlock:(ServiceBooleanResultBlock)block
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result) {
//                                   JDDebug(@"userInfo uid %@",[userInfo uid]);
//                                   JDDebug(@"userInfo nickname %@",[userInfo nickname]);
                                  EXECUTE_BLOCK(block,result);
                               }
                           }];

}

- (void)requireVerifyCodeWithPhone:(NSString *)phone
                          areaCode:(NSString *)areaCode
                       resultBlock:(ServiceErrorResultBlock)resultBlock
{
    [SMS_SDK getVerificationCodeBySMSWithPhone:phone zone:areaCode result:resultBlock]; //  may have trouble
}

- (void)commitVerifyCode:(NSString *)code
                  result:(CommitVerifyCodeBlock)result
{
    [SMS_SDK commitVerifyCode:code result:result];
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
    [avUser setObject:phone forKey:kPhoneKey];
    NSNumber *num = [NSNumber numberWithBool:YES];
    [avUser setObject:num forKey:kPhoneVerified];
    
    [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self refreshPBUserWithAVUser:avUser];
        }
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)updatePWD:(NSString *)password
           newPWD:(NSString *)newPassword
            block:(ServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser currentUser];
    [avUser updatePassword:password newPassword:newPassword block:^(id object, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)phoneResetPWD:(NSString *)password block:(ServiceErrorResultBlock)block
{
//    AVUser *avUser = [AVUser currentUser];
//    AVUser *avUser = [AVUser ob];
//    [self updatePWD:avUser.password newPWD:password block:block];
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:@"15626460272"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            //  无法修改，还是得依赖LeanCloud中的一套方法，上线之前加上去吧。
            AVUser *avUser = (AVUser *)objects[0];
            avUser.password = @"11";
            [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    JDDebug(@"success");
                }
            }];
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
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
//    NSNumber *emailVerifiedNum = [user objectForKey:kEmailVerified];    //  TODO always YES ,but emailVerified is false on the server.
//    BOOL emailVerified = emailVerifiedNum.boolValue;
    int credit = (int)[user objectForKey:kCreditKey];
    int32_t creatAt = user.createdAt.timeIntervalSince1970;   //  may be false.
    int32_t updateAt = user.updatedAt.timeIntervalSince1970;
    NSString *phone = [user objectForKey:kPhoneKey];
    NSNumber *phoneVerifiedNum = [user objectForKey:kPhoneVerified];
    BOOL phoneVerified = phoneVerifiedNum.boolValue;
    
    PBUserBuilder *pbUserBuilder = [PBUser builder];
    
    [pbUserBuilder setUserId:user.objectId];
    [pbUserBuilder setPassword:user.password];
    [pbUserBuilder setNick:nick];
    [pbUserBuilder setAvatar:avatar];
    [pbUserBuilder setGender:gender];
    [pbUserBuilder setBgImage:BGImage];
    [pbUserBuilder setSignature:signature];
    [pbUserBuilder setLocation:location];
    [pbUserBuilder setPhone:phone];
//    [pbUserBuilder setEmail:user.email];
    [pbUserBuilder setCreatedAt:creatAt];
    [pbUserBuilder setUpatedAt:updateAt];
    
    [pbUserBuilder setPhoneVerified:phoneVerified];
//    [pbUserBuilder setEmailVerified:emailVerified];
    [pbUserBuilder setCredit:credit];
    
    PBUser *pbUser = [pbUserBuilder build];
    NSData *pbUserData = [pbUser data];
    [[UserManager sharedInstance]storeUser:pbUserData];
}

/*
 @param user AVUser
 @return pbUser with the basic info:id,nick,avatar
 */
- (PBUser *)simplePBUserWithUser:(AVUser *)user
{
    //  TODO maybe need fetch.
    NSString *nick = [user objectForKey:kNickKey];
    NSString *avatar = [user objectForKey:kAvatarKey];
    PBUserBuilder *builder = [PBUser builder];
    
    builder.userId = user.objectId;
    builder.nick = nick;
    builder.avatar = avatar;
    
    return [builder build];
}


@end