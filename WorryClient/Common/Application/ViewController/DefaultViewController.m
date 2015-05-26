//
//  DefaultViewController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "DefaultViewController.h"
#import "RDVTabBarController.h"


@interface DefaultViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) NSString* backButtonText;
@property (nonatomic,strong) UIAlertView *logInAlertView;
@end

#define kLogInTitle     @"登录"

@implementation DefaultViewController

#pragma mark - Public methods

- (void)loadLogInAlertView
{
    NSString *message = @"您尚未登录，请先登录";
    NSString *cancelTitle = @"取消";
    self.logInAlertView = [[UIAlertView alloc]initWithTitle:message
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:cancelTitle
                                          otherButtonTitles:kLogInTitle,nil];
    [self.logInAlertView show];
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

#pragma mark -Default methods

-(void)loadView
{
    [super loadView];
    [self loadData];
    
    if (self.isHideTabBar) {
        [self hideTabBar];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self customizeNavigationBar];
    [self loadBackButton];
}

- (void)loadData
{
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.isHideTabBar) {
        [self showTabBar];
    }
}
#pragma mark - Private methods


#pragma mark - Utils


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if (buttonIndex == alertView.cancelButtonIndex) {
        self.logInAlertView.hidden = YES;
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if([buttonTitle isEqualToString:kLogInTitle]){
        LogInController *vc = [[LogInController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}
@end
