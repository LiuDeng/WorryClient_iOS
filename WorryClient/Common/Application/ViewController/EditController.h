//
//  EditController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/27.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"

typedef void (^EditSaveBlock) (NSString* text);

@interface EditController : UIViewController

- (id)initWithText:(NSString*)editText
       placeholder:(NSString*)placeholder
              tips:(NSString*)tips
           isMulti:(BOOL)isMulti
   saveActionBlock:(EditSaveBlock)saveActionBlock;

@property (nonatomic,strong) NSString* editText;
@property (nonatomic,strong) NSString* placeholder;
@property (nonatomic,strong) NSString* tips;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic, copy) EditSaveBlock saveActionBlock;

- (void)loadSaveButton;

@end
