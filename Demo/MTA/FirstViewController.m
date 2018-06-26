//
//  FirstViewController.m
//  MTA-Demo
//
//  Created by WQY on 12-12-10.
//  Copyright (c) 2012年 developer. All rights reserved.
//

#import "FirstViewController.h"
#import "MTA.h"
#import "MTAConfig.h"

@interface FirstViewController ()
@end

@implementation FirstViewController

- (IBAction)clickNormaltButton:(id)sender {
	[MTA trackCustomKeyValueEvent:@"NormalEvent" props:@{ @"para1": @"value1" }];

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
													message:@"生成普通事件"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];

	[alert show];
}

- (IBAction)clickErrorButton:(id)sender {
	[MTA trackError:@"I\'m an unexpected error"];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
													message:@"生成Error事件"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

- (IBAction)clickStartButton:(id)sender {
	[MTA trackCustomKeyValueEventBegin:@"TimeEvent" props:nil];

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
													message:@"开始计时事件"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}
- (IBAction)clickEndButton:(id)sender {
	[MTA trackCustomKeyValueEventEnd:@"TimeEvent" props:nil];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
													message:@"结束计时事件"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = NSLocalizedString(@"页面1", @"页面1");
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
	}
	return self;
}

@end
