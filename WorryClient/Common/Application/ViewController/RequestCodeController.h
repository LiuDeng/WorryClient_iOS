//
//  RequestCodeController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"
#import "VerifyCodeController.h"

@interface RequestCodeController : UIViewController

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITextField *areaCodeField;    // area code
@property (nonatomic,strong) VerifySuccessAction verifySuccessAction;

- (instancetype)initWithVerifySuccessAction:(VerifySuccessAction) verifySuccessAction;

@end
