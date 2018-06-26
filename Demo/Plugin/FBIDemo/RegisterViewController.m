//
//  RegisterViewController.m
//  MTACreditDemo
//
//  Created by xiang on 01/09/2017.
//  Copyright © 2017 xiangchen. All rights reserved.
//

#import "RegisterViewController.h"
#import "FBI.h"

@interface RegisterViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation RegisterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"fbi_demo" ofType:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL fileURLWithPath:path]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    //如果要自定义delegate,在之后进行FBI绑定。如果失败，尝试之前绑定。
    [[FBI getInstance] bindToWebView:_webView preDelegate:self];
    
    //和第三方开源库EasyJSWebView的兼容写法，解决复杂情况的delegate冲突
//    id FBIWebDelegate = [[FBI getInstance] bindToWebView:self.myWebView preDelegate:self];
//    self.myWebView.delegate = FBIWebDelegate;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"orgi shouldStartLoadWithRequest");
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
