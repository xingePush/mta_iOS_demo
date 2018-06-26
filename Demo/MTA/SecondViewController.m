//
//  SecondViewController.m
//  MTA-Demo
//
//  Created by WQY on 12-12-10.
//  Copyright (c) 2012年 developer. All rights reserved.
//

#import "SecondViewController.h"
#import "MTA.h"

@implementation SecondViewController

- (IBAction)duration:(id)sender {
	[MTA trackCustomKeyValueEventDuration:10 withEventid:@"Duration" props:nil];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
													message:@"生成时长事件"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

- (IBAction)clickExceptionButton:(id)sender {
	NSException *ex = [NSException exceptionWithName:@"DemoException" reason:@"NoReason" userInfo:nil];
	[MTA trackException:ex];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event"
													message:@"生成Exception"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = NSLocalizedString(@"页面2", @"页面2");
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
	}
	return self;
}

@end
