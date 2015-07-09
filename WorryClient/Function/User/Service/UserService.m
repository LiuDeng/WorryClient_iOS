//
//  UserService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserService.h"
#import "WorryConfigManager.h"
#import "Utils.h"

#define kAvatarName     @"avatar.jpeg"
#define kBGImageName    @"BGImage.jpeg"

#define kDefaultNick           @"还没有昵称"
#define kDefaultSignature      @"这个人很懒"

//  暂时不用和User.proto中的一样
#define kNick        @"nick"
#define kAvatar      @"avatar"
#define kGender      @"gender"
#define kBGImage     @"BGImage"
#define kSignature   @"signature"
#define kLocation    @"location"
#define kCredit      @"credit"
#define kLevel       @"level"
#define kThanksNum   @"thanksNum"
#define kAgreeNum    @"agreeNum"

#define kQQId        @"QQId"
#define kSinaId      @"sinaId"


#define kEmailVerified  @"emailVerified"


const CGFloat kUpdateImageQuality = 0.5f;

@implementation UserService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(UserService)

- (PBUser *)currentPBUser
{
    [self refreshCurrentPBUser];
    return _currentPBUser;
}

- (void)getCodeWithPhone:(NSString *)phone
                callback:(ServiceErrorResultBlock)block
{
    [AVOSCloud requestSmsCodeWithPhoneNumber:phone callback:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)verifyCode:(NSString *)code
             phone:(NSString *)phone
          callback:(ServiceErrorResultBlock)block
{
    [AVOSCloud verifySmsCode:code mobilePhoneNumber:phone callback:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            [self updatePhone:phone block:block]; //  可能不需要？？
//        }else{
            EXECUTE_BLOCK(block,error);
//        }
    }];
}

- (void)requestEmailVerify:(NSString*)email
                 withBlock:(ServiceErrorResultBlock)block
{
    [AVUser requestEmailVerify:email withBlock:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)emailSignUp:(NSString *)email
           password:(NSString *)password
              block:(ServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser user];
    avUser.username = email;
    avUser.email = email;
    avUser.password = password;
    [avUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

//  只留下sign up with mobile phone number 的功能，不开放log in with mobile phone number的功能
- (void)phoneSignUp:(NSString *)phone
           password:(NSString *)password
            smsCode:code
              block:(ServiceErrorResultBlock)block
{
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:phone smsCode:code block:^(AVUser *user, NSError *error) {
        if (error == nil) {
            user.username = phone;
            user.password = password;
            //  TODO  测试一下 current user 是否存在
            [self refreshCurrentPBUser];    //  TODO current user == user?
        }
        EXECUTE_BLOCK(block,error);
    }];
}

- (void)logInWithUsername:(NSString *)username
                 password:(NSString *)password
                    block:(ServicePBUserBlock)block
{
    [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
        if (error == nil) {
            //  user -> pbUser
            [self refreshCurrentPBUser];
        }
        EXECUTE_BLOCK(block,_currentPBUser,error);  //  TODO _currentPBUser maybe nil
    }];
}


- (void)logOut
{
    [AVUser logOut];
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

//- (void)requireVerifyCodeWithPhone:(NSString *)phone
//                          areaCode:(NSString *)areaCode
//                       resultBlock:(ServiceErrorResultBlock)resultBlock
//{
//    [SMS_SDK getVerificationCodeBySMSWithPhone:phone zone:areaCode result:resultBlock]; //  may have trouble
//}
//
//- (void)commitVerifyCode:(NSString *)code
//                  result:(CommitVerifyCodeBlock)result
//{
//    [SMS_SDK commitVerifyCode:code result:result];
//}

#pragma mark - Update

- (void)updateAvatar:(UIImage *)image block:(ServiceErrorResultBlock)block
{
    [self updateImage:image imageName:kBGImageName block:^(NSError *error, NSString *url) {
        if (error == nil) {
            [self updateObject:url forKey:kAvatar block:block];
        }else{
            //  TODO update image error
        }
    }];
}

- (void)updateBGImage:(UIImage *)image block:(ServiceErrorResultBlock)block
{
    [self updateImage:image imageName:kBGImageName block:^(NSError *error, NSString *url) {
        if (error == nil) {
            [self updateObject:url forKey:kBGImage block:block];
        }else{
            //  TODO update image error
        }
    }];
}


- (void)updateNick:(NSString *)nick block:(ServiceErrorResultBlock)block
{
    [self updateObject:nick forKey:kNick block:block];
}

- (void)updateSignature:(NSString *)signature block:(ServiceErrorResultBlock)block
{
    [self updateObject:signature forKey:kSignature block:block];
}

- (void)updateGender:(BOOL)gender block:(ServiceErrorResultBlock)block
{
    [self updateObject:[NSNumber numberWithBool:gender] forKey:kGender block:block];}

- (void)updateLocation:(NSString *)location block:(ServiceErrorResultBlock)block
{
    [self updateObject:location forKey:kLocation block:block];
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
            [self refreshCurrentPBUser];
        }
        EXECUTE_BLOCK(block,error);
    }];
}

//- (void)updatePhone:(NSString *)phone block:(ServiceErrorResultBlock)block
//{
//    AVUser *avUser = [AVUser currentUser];
//    [avUser setObject:phone forKey:kPhoneKey];
//    NSNumber *num = [NSNumber numberWithBool:YES];
//    [avUser setObject:num forKey:kPhoneVerified];
//    
//    [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            [self refreshPBUserWithAVUser:avUser];
//        }
//        EXECUTE_BLOCK(block,error);
//    }];
//}

//  可能用不上
- (void)updatePWD:(NSString *)password
           newPWD:(NSString *)newPassword
            block:(ServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser currentUser];
    [avUser updatePassword:password newPassword:newPassword block:^(id object, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

//- (void)phoneResetPWD:(NSString *)password block:(ServiceErrorResultBlock)block
//{
////    AVUser *avUser = [AVUser currentUser];
////    AVUser *avUser = [AVUser ob];
////    [self updatePWD:avUser.password newPWD:password block:block];
//    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
//    [query whereKey:@"username" equalTo:@"15626460272"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            // 检索成功
//            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
//            //  无法修改，还是得依赖LeanCloud中的一套方法，上线之前加上去吧。
//            AVUser *avUser = (AVUser *)objects[0];
//            avUser.password = @"11";
//            [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    JDDebug(@"success");
//                }
//            }];
//        } else {
//            // 输出错误信息
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
//}

#pragma mark - Uitls

- (void)updateObject:(id)object forKey:(NSString *)key block:(ServiceErrorResultBlock)block
{
    AVUser *avUser = [AVUser currentUser];
    [avUser setObject:object forKey:key];
    [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self refreshCurrentPBUser];
        }
        EXECUTE_BLOCK(block,error);
    }];
}

- (BOOL)ifLogIn
{
    return [AVUser currentUser] == nil ? NO : YES;
}

- (void)refreshCurrentPBUser
{
    AVUser *currentUser = [AVUser currentUser]; //  TODO if need to fetch?
    _currentPBUser = [self perfectPBUserWithAVUser:currentUser];
}

/*
 @param user AVUser
 @return current pbUser with all info
 */
- (PBUser *)perfectPBUserWithAVUser:(AVUser *)user
{
    NSString *nick  = [user objectForKey:kNick];
    NSString *avatar = [user objectForKey:kAvatar];
    NSNumber *genderNum = [user objectForKey:kGender];
    BOOL gender = genderNum.boolValue;
    NSString *BGImage = [user objectForKey:kBGImage];
    NSString *signature = [user objectForKey:kSignature];
    NSString *location = [user objectForKey:kLocation];
//    NSNumber *emailVerifiedNum = [user objectForKey:kEmailVerified];    //  TODO always YES ,but emailVerified is false on the server.
//    BOOL emailVerified = emailVerifiedNum.boolValue;
    int credit = (int)[user objectForKey:kCredit];
    int32_t creatAt = user.createdAt.timeIntervalSince1970;   //  may be false.
    int32_t updateAt = user.updatedAt.timeIntervalSince1970;
//    NSString *phone = [user objectForKey:kPhone];
//    NSNumber *phoneVerifiedNum = [user objectForKey:kPhoneVerified];
//    BOOL phoneVerified = phoneVerifiedNum.boolValue;
    
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
//    [pbUserBuilder setPhone:phone];
//    [pbUserBuilder setEmail:user.email];
    [pbUserBuilder setCreatedAt:creatAt];
    [pbUserBuilder setUpatedAt:updateAt];
    
//    [pbUserBuilder setPhoneVerified:phoneVerified];
//    [pbUserBuilder setEmailVerified:emailVerified];
    [pbUserBuilder setPhoneVerified:user.mobilePhoneVerified];
    [pbUserBuilder setCredit:credit];
    
    return [pbUserBuilder build];
}

/*
 @param user AVUser without data
 @return pbUser with the basic info:id,nick,avatar
 */
- (PBUser *)simplePBUserWithUser:(AVUser *)user
{
    user = (AVUser *)[user fetchIfNeeded];
    NSString *nick = [user objectForKey:kNick];
    NSString *avatar = [user objectForKey:kAvatar];
    PBUserBuilder *builder = [PBUser builder];
    
    builder.userId = user.objectId;
    builder.nick = nick;
    builder.avatar = avatar;
    
    return [builder build];
}

- (void)setUserDefault:(AVUser *)user
{
    [user setObject:kDefaultNick forKey:kNick];
    [user setObject:kDefaultSignature forKey:kNick];
}

@end