//
//  BaseWebViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseWebViewController.h"
#import "BaseHead.h"
@interface BaseWebViewController ()<UIWebViewDelegate>
{
    UIView *_hiddenView;
    HUProgressView *_progress;
    UIImageView *_horseimage;
}
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"骏途旅游";
    [self _creatWebView];
    [self _creatBackButton];
}
//返回按钮
-(void)_creatBackButton{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"back2x1"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
}
//设置返回动作
-(void)leftButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)_creatWebView{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *reuqest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:reuqest];
    webView.delegate = self;
    [self.view addSubview:webView];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    //遮罩视图
//    _hiddenView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _hiddenView.backgroundColor = [UIColor lightGrayColor];
//    _hiddenView.alpha = 0.4;
//    _hiddenView.hidden = NO;
//    _progress = [[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
//    _progress.center = _hiddenView.center;
//    _progress.strokeColor = [UIColor cyanColor];
//    [_hiddenView addSubview:_progress];
//    [_progress startProgressAnimating];
//    _horseimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
//    _horseimage.center = _hiddenView.center;
//    _horseimage.image = [UIImage imageNamed:@"ma"];
//    
//    [self.view addSubview:_horseimage];
//    [self.view addSubview:_progress];
//    [self.view addSubview:_hiddenView];
    
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    [_hiddenView removeFromSuperview];
//    [_progress removeFromSuperview];
//    [_horseimage removeFromSuperview];
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
