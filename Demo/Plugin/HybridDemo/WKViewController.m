//
//  ViewController.m
//  MTAHybridDemo
//
//  Created by tyzual on 22/09/2017.
//  Copyright © 2017 tyzual. All rights reserved.
//

#import "WKViewController.h"

#import <WebKit/WebKit.h>

#import "MTAHybrid.h"


@interface WKViewController () <WKNavigationDelegate>

@property (strong, nonatomic) IBOutlet WKWebView *wkWebView;
@property (strong, nonatomic) IBOutlet UIButton *hideBtn;

@end

@implementation WKViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.wkWebView = [WKWebView new];
	self.wkWebView.translatesAutoresizingMaskIntoConstraints = NO;
	self.hideBtn = [UIButton buttonWithType:UIButtonTypeSystem];
	self.hideBtn.translatesAutoresizingMaskIntoConstraints = NO;
	[self.hideBtn setTitle:@"hide" forState:UIControlStateNormal];
	[self.hideBtn addTarget:self action:@selector(hideWebView:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.wkWebView];
	[self.view addSubview:self.hideBtn];
	[self setupConstraint];

	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"app_link_h5" ofType:@"html"]];
	[self.wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
	self.wkWebView.navigationDelegate = self;
}

- (void)setupConstraint {
	[NSLayoutConstraint activateConstraints:@[
		[NSLayoutConstraint constraintWithItem:self.wkWebView
									 attribute:NSLayoutAttributeTop
									 relatedBy:NSLayoutRelationEqual
										toItem:self.topLayoutGuide
									 attribute:NSLayoutAttributeBottom
									multiplier:1
									  constant:20],
		[NSLayoutConstraint constraintWithItem:self.wkWebView
									 attribute:NSLayoutAttributeWidth
									 relatedBy:NSLayoutRelationEqual
										toItem:self.view
									 attribute:NSLayoutAttributeWidth
									multiplier:1
									  constant:0],
		[NSLayoutConstraint constraintWithItem:self.wkWebView
									 attribute:NSLayoutAttributeCenterX
									 relatedBy:NSLayoutRelationEqual
										toItem:self.view
									 attribute:NSLayoutAttributeCenterX
									multiplier:1
									  constant:0],
		[NSLayoutConstraint constraintWithItem:self.wkWebView
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

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

	// 处理MTA混合统计请求的代码
	if ([MTAHybrid handleAction:navigationAction fromWKWebView:webView]) {
		decisionHandler(WKNavigationActionPolicyCancel);
		return;
	}

	// 原有的代码
	decisionHandler(WKNavigationActionPolicyAllow);
}

- (IBAction)hideWebView:(id)sender {
	// 点击隐藏按钮时
	// 根据webview是否显示开始，结束相关的统计
	if (self.wkWebView.isHidden) {
		[self.hideBtn setTitle:@"hide" forState:UIControlStateNormal];
		[self.wkWebView setHidden:NO];
		[MTAHybrid restartWKWebView:self.wkWebView];
	} else {
		[self.hideBtn setTitle:@"show" forState:UIControlStateNormal];
		[self.wkWebView setHidden:YES];
		[MTAHybrid stopWKWebView:self.wkWebView];
	}
}

- (void)viewDidDisappear:(BOOL)animated {
	// viewDisappear时，结束统计
	[MTAHybrid stopWKWebView:self.wkWebView];
}

- (void)viewDidAppear:(BOOL)animated {
	// viewAppear时，根据webView的状态决定是否开始统计
	if (!self.wkWebView.isHidden)
		[MTAHybrid restartWKWebView:self.wkWebView];
}

@end
