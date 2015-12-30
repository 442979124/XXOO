//
//  BallSubjectViewController.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "BallSubjectViewController.h"
#import <WebKit/WebKit.h>

@interface BallSubjectViewController ()<WKNavigationDelegate>{
    WKWebView *_webView;
    UIActivityIndicatorView *_acView;
}

@end

@implementation BallSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWebView];
    // Do any additional setup after loading the view.
}
- (void)creatWebView
{
    WKWebViewConfiguration *cofd = [[WKWebViewConfiguration alloc] init];
    
    cofd.accessibilityNavigationStyle = UIAccessibilityNavigationStyleSeparate;
    cofd.allowsInlineMediaPlayback = YES;
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:cofd];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    _acView = [[UIActivityIndicatorView alloc] init];
    _acView.frame = CGRectMake(0, 0, 30, 30);
    _acView.center = self.view.center;
    [_acView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_acView];
    [self creatString];
}
- (void)creatString{
    NSString *string = [NSString stringWithFormat:@"http://games.mobileapi.hupu.com/1/7.0.5/nba/getNewsDetail?client=357139052148058&night=0&nid=",_model.nid];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [_acView startAnimating];
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    [_acView stopAnimating];
    
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    
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
