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
#import "GuidePageController.h"

#ifdef DEBUG
//#import "QuickSignUpController.h"
#import "SignUpByEmailController.h"
#import "LogInController.h"


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

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
//}

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
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:kShareSDKAppKey
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo)]
                 onImport:nil
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
              
          }];

    
}

@end
