//
//  WViewControllerIntercepter.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/6.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "WViewControllerIntercepter.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
#import "UIViewController+Worry.h"

@implementation WViewControllerIntercepter
{
    NSArray *_showTabBarClasses;
}

+ (void)load
{
    [super load];
    [WViewControllerIntercepter sharedInstance];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WViewControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WViewControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /* 在这里做好方法拦截 */
        [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            [self loadView:[aspectInfo instance]];
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            [self viewWillAppear:[aspectInfo instance]];
        }error:nil];

    }
    return self;
}


- (void)loadView:(UIViewController *)viewController
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [viewController customizeNavigationBar];
    [viewController loadBackButton];
    [viewController loadData];
}

- (void)viewWillAppear:(UIViewController *)viewController
{
    /*  There maybe a trouble.
     *  If you want to hide tab bar or show tab bar customlly,
     *  it's not easy to do.
     *  Maybe it will be dealed in the future.
     */
    
    NSUInteger count = (unsigned long)viewController.navigationController.viewControllers.count;
    if (count > 1) {
        [viewController hideTabBar];
    }else{
        [viewController showTabBar];
    }
}

@end
