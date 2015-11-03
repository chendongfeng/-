//
//  BaseNaviViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/5.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface BaseNaviViewController ()

@end

@implementation BaseNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏的风格
    [self.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1136_menu_background_lvkuang"]]];
    self.navigationBar.translucent = YES;


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
