//
//  MessageCenter.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "MBProgressHUD.h"

@interface MessageCenter : NSObject

DEFINE_SINGLETON_FOR_CLASS(MessageCenter)

- (void)postSuccessMessage:(NSString *)message duration:(CGFloat)duration;
- (void)postErrorMessage:(NSString *)message duration:(CGFloat)duration;

#define POST_SUCCESS_MSG(msg)   [[MessageCenter sharedInstance]postSuccessMessage:msg duration:1.5]
#define POST_ERROR_MSG(msg)     [[MessageCenter sharedInstance]postErrorMessage:msg duration:1.5]]

@end
