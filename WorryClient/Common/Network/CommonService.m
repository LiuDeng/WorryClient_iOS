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

//- (void)shareContent:(NSString *)content title:(NSString *)title
//{
//    
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:@"分享"
//                                       defaultContent:@""
//                                                image:nil
//                                                title:@"ShareSDK"
//                                                  url:@"http://www.mob.com"
//                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
//                                            mediaType:SSPublishContentMediaTypeNews];
//    //定义菜单分享列表
//    NSArray *shareList = [ShareSDK getShareListWithType: ShareTypeSinaWeibo, ShareTypeSinaWeibo,ShareTypeSinaWeibo, nil];
//    
//    [ShareSDK oneKeyShareContent:publishContent
//                       shareList:shareList
//                     authOptions:nil
//                   statusBarTips:YES
//                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                              
//                              if (state == SSPublishContentStateSuccess)
//                              {
//                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
//                              }
//                              else if (state == SSPublishContentStateFail)
//                              {
////                                  NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
//                              }
//                          }];
//}


//- (void)shareContent:(NSString *)content title:(NSString *)title
//{
//    //创建分享参数
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:@"分享内容 @value(url)"
//                                     images:@[[UIImage imageNamed:]]
//                                        url:[NSURL URLWithString:@"http://mob.com"]
//                                      title:@"分享标题"
//                                       type:SSDKContentTypeImage];
//    
//    //进行分享
//    [ShareSDK share:SSDKPlatformTypeSinaWeibo
//         parameters:shareParams
//     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//         
//         switch (state) {
//             case SSDKResponseStateSuccess:
//             {
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                     message:nil
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                 break;
//             }
//             case SSDKResponseStateFail:
//             {
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                     message:[NSString stringWithFormat:@"%@", error]
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                 break;
//             }
//             case SSDKResponseStateCancel:
//             {
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                     message:nil
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                 break;
//             }
//             default:
//                 break;
//         }
//         
//     }];
//
//    
//}

@end
