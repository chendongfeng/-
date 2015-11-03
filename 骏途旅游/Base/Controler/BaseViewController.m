//
//  BaseViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/5.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTarBarController.h"
#import "BaseHead.h"
#import "UIViewExt.h"
@interface BaseViewController ()
{
    UILabel *_titleLabel;
    BOOL _isHiddenTabBar;
 
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 自定义Title
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 120, 40)];
    _titleLabel.center = self.navigationController.navigationBar.center;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"title";
    
    // 将label 显示到导航栏上去
    self.navigationItem.titleView = _titleLabel;
    //统一设置返回按钮
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"back2x1"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    
    // 设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg.jpg"]];

}
-(void)leftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)setTitle:(NSString *)title
{
    // _title 是一个 @package 修饰的属性 所以不能直接修改
    // _title = title;
    // 所以需要使用父类中的setTitle方法来修改_title
    [super setTitle:title];
    _titleLabel.text = title;
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    _isHiddenTabBar = hidesBottomBarWhenPushed;
}
- (void)viewWillAppear:(BOOL)animated
{
    if (_isHiddenTabBar)
    {
        // 隐藏标签栏
        BaseTarBarController *tab = (BaseTarBarController *)self.tabBarController;
        [tab setTabBarHidden:YES];
    }
    else
    {
        // 显示标签栏
        BaseTarBarController *tab = (BaseTarBarController *)self.tabBarController;
        [tab setTabBarHidden:NO];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    // 显示标签栏
    BaseTarBarController *tab = (BaseTarBarController *)self.tabBarController;
    [tab setTabBarHidden:NO];
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
