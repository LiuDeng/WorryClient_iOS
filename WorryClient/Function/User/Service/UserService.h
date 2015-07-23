//
//  UserService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
#import "User.pb.h"
#import "CommonService.h"

#define kUserClassName  @"User"
#define kFavoriteAnswers    @"favoriteAnswers"
#define kFavoriteFeeds      @"favoriteFeeds"
#define kFollowTopic        @"followTopic"

typedef void(^ServicePBUserBlock)(PBUser *pbUser,NSError *error);
typedef void(^FollowersAndFolloweesBlock)(NSArray *pbFollowers,NSArray *pbFollowees,NSError *error);
typedef void(^CollectorRelationBlock)(AVRelation *relation);

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

#pragma mark - Update
- (void)updateAvatar:(UIImage *)image block:(ServiceErrorResultBlock) block;
- (void)updateBGImage:(UIImage *)image block:(ServiceErrorResultBlock) block;
- (void)updateNick:(NSString *)nick block:(ServiceErrorResultBlock)block;
- (void)updateSignature:(NSString *)signature block:(ServiceErrorResultBlock)block;
- (void)updateGender:(BOOL)gender block:(ServiceErrorResultBlock)block;
- (void)updateLocation:(NSString *)location block:(ServiceErrorResultBlock)block;
//- (void)updatePhone:(NSString *)phone block:(ServiceErrorResultBlock)block;
- (void)updateEmail:(NSString *)email block:(ServiceErrorResultBlock)block;
- (void)updateQQ:(NSString *)QQ block:(ServiceErrorResultBlock)block;
- (void)updateWeixinId:(NSString *)WeixinId block:(ServiceErrorResultBlock)block;
- (void)updateSinaId:(NSString *)sinaId block:(ServiceErrorResultBlock)block;
- (void)updatePWD:(NSString *)password
           newPWD:(NSString *)newPassword
            block:(ServiceErrorResultBlock)block;

//- (void)phoneResetPWD:(NSString *)password block:(ServiceErrorResultBlock)block;

#pragma mark - Followee and Follower
- (void)follow:(NSString *)userId block:(ServiceErrorResultBlock)block;
- (void)unfollow:(NSString *)userId block:(ServiceErrorResultBlock)block;
- (void)getUser:(NSString *)userId followersAndFollowees:(FollowersAndFolloweesBlock)block; //  暂时未使用
- (void)getUser:(NSString *)userId followers:(ServiceArrayResultBlock)block;    //  获得关注的人
- (void)getUser:(NSString *)userId followees:(ServiceArrayResultBlock)block;    //  获得粉丝
#pragma mark - Favorite
- (void)favoriteFeed:(NSString *)feedId block:(ServiceErrorResultBlock)block;
- (void)unfavoriteFeed:(NSString *)feedId block:(ServiceErrorResultBlock)block;
- (void)favoriteAnswer:(NSString *)answerId block:(ServiceErrorResultBlock)block;
- (void)unfavoriteAnswer:(NSString *)answerId block:(ServiceErrorResultBlock)block;
#pragma mark - Follow topic and feed
- (void)followTopic:(NSString *)topicId block:(ServiceErrorResultBlock)block;
- (void)unfollowTopic:(NSString *)topicId block:(ServiceErrorResultBlock)block;
#pragma mark - Else
- (BOOL)ifLogIn;

- (PBUser *)simplePBUserWithUser:(AVUser *)user;

//  请求验证邮箱


@end
