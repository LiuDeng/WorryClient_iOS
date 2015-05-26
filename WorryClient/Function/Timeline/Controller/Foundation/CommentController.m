//
//  CommentController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/26.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommentController.h"
#import "PlaceholderTextView.h"

@interface CommentController ()

@property (nonatomic,strong) PBFeed *pbFeed;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation CommentController

#pragma mark - Public methods

- (id)initWithPBFeed:(PBFeed *)pbFeed
{
    self = [super init];
    if (self) {
        self.pbFeed = pbFeed;
    }
    return self;
}

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
    self.title = @"添加回答";
    [self addRightButtonWithTitle:@"发布" target:self action:@selector(clickReleaseButton)];
    [self loadTextView];
    
}

#pragma mark - Private methods

- (void)loadTextView
{
    NSString *placeholder = @"请添加回答";
    self.textView = [[PlaceholderTextView alloc]initWithPlaceholder:placeholder];
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.view).with.multipliedBy(0.5);
    }];
}

#pragma mark - Utils

- (void)clickReleaseButton
{
    //  TODO
}

@end