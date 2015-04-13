//
//  UserService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserService.h"
#import "AVOSCloud/AVOSCloud.h"
#import "WorryConfigManager.h"

@implementation UserService

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
    [AVUser verifyMobilePhone:value withBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //  TODO
        }
    }];
    
    
    
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

- (void)quickSignUpByValue:(NSString*)value
                  password:(NSString*)password
                  userName:(NSString*)userName
                  callback:(UserServiceCallBackBlock)callback
{
    [self signUpByValue:value WithType:PBSignUpAndLoginTypePhone userName:userName password:password callback:callback];
}



@end
