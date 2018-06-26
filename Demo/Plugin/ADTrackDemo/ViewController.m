//
//  ViewController.m
//  installTrackDemo
//
//  Created by xiang on 20/06/2017.
//  Copyright © 2017 xiangchen. All rights reserved.
//

#import "ViewController.h"
#import "ADTracker.h"

//static NSString* NameLinkReceivedNotification = @"NameLinkReceivedNotification";

@interface ViewController ()


@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
	[[ADTracker getInstance] startByViewDidload:YES];
    
    //帐号注册
    [[ADTracker getInstance] trackRegAccountEvent:ADAccountMobile account:@"18666666666"];
    
    //付费
    [[ADTracker getInstance] trackUserPayEvent:ADPayCNY orderID:@"123456" payNum:100.00 payType:@"WX"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
