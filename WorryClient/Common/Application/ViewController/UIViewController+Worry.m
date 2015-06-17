//
//  UIViewController+Worry.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/6.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"

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
