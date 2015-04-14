//
//  SignUpAndLoginView.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpAndLoginView : UIView

@property (nonatomic,strong)UITextField *accountTextField;
@property (nonatomic,strong)UITextField *passwordTextField;
@property (nonatomic,strong)UIButton *button;

//-(instancetype)initWithAccount:(NSString*)accountPlaceholder
//                      password:(NSString*)passwordPlaceholder
//                        button:(NSString*)buttonTitle
//                    controller:(id)controller
//                  buttonAction:(SEL)action;
-(id)initWithAccountPlaceholder:(NSString*)accountPlaceholder
            passwordPlaceholder:(NSString*)passwordPlaceholder
                    buttonTitle:(NSString*)buttonTitle;

@end
