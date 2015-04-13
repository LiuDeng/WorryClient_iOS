//
//  AppDelegate.h
//  WorryClient
//
//  Created by 蔡少武 on 15/2/17.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

- (UINavigationController*)currentNavigationController;

- (UIViewController*)currentViewController;

+ (AppDelegate*)sharedInstance;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

@end

