//
//  ViewController.m
//  mtaLBSDemo
//
//  Created by xiang on 01/11/2017.
//  Copyright © 2017 developer. All rights reserved.
//

#import "ViewController.h"
#import "MTALBS.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIButton *btnStop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnStartClick:(id)sender {
    [[MTALBS getInstance] start];
}

- (IBAction)btnStopClick:(id)sender {
    [[MTALBS getInstance] stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
