//
//  WebViewController.m
//  MTAHybridDemo
//
//  Created by tyzual on 12/10/2017.
//  Copyright © 2017 tyzual. All rights reserved.
//

#import "WebViewController.h"

#import "MTAHybrid.h"

@interface WebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIButton *hideBtn;

@end

@implementation WebViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.webView = [UIWebView new];
	self.webView.translatesAutoresizingMaskIntoConstraints = NO;
	self.hideBtn = [UIButton buttonWithType:UIButtonTypeSystem];
	self.hideBtn.translatesAutoresizingMaskIntoConstraints = NO;
	[self.hideBtn setTitle:@"hide" forState:UIControlStateNormal];
	[self.hideBtn addTarget:self action:@selector(hideWebView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.webView];
	[self.view addSubview:self.hideBtn];
	[self setupConstraint];
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"app_link_h5" ofType:@"html"]];
	[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
	self.webView.delegate = self;
}

- (void)setupConstraint {
	[NSLayoutConstraint activateConstraints:@[
		[NSLayoutConstraint constraintWithItem:self.webView
									 attribute:NSLayoutAttributeTop
									 relatedBy:NSLayoutRelationEqual
										toItem:self.topLayoutGuide
									 attribute:NSLayoutAttributeBottom
									multiplier:1
									  constant:20],
		[NSLayoutConstraint constraintWithItem:self.webView
									 attribute:NSLayoutAttributeWidth
									 relatedBy:NSLayoutRelationEqual
										toItem:self.view
									 attribute:NSLayoutAttributeWidth
									multiplier:1
									  constant:0],
		[NSLayoutConstraint constraintWithItem:self.webView
									 attribute:NSLayoutAttributeCenterX
									 relatedBy:NSLayoutRelationEqual
										toItem:self.view
									 attribute:NSLayoutAttributeCenterX
									multiplier:1
									  constant:0],
		[NSLayoutConstraint constraintWithItem:self.webView
									 attribute:NSLayoutAttributeBottom
									 relatedBy:NSLayoutRelationEqual
										toItem:self.hideBtn
									 attribute:NSLayoutAttributeTop
									multiplier:1
									  constant:20],
		[NSLayoutConstraint constraintWithItem:self.hideBtn
									 attribute:NSLayoutAttributeBottom
									 relatedBy:NSLayoutRelationEqual
										toItem:self.bottomLayoutGuide
									 attribute:NSLayoutAttributeTop
									multiplier:1
									  constant:0],
		[NSLayoutConstraint constraintWithItem:self.hideBtn
									 attribute:NSLayoutAttributeLeft
									 relatedBy:NSLayoutRelationEqual
										toItem:self.view
									 attribute:NSLayoutAttributeLeft
									multiplier:1
									  constant:20],
	]];

	[self updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

	// 处理MTA混合统计请求的代码
	if ([MTAHybrid handleRequest:request fromWebView:webView]) {
		return NO;
	}

	// 原有的代码
	return YES;
}

- (void)hideWebView:(id)sender {
	// 点击隐藏按钮时
	// 根据webview是否显示开始，结束相关的统计
	if (self.webView.isHidden) {
		[self.hideBtn setTitle:@"hide" forState:UIControlStateNormal];
		[self.webView setHidden:NO];
		[MTAHybrid restartWebView:self.webView];
	} else {
		[self.hideBtn setTitle:@"show" forState:UIControlStateNormal];
		[self.webView setHidden:YES];
		[MTAHybrid stopWebView:self.webView];
	}
}

- (void)viewDidDisappear:(BOOL)animated {
	// viewDisappear时，结束统计
	[MTAHybrid stopWebView:self.webView];
}

- (void)viewDidAppear:(BOOL)animated {
	// viewAppear时，根据webView的状态决定是否开始统计
	if (!self.webView.isHidden)
		[MTAHybrid restartWebView:self.webView];
}

@end
