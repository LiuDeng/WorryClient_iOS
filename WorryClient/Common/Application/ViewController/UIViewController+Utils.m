//
//  UIViewController+Utils.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/22.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

#pragma mark - Public methods

- (void)addRightButtonWithTitle:(NSString*)title
                         target:(id)target
                         action:(SEL)action
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:title
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:target
                                                                   action:action];
    [rightButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)addRightButtonWithImageName:(NSString*)imageName
                             target:(id)target
                             action:(SEL)action
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:target
                                                                   action:action];
    [rightButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)loadBackButtonWithImageName:(NSString *)imageName
{
    //默认首页放在navigationController不pop
    int count = 1;
    if (self.navigationController.viewControllers.count > count) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(clickBackButton)];
        
    
//                backButton.imageInsets = UIEdgeInsetsMake(0, NAVBARLEFT_BUTTON_INSET_LEFT, 0, 0);
        self.navigationItem.leftBarButtonItem = backButton;
    }
}

- (void)loadBackButton
{
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

#pragma mark - Private methods

-(void)clickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
