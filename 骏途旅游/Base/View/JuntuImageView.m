//
//  JuntuImageView.m
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "JuntuImageView.h"
#import "UIView+UIViewController.h"
#import "BaseWebViewController.h"
#import "BaseNaviViewController.h"
@implementation JuntuImageView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = YES;

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self _creatWebView];
    BaseWebViewController *web = [[BaseWebViewController alloc] init];
    BaseNaviViewController *nav = [[BaseNaviViewController alloc] initWithRootViewController:web];
    
    [self.viewController presentViewController:nav animated:YES completion:nil];
    
    web.urlString = self.urlString;

}

@end
