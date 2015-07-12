//
//  AppDelegate.m
//  WorryClient
//
//  Created by 蔡少武 on 15/2/17.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "AppDelegate.h"
#import "UserController.h"
#import "OmnibusController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "ViewDefault.h"
#import "WorryConfigManager.h"
#import "TimelineController.h"

#import <AVOSCloud/AVOSCloud.h>

//  ShareSDK
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "AVOSCloudSNS.h"

#import <SMS_SDK/SMS_SDK.h>

#ifdef DEBUG
//#import "QuickSignUpController.h"
#import "SignUpByEmailController.h"
#import "LogInController.h"
#import "GuidePageController.h"

#endif


@interface AppDelegate ()

@property (nonatomic,strong) UINavigationController *guidePageNavigatonController;

@end

@implementation AppDelegate

#pragma mark - Default methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // setup init tab bar controller
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    
    // show window now
    [self.window makeKeyAndVisible];

    //设置AVOSCloud
    [AVOSCloud setApplicationId:kAVOSCloudAppID
                      clientKey:kAVOSCloudAppKey];
    
    //统计应用启动情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [self addShareSDK];
//    [self loadGuidePage];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    return [ShareSDK handleOpenURL:url wxDelegate:nil];
    return [AVOSCloudSNS handleOpenURL:url];    //  TODO    不知道这样能否行得通
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
}

#pragma mark - Private methods

- (void)loadGuidePage
{
    GuidePageController *vc = [[GuidePageController alloc]init];
    self.guidePageNavigatonController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:self.guidePageNavigatonController];
}

- (void)showNormalHome
{
    if (self.guidePageNavigatonController){
        [self.guidePageNavigatonController dismissViewControllerAnimated:YES completion:^{
            self.guidePageNavigatonController = nil;
        }];
    }
    [self showHomePage];
}

-(void)showHomePage
{
    [self.window setRootViewController:self.viewController];
}

#pragma mark - Utils
- (UINavigationController*)currentNavigationController
{
    if ([self.viewController respondsToSelector:@selector(selectedViewController)]){
        UINavigationController *selectedNavigationController = [self.viewController performSelector:@selector(selectedViewController)];
        return selectedNavigationController;
    }else{
        return nil;
    }
}

- (UIViewController*)currentViewController
{
    return self.currentNavigationController.topViewController;
}

+ (AppDelegate*)sharedInstance
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate;
}
#pragma mark - Tab Bar Controller Methods

- (void)setupViewControllers {
    UIViewController *firstViewController = [[TimelineController alloc]init];
    firstViewController.title = @"心事";
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    
    UIViewController *secondViewController = [[OmnibusController alloc] init];
    secondViewController.title = @"精华";
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    
    UIViewController *thirdViewController = [[UserController alloc] init];
    thirdViewController.title = @"我";
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController,
                                           secondNavigationController,
                                           thirdNavigationController]];
    self.viewController = tabBarController;
    [self customizeTabBarForController:tabBarController];
}

#define TABBAR_IMAGE_TOP_INSETS 1
#define TABBAR_TITLE_FONT   ([UIFont systemFontOfSize:10])
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSArray *tabBarItemImages = @[@"timeline", @"omnibus", @"me"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {

        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.selectedTitleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:kTabbarNormalColor, NSForegroundColorAttributeName, TABBAR_TITLE_FONT, NSFontAttributeName, nil];
        item.unselectedTitleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:kTabbarSelectedColor, NSForegroundColorAttributeName, TABBAR_TITLE_FONT, NSFontAttributeName, nil];
        
        item.itemHeight = kTabBarHeight;
        
        UIOffset imagePosition = item.imagePositionAdjustment;
        imagePosition.vertical = TABBAR_IMAGE_TOP_INSETS;
        item.imagePositionAdjustment = imagePosition;
        
        UIImage *bgImage = [UIImage imageNamed:@"tabbar_bg"];
        [item setBackgroundSelectedImage:bgImage withUnselectedImage:bgImage];
        
        index++;
    }
}

- (void)addShareSDK
{
    [ShareSDK registerApp:kShareSDKAppKey];
    
    //  TODO 确定名称之后再注册
    
//    [ShareSDK connectSinaWeiboWithAppKey:kWeiboAppKey appSecret:kWeiboAppSecret redirectUri:kShareSDKRedirectUrl];
//    [ShareSDK connectSinaWeiboWithAppKey:kWeiboAppKey appSecret:kWeiboAppSecret redirectUri:kShareSDKRedirectUrl weiboSDKCls:[WeiboSDK class]];
    
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    
    //添加微信应用（注意：微信分享的初始化，下面是的初始化既支持微信登陆也支持微信分享，只用写其中一个就可以） 注册网址 http://open.weixin.qq.com
//    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
//                           wechatCls:[WXApi class]];

    //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
 
    //  SMS
    [SMS_SDK registerApp:kSMSSDKAppKey withSecret:kSMSSDKAppSecret];
    
}

@end
