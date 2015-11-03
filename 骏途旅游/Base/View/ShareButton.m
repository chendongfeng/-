//
//  ShareButton.m
//  骏途旅游
//
//  Created by mac10 on 15/10/26.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "ShareButton.h"
#import "BaseHead.h"
#import "UIView+UIViewController.h"
#import "TabBarButton.h"
#import <ShareSDK/ShareSDK.h>
@implementation ShareButton
{
    UIView *_shareView;
    UIButton *_hiddenView;
    UITextView *_textView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setNeedsDisplay];
    }
    return self;
}
-(void)layoutSubviews{
   
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share2@x"]];
    imageView.frame = CGRectMake(10, 10, 20, 20);
    
    [self addSubview:imageView];
    [self addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
}


//打开分享视图
-(void)shareAction{
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-320, kScreenWidth, 80)];
    _shareView.backgroundColor = [UIColor whiteColor];
    [self.viewController.view addSubview:_shareView];
    NSArray *images = @[@"more_weixin",@"more_circlefriends",@"more_weibo",@"more_mms",@"more_weimigroup"];
    NSArray *names = @[@"微信好友",@"朋友圈",@"新浪微博",@"短信",@"复制"];
    //添加子视图
    CGFloat width = kScreenWidth/5;
    for(int i = 0;i<5;i++){
        TabBarButton *button = [[TabBarButton alloc]initWithTitle:names[i] imageName:images[i] frame:CGRectMake(width*i, 20, width,60)];
        button.tag = 100+i;
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:button];
    }
    //提示label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text = @"分享到";
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:13];
    [_shareView addSubview:label];
    //遮罩视图
    _hiddenView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-420)];
    _hiddenView.backgroundColor = [UIColor lightGrayColor];
    _hiddenView.alpha = 0.4;
    _hiddenView.hidden = NO;
    [_hiddenView addTarget:self action:@selector(removeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.viewController.view addSubview:_hiddenView];
    
    //创建编辑框
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, kScreenHeight-420, kScreenWidth, 100)];
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.layer.borderWidth = 2;
    [self.viewController.view addSubview:_textView];

    [_textView becomeFirstResponder];
    
    
}
-(void)removeAction{
    [_hiddenView removeFromSuperview];
    [_shareView removeFromSuperview];
    [_textView removeFromSuperview];
}
-(void)buttonAction:(UIButton *)button{
    
    NSLog(@"分享");
    if(button.tag==102){
     NSLog(@"分享到微博");
    [self shareToWeibo];
    }
    if(button.tag==101){
        NSLog(@"分享到微信");
        [self shareToWeChat];
    }
    [_shareView removeFromSuperview];
    [_hiddenView removeFromSuperview];
    [_textView removeFromSuperview];
}
-(void)shareToWeChat{
    //配置参数
      NSString *string = [ NSString stringWithFormat:@"%@@value(url)",_textView.text];
     NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupWeChatParamsByText:string title:@"测试" url:[NSURL URLWithString:@"http://www.juntu.com"] thumbImage:[UIImage imageNamed:@"1136_img_launch"] image:nil musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformTypeWechat];
    //分享实现
    [ShareSDK share:SSDKPlatformTypeWechat parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch(state){
            case SSDKResponseStateSuccess:
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:@"恭喜你" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:@"检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            case SSDKResponseStateCancel:{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享取消" message:@"您取消了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }

        
    }];
    
}

-(void)shareToWeibo{
    //遮罩视图
    UIView *hiddenView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    hiddenView.backgroundColor = [UIColor lightGrayColor];
    hiddenView.alpha = 0.4;
    hiddenView.hidden = NO;
    HUProgressView *progress = [[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
    progress.center = hiddenView.center;
    progress.strokeColor = [UIColor cyanColor];
    [hiddenView addSubview:progress];
    [progress startProgressAnimating];
    UIImageView *horseimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    horseimage.center = hiddenView.center;
    horseimage.image = [UIImage imageNamed:@"ma"];
    
    [self.superview addSubview:horseimage];
    [self.superview addSubview:progress];
    [self.superview addSubview:hiddenView];
    
    //需要传入图片、链接
    //文字分享
    NSString *string = [ NSString stringWithFormat:@"%@@value(url)",_textView.text];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:string images:@[[UIImage imageNamed:@"1136_img_launch"]] url:[NSURL URLWithString:@"http://www.juntu.com"] title:@"分享标题" type:SSDKContentTypeImage];
    [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
      
            [horseimage removeFromSuperview];
            [progress removeFromSuperview];
            [hiddenView removeFromSuperview];
       
   
        switch(state){
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:@"恭喜你" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:@"检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            case SSDKResponseStateCancel:{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享取消" message:@"您取消了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];

}


@end
