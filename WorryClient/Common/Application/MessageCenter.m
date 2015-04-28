//
//  MessageCenter.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "MessageCenter.h"
#import "AppDelegate.h"
#import "ColorInfo.h"

@implementation MessageCenter

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(MessageCenter)

- (void)postSuccessMessage:(NSString *)message duration:(CGFloat)duration
{
    [self postMessage:message duration:duration];
}
-(void)postErrorMessage:(NSString *)message duration:(CGFloat)duration
{
    [self postMessage:message duration:duration];
}

#pragma mark - Private methods

- (void)postMessage:(NSString *)message duration:(CGFloat)duration
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[AppDelegate sharedInstance].window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 7.0f;
    hud.color = kMessageCenterBackgroundColor;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:duration];
}
@end
