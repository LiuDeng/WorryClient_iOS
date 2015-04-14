//
//  QuickSignUpController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "QuickSignUpController.h"
#import "SignUpAndLoginView.h"
#import "UserService.h"

@interface QuickSignUpController ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UITextField *passwordTextField;
@property (nonatomic,strong)UIButton *signUpButton;

@property (nonatomic,strong)SignUpAndLoginView *signUpAndLoginView;

@end

@implementation QuickSignUpController

#pragma mark - Default methods

- (void)loadView
{
    [super loadView];
    [self loadSignUpAndLoginView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)loadSignUpAndLoginView
{
    NSString *phonePlaceholer = @"请输入手机" ;
    NSString *passwordPlaceholer = @"请输入密码";
    NSString *buttonTitle = @"注册";
    self.signUpAndLoginView = [[SignUpAndLoginView alloc]initWithAccountPlaceholder:phonePlaceholer
                                                                passwordPlaceholder:passwordPlaceholer
                                                                        buttonTitle:buttonTitle];
    [self.view addSubview:self.signUpAndLoginView];
    [self.signUpAndLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(self.view).with.dividedBy(3);
        make.width.equalTo(self.view);
    }];
    
    self.phoneTextField = self.signUpAndLoginView.accountTextField;
    self.passwordTextField = self.signUpAndLoginView.passwordTextField;
    self.signUpButton = self.signUpAndLoginView.button;
    
    self.phoneTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    [self.phoneTextField becomeFirstResponder];
    
    [self.signUpButton addTarget:self
                          action:@selector(clickSignUpButton)
                forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Utils

- (void)clickSignUpButton
{
    //  TODO
    NSString *phoneString = self.phoneTextField.text;
    NSString *passwordString = self.passwordTextField.text;
    
    if (phoneString.length == 0 || passwordString == 0) {
        //  TODO add tips
    }else{
        [UserService sharedInstance]quickSignUpByValue:phoneString password:passwordString userName:<#(NSString *)#> callback:<#^(PBUser *pbUser, NSError *error)callback#>

    }

}

#pragma mark - UITextFieldDelegate

//  点击“return”或者“Done”执行的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        return [textField becomeFirstResponder];
    }else if(textField == self.passwordTextField){
        [self clickSignUpButton];
        return [textField resignFirstResponder];
    }else{
        return YES;
    }
}

//  textField完成编辑之后
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        [textField becomeFirstResponder];
    }else if (textField == self.passwordTextField){
        [textField resignFirstResponder];
    }
}
@end
