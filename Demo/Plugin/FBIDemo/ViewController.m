//
//  ViewController.m
//  MTACreditDemo
//
//  Created by xiang on 01/08/2017.
//  Copyright © 2017 xiangchen. All rights reserved.
//

#import "ViewController.h"
#import "FBI.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

@property (weak, nonatomic) IBOutlet UIButton *btnCommon;

@property (weak, nonatomic) IBOutlet UIButton *btnSumbit;

@property (weak, nonatomic) IBOutlet UIButton *btnReg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [[FBI getInstance] trackPageBegin:@"LOGIN" extendInfo:nil];
}
- (IBAction)btnStopClick:(id)sender {
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[FBI getInstance] trackPageEnd:@"LOGIN" duration:1000 extendInfo:nil];
}

- (IBAction)txtUserNameEditingDidBegin:(id)sender {
    [[FBI getInstance] trackOnFocusChange:@"INPUT_LOGIN_USER_ID" isFocus:YES extendInfo:nil];
}


- (IBAction)txtUserNameEditingDidEnd:(id)sender {
    [[FBI getInstance] trackOnFocusChange:@"INPUT_LOGIN_USER_ID" isFocus:NO extendInfo:nil];
}


- (IBAction)txtUserNameEditingChanged:(id)sender {
    [[FBI getInstance] trackOnTextChange:@"INPUT_LOGIN_USER_ID" txtValue:_txtUserName.text needEncoding:true extendInfo:nil];
}


- (IBAction)btnCommonClick:(id)sender {
    [[FBI getInstance] trackOnClick:@"CLICK_FORGET_PASSWORD" extendInfo:nil];
}

- (IBAction)btnSubmit:(id)sender {
    //提交
    [[FBI getInstance] trackOnSubmit:@"SUBMIT_LOGIN" result:YES msg:@"提交成功" extendInfo:nil];
    
    //登录成功
    [[FBI getInstance] trackOnLoginSuccess:@"PASSWORD" userID:_txtUserName.text extendInfo:nil];
    
    //注销
//    [[FBI getInstance] trackOnLogout:nil];
}



- (IBAction)btnRegClick:(id)sender {
    [self performSegueWithIdentifier:@"segRegister" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
