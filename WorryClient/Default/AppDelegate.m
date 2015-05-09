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
#import "ViewInfo.h"
#import "ColorInfo.h"

#import <AVOSCloud/AVOSCloud.h>
#import "WorryConfigManager.h"
#import "TimelineController.h"

#ifdef DEBUG

#import "QuickSignUpController.h"
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
//    [self.window setRootViewController:self.viewController];
    
    // show window now
    [self.window makeKeyAndVisible];

    //设置AVOSCloud
    [AVOSCloud setApplicationId:kAVOSCloudAppID
                      clientKey:kAVOSCloudAppKey];
    
    //统计应用启动情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    [self loadGuidePage];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
@end
