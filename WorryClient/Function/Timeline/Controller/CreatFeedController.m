//
//  CreatFeedController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CreatFeedController.h"
#import "PlaceholderTextView.h"

@interface CreatFeedController ()
@property (nonatomic,strong)PlaceholderTextView *placeholderTextView;
@property (nonatomic,strong)UITextField *titleTextField;

@end

@implementation CreatFeedController

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
    [self loadTitleTextField];
    [self loadPlaceholderTextView];
}

#pragma mark - Private methods
- (void)loadTitleTextField
{
    self.titleTextField = [[UITextField alloc]init];
    [self.view addSubview:self.titleTextField];
    self.titleTextField.placeholder = @"标题";
    
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
//        make.height.equalTo(self)
    }];
}

- (void)loadPlaceholderTextView
{
    NSString *placeholder = @"你的心事，我在乎，说说你的心事吧";
    self.placeholderTextView = [[PlaceholderTextView alloc]initWithPlaceholder:placeholder placeholderColor:nil placeholderFont:nil];
    [self.view addSubview:self.placeholderTextView];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(0.3);
        make.top.equalTo(self.titleTextField.mas_bottom).with.offset(+1);
    }];
}
#pragma mark - Utils

@end
