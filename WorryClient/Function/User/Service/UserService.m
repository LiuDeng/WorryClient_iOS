//
//  UserService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserService.h"
#import "AVOSCloud/AVOSCloud.h"

@implementation UserService

- (void)signUpByValue:(NSString*)value
             WithType:(PBSignUpAndLoginType)signUpLoginType
             password:(NSString*)password
             callback:(UserServiceCallBackBlock)callback
{
    PBUserBuilder *pbUserBuilder = [PBUser builder];
    //  the id should be only
    [pbUserBuilder setUserId:@""];
    switch (signUpLoginType) {
        case PBSignUpAndLoginTypeEmail:
            [pbUserBuilder setEmail:value];
            break;
        case PBSignUpAndLoginTypePhone:
            [pbUserBuilder setPhone:value];
            break;
        default:
            //  TODO
            break;
    }
    [pbUserBuilder setNick:@"aaa"];
    PBUser *pbUser = [pbUserBuilder build];
    NSData *pbUserData = [pbUser data];
    
    AVObject *userObject = [AVObject objectWithClassName:@"_user"];
    [userObject fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if (object) {
            [object setObject:pbUserData forKey:@"pbUser"];
        }else{
            NSLog(@"Error: %@",[error description]);
        }
    }];
    
    [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //  TODO
        }else{
            //  TODO
        }
    }];
    //  store the pbUser
}

@end
