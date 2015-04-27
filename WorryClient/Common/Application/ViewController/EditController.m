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

@interface EditController ()

@property (nonatomic,assign)BOOL isMulti;

@end

@implementation EditController

#pragma mark - Default methods

- (id)initWithText:(NSString *)editText
   placeHolderText:(NSString *)placeHolderText
              tips:(NSString *)tips
           isMulti:(BOOL)isMulti
   saveActionBlock:(EditSaveBlock)saveActionBlock
{
    self = [super init];
    self.editText = editText;
    self.placeHolderText = placeHolderText;
    self.tips = tips;
    self.saveActionBlock = saveActionBlock;
    self.isMulti = isMulti ? isMulti : NO;
    return self;
}

- (void)loadView
{
    [super loadView];
    self.isMulti ? [self loadTextView] : [self loadTextField];
    [self loadTipsLabel];
    [self loadSaveButton];
}

#pragma mark - Private methods

- (void)loadTextField
{
    self.textField = [UITextField defaultTextField:self.editText superView:self.view];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.multipliedBy(kTopScale);
    }];
    self.textField.text = self.editText;

}

- (void)loadTextView
{
    NSString *placeHolderString = self.editText ? nil : self.placeHolderText;
    self.textView = [[PlaceholderTextView alloc]initWithPlaceholder:placeHolderString
                                                   placeholderColor:nil
                                                    placeholderFont:nil];
    [self.view addSubview:self.textView];
    self.textView.text = self.editText;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.multipliedBy(kTopScale);
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
    self.tipsLabel.font = kMiddleLabelFont;   //  字体
    [self.view addSubview:self.tipsLabel];
    
    UIView *preView = (self.isMulti ? self.textView : self.textField);
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(preView.mas_bottom).with.multipliedBy(kTopScale);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadSaveButton
{
    [self addRightButtonWithTitle:@"提交" target:self action:@selector(clickSaveButton:)];
}

#pragma mark - Utils

- (void)clickSaveButton:(id)sender
{
    [self save];
}

- (void)save
{
    NSString *text = self.isMulti ? self.textView.text : self.textField.text;
    EXECUTE_BLOCK(self.saveActionBlock, text);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
