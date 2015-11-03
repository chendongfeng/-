//
//  FirstViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/27.
//  Copyright © 2015年 xs27_Group3. All rights reserved.
//

#import "FirstViewController.h"
#import "BaseHead.h"
@interface FirstViewController ()<UIScrollViewDelegate>
{
    UIPageControl *_pageControl;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatScrollView];
    
}
//创建滚动视图
-(void)creatScrollView{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.contentSize=CGSizeMake(kScreenWidth*4, kScreenHeight);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    for(int i=0;i<4;i++){
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"6p引导%i.jpg",i+1]];
        imageView.userInteractionEnabled=YES;
        [scrollView addSubview:imageView];
        //给第四张图片添加动作
        if (i==3) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, kScreenHeight)];
          
            [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            
              [scrollView addSubview:button];
        }
    }
    //创建
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, kScreenHeight-50, kScreenWidth-100, 20)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 4;
    [self.view addSubview:_pageControl];
    
}
//按钮进入主界面
-(void)buttonAction{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *VC= [storyboard instantiateInitialViewController];
    self.view.window.rootViewController=VC;
    VC.view.transform=CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateWithDuration:0.3 animations:^{
        VC.view.transform=CGAffineTransformIdentity;
    }];
}
//滚动偏移量计算页数，避免下面的图片滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/kScreenWidth;
    _pageControl.currentPage = page;
    
}




//状态栏
-(void)viewDidAppear:(BOOL)animated{
    UIApplication *app=[UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    UIApplication *app=[UIApplication sharedApplication];
    [app setStatusBarHidden:NO];
#pragma mark - 手动设定是否是第一次
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setBool:@YES forKey:@"first"];
    
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
