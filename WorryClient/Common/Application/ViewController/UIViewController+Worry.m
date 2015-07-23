//
//  UIViewController+Worry.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/6.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/ShareSDKUI.h>

#define kLogInTitle     @"登录"

@implementation UIViewController (Worry) 

- (void)loadData
{
    //  这个要去掉的。
}

#pragma mark - Public methods

- (void)loadLogInAlertView
{
    NSString *message = @"您尚未登录，请先登录";
    NSString *cancelTitle = @"取消";
    UIAlertView *logInAlertView = [[UIAlertView alloc]initWithTitle:message
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:kLogInTitle,nil];
    [logInAlertView show];
}

- (void)hideTabBar
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)showTabBar
{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)customizeNavigationBar
{
    //    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UINavigationBar *navigationBarAppearance = self.navigationController.navigationBar;
    UIImage* backgroundImage = [UIImage imageNamed:@"barbg64.png"];
    
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];    //  must
}

/**
 *  显示分享菜单
 *
 *  @param view 容器视图
 */
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
//    __weak ViewController *theController = self;
    //1、创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSArray* imageArray = @[[UIImage imageNamed:@"avatar_male"]];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeImage];
        
        //1.1、QQ空间不支持SSDKContentTypeImage这种类型，所以需要定制下。
        [shareParams SSDKSetupQQParamsByText:@"QQ空间分享"
                                       title:@"分享标题"
                                         url:[NSURL URLWithString:@"http://mob.com"]
                                  thumbImage:nil
                                       image:[UIImage imageNamed:@"shareImg.png"]
                                        type:SSDKContentTypeWebPage
                          forPlatformSubType:SSDKPlatformSubTypeQZone];
        
        //1.2、设置分享编辑页面样式（optional）
        //    [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithRed:249/255.0 green:0/255.0 blue:12/255.0 alpha:0.5]];
        //    [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
        //    [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
        //    [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor whiteColor]];
        //    [SSUIShareActionSheetStyle setItemNameColor:[UIColor whiteColor]];
        //    [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
        //    [SSUIShareActionSheetStyle setCurrentPageIndicatorTintColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0]];
        //    [SSUIShareActionSheetStyle setPageIndicatorTintColor:[UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]];
        
        //2、分享
        [ShareSDK showShareActionSheet:view
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                               
                           case SSDKResponseStateBegin:
                           {
//                               [theController showLoadingView:YES];
                               break;
                           }
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@", error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateCancel:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           default:
                               break;
                       }
                       
                       if (state != SSDKResponseStateBegin)
                       {
//                           [theController showLoadingView:NO];
//                           [theController.tableView reloadData];
                       }
                       
                   }];
        
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if (buttonIndex == alertView.cancelButtonIndex) {
        alertView.hidden = YES;
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if([buttonTitle isEqualToString:kLogInTitle]){
        LogInController *vc = [[LogInController alloc]init];
//        [self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}


@end
