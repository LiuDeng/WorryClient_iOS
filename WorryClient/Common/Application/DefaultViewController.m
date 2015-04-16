//
//  DefaultViewController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "DefaultViewController.h"

@interface DefaultViewController ()
@property (nonatomic,strong) NSString* backButtonText;
@end

@implementation DefaultViewController

#pragma mark -Default methods

-(void)loadView
{
    [super loadView];
    [self setupBackButton];
}

-(void)setupBackButton
{
    
    int count = 1; //默认首页放在navigationController不pop
    if (self.navigationController.viewControllers.count > count) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow"]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(backClick)];
        
        
//        backButton.imageInsets = UIEdgeInsetsMake(0, NAVBARLEFT_BUTTON_INSET_LEFT, 0, 0);
        backButton.title = self.backButtonText;
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setNavBackButtonText:(NSString*)text
{
    self.backButtonText = [text copy];
}

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

@end
