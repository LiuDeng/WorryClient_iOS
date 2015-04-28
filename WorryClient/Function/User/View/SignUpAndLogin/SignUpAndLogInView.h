//
//  SignUpAndLogInView.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpAndLogInView : UIView

@property (nonatomic,strong)UITextField *accountTextField;
@property (nonatomic,strong)UITextField *passwordTextField;
@property (nonatomic,strong)UIButton *button;

-(id)initWithAccountPlaceholder:(NSString*)accountPlaceholder
            passwordPlaceholder:(NSString*)passwordPlaceholder
                    buttonTitle:(NSString*)buttonTitle;

@end
