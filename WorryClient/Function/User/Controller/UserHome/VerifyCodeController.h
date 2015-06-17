//
//  VerifyCodeController.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"

typedef void(^VerifySuccessAction) (NSString *phone,NSString *areaCode);

@interface VerifyCodeController : UIViewController

@property (nonatomic,strong) VerifySuccessAction verifySuccessAction;

- (instancetype)initWithPhone:(NSString *)phone
                     areaCode:(NSString *)areaCode
          verifySuccessAction:(VerifySuccessAction)verifySuccessAction;

@end
