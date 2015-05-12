//
//  SendBlessingController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/10.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "SendBlessingController.h"

@interface SendBlessingController ()

@end

@implementation SendBlessingController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.title = @"祝福";
    [self test];
}

#pragma mark - Private methods

- (void)test
{
    UIImage *image = [UIImage imageNamed:@"send_blessing_test"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
}

@end
