//
//  BaseTarBarController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/5.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseTarBarController.h"
#import "TabBarButton.h"
#import "BaseHead.h"
@interface BaseTarBarController ()
{
    
    UIView *_newTabBar;  // 自定义的标签栏
    
    UIImageView *_selectView;    // 选中视图
    
}
@end

@implementation BaseTarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个新的标签栏
    [self _createTabBar];
    
}


- (void)_createTabBar
{
    // 隐藏系统自带的标签栏
    self.tabBar.hidden = YES;
    if (_newTabBar==nil) {
        // 创建自定义标签栏
        _newTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
        _newTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1136_menu_background_lvkuang"]];
        [self.view addSubview:_newTabBar];
        

    }
               // 创建按钮
        // 1. 计算按钮宽
        CGFloat buttonWidth = kScreenWidth / self.viewControllers.count;
        
        
//        // 创建选中框
//        _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 4)];
//        _selectView.image = [UIImage imageNamed:@"1136_menu_background_lvkuang11"];
//        
//        
//        [_newTabBar addSubview:_selectView];
//        
    
        
        NSArray *titles = @[@"首页",
                            @"我的订单",
                            @"我的骏途",
                            @"联系骏途"];
        NSArray *imageNames = @[@"图标a1",
                                @"图标a2",
                                @"图标a3",
                                @"图标a4"];
        
        for (int i = 0; i < self.viewControllers.count; i++)
        {
            // 创建一个子类化按钮
            TabBarButton *button = [[TabBarButton alloc] initWithTitle:titles[i] imageName:imageNames[i] frame:CGRectMake(i * buttonWidth, 0, buttonWidth, 49)];
            button.tag = 100+i;
            
            // 给按钮添加点击事件
            [button addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                button.myImageName = @"图标a11";
                button.myLabelColor = [UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.f alpha:1];
            }
            
            // 将这个按钮添加到标签栏上去
            [_newTabBar addSubview: button];
        }

    
    
    
}

- (void)tabBarButtonAction:(TabBarButton *)button
{
    NSArray *imageNames = @[@"图标a1",
                            @"图标a2",
                            @"图标a3",
                            @"图标a4"];
    
    NSArray *NewimageNames = @[@"图标a11",
                            @"图标a12",
                            @"图标a13",
                            @"图标a14"];
    NSInteger tag = button.tag-100;
    if(tag==3){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"拨打电话" message:@"12345678" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        [alertView show];
        return;
    }
    //获取按钮
    for (NSInteger i =0; i<4; i++) {
       TabBarButton *button = [_newTabBar viewWithTag:100+i];
         button.myImageName = imageNames[i];
          button.myLabelColor = [UIColor grayColor];
        if (i==tag) {
            
            button.myImageName = NewimageNames[tag];
            button.myLabelColor = [UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.f alpha:1];
        }
       
        
    }
    
    // 根据按钮的tag 来切换显示的页面
    self.selectedIndex = tag;
    
//    // 选中框移动
//    [UIView animateWithDuration:0.2 animations:^{
//        _selectView.center = CGPointMake(button.center.x, 2) ;
//    }];
    
}

#pragma mark - 隐藏标签栏
-(void)setTabBarHidden:(BOOL)hidden{
    _newTabBar.hidden=hidden;
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
