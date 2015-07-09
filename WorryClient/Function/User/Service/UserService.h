//
//  UserService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
#import "User.pb.h"
#import "CommonService.h"
#import <ShareSDK/ShareSDK.h>
#import <SMS_SDK/SMS_SDK.h>

typedef void (^ServicePBUserBlock) (PBUser *pbUser,NSError *error);

@interface UserService : CommonService
{
    PBUser *_currentPBUser;
}
DEFINE_SINGLETON_FOR_CLASS(UserService)

- (PBUser *)currentPBUser;

#pragma mark - Sign up
- (void)emailSignUp:(NSString *)email
           password:(NSString *)password
              block:(ServiceErrorResultBlock)block;
- (void)phoneSignUp:(NSString *)phone
           password:(NSString *)password
            smsCode:code
              block:(ServiceErrorResultBlock)block;

#pragma mark - Log in
- (void)verifyCode:(NSString *)code
             phone:(NSString *)phone
          callback:(ServiceErrorResultBlock)block;
- (void)getCodeWithPhone:(NSString *)phone
                callback:(ServiceErrorResultBlock)block;

- (void)requestEmailVerify:(NSString*)email
                 withBlock:(ServiceErrorResultBlock)block;

- (void)logInWithUsername:(NSString *)username
                 password:(NSString *)password
                    block:(ServicePBUserBlock)block;
- (void)logOut;
- (void)qqLogInWithBlock:(ServiceBooleanResultBlock)block;
- (void)sinaLogInWithBlock:(ServiceBooleanResultBlock)block;

//- (void)requireVerifyCodeWithPhone:(NSString *)phone
//                          areaCode:(NSString *)areaCode
//                       resultBlock:(ServiceErrorResultBlock)resultBlock;
//- (void)commitVerifyCode:(NSString *)code
//                  result:(CommitVerifyCodeBlock)result;

#pragma mark - Update
- (void)updateAvatar:(UIImage *)image block:(ServiceErrorResultBlock) block;
- (void)updateBGImage:(UIImage *)image block:(ServiceErrorResultBlock) block;
- (void)updateNick:(NSString *)nick block:(ServiceErrorResultBlock)block;
- (void)updateSignature:(NSString *)signature block:(ServiceErrorResultBlock)block;
- (void)updateGender:(BOOL)gender block:(ServiceErrorResultBlock)block;
- (void)updateLocation:(NSString *)location block:(ServiceErrorResultBlock)block;
- (void)updatePhone:(NSString *)phone block:(ServiceErrorResultBlock)block;
- (void)updateEmail:(NSString *)email block:(ServiceErrorResultBlock)block;
- (void)updateQQ:(NSString *)QQ block:(ServiceErrorResultBlock)block;
- (void)updateWeixinId:(NSString *)WeixinId block:(ServiceErrorResultBlock)block;
- (void)updateSinaId:(NSString *)sinaId block:(ServiceErrorResultBlock)block;
- (void)updatePWD:(NSString *)password
           newPWD:(NSString *)newPassword
            block:(ServiceErrorResultBlock)block;

- (void)phoneResetPWD:(NSString *)password block:(ServiceErrorResultBlock)block;

#pragma mark - Else
- (BOOL)ifLogIn;

- (PBUser *)simplePBUserWithUser:(AVUser *)user;

//  请求验证邮箱
@end
