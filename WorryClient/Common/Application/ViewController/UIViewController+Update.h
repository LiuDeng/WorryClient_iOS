//
//  UIViewController+Update.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/14.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIViewController+Worry.h"

@interface UIViewController (Update)

- (void)phoneResetPWD;
- (BOOL)isValidPWD:(NSString *)pwd;
@end
