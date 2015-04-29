//
//  EditController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/27.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "DefaultViewController.h"

typedef void (^EditSaveBlock) (NSString* text);

@interface EditController : DefaultViewController

- (id)initWithText:(NSString*)editText
   placeHolderText:(NSString*)placeHolderText
              tips:(NSString*)tips
           isMulti:(BOOL)isMulti
   saveActionBlock:(EditSaveBlock)saveActionBlock;

@property (nonatomic,strong) NSString* editText;
@property (nonatomic,strong) NSString* placeHolderText;
@property (nonatomic,strong) NSString* tips;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic, copy) EditSaveBlock saveActionBlock;

- (void)loadSaveButton;

@end