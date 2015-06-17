//
//  EditController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/27.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "EditController.h"
#import "UIView+DefaultView.h"
#import "PlaceholderTextView.h"

@interface EditController ()<UITextViewDelegate>

@property (nonatomic,assign)BOOL isMulti;

@end

@implementation EditController

#pragma mark - Default methods

- (id)initWithText:(NSString *)editText
       placeholder:(NSString *)placeholder
              tips:(NSString *)tips
           isMulti:(BOOL)isMulti
   saveActionBlock:(EditSaveBlock)saveActionBlock
{
    self = [super init];
    self.editText = editText;
    self.placeholder = placeholder;
    self.tips = tips;
    self.saveActionBlock = saveActionBlock;
    self.isMulti = isMulti ? isMulti : NO;
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = kBGColor;
    self.isMulti ? [self loadTextView] : [self loadTextField];
    [self loadTipsLabel];
    [self loadSaveButton];
}

#pragma mark - Private methods

- (void)loadTextField
{
    self.textField = [UITextField defaultTextField:self.placeholder superView:self.view];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).with.offset(+kVerticalPadding*2);
    }];
    self.textField.text = self.editText;

    [self.textField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
}

- (void)loadTextView
{
    //  TODO    这部分有待调整
    NSString *placeholder = self.editText ? nil : self.placeholder;
    self.textView = [[PlaceholderTextView alloc]initWithPlaceholder:placeholder
                                                   placeholderColor:nil
                                                    placeholderFont:nil];
    [self.view addSubview:self.textView];
    self.textView.text = self.editText;
    self.textView.delegate = self;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(+kVerticalPadding);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.view).with.multipliedBy(kTextViewHeightScale);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadTipsLabel
{
    self.tipsLabel = [[UILabel alloc]init];
    self.tipsLabel.text = self.tips;
    self.tipsLabel.textAlignment =  NSTextAlignmentCenter;
    self.tipsLabel.font = kMiddleLabelFont;
    [self.view addSubview:self.tipsLabel];
    self.tipsLabel.textColor = [UIColor grayColor];
    UIView *preView = (self.isMulti ? self.textView : self.textField);
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(preView.mas_bottom).with.multipliedBy(kTopScale);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadSaveButton
{
    [self addRightButtonWithTitle:@"提交" target:self action:@selector(clickSaveButton:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

#pragma mark - Utils

- (void)clickSaveButton:(id)sender
{
    NSString *text = self.isMulti ? self.textView.text : self.textField.text;
    EXECUTE_BLOCK(self.saveActionBlock, text);
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (void)valueChanged:(UITextField *)textField
{
    if (textField.text.length>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}
@end
