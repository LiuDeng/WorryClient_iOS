//
//  CommonService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonService.h"

//const CGFloat kUpdateImageQuality = 1.0f;

@implementation CommonService

- (void)updateImage:(UIImage *)image imageName:(NSString *)imageName block:(ServiceImageBlock)block
{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    AVFile *avFile = [AVFile fileWithName:imageName data:imageData];
    [avFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
            EXECUTE_BLOCK(block,error,avFile.url);
//        }
    }];
}

- (void)shareContent:(NSString *)content title:(NSString *)title
{
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享"
                                       defaultContent:@""
                                                image:nil
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    //定义菜单分享列表
    NSArray *shareList = [ShareSDK getShareListWithType: ShareTypeSinaWeibo, ShareTypeSinaWeibo,ShareTypeSinaWeibo, nil];
    
    [ShareSDK oneKeyShareContent:publishContent
                       shareList:shareList
                     authOptions:nil
                   statusBarTips:YES
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                              }
                              else if (state == SSPublishContentStateFail)
                              {
//                                  NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                              }
                          }];
}
@end
