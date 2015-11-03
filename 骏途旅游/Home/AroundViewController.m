//
//  AroundViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "AroundViewController.h"
#import "SelectionView.h"
#import "JuntuSeacherBar.h"
#import "JuntutableView.h"
#import "siftType.h"
#import "SiftViewController.h"
@interface AroundViewController ()
{
    JuntutableView *_tableView;
}
@end

@implementation AroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _myTitle;
    [self _loadData];
    [self _creatSelectionView];
    [self _creatSearchBar];
    [self _creatTableView];
    [self _creatShareAction];
}
//分享按钮
-(void)_creatShareAction{
    ShareButton *share = [[ShareButton alloc] initWithFrame:CGRectMake(0, 0, 31, 33)];
    
    //添加到导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
}


//筛选栏
-(void)_creatSelectionView{
    siftType *sift = [[siftType alloc]init];
    sift.type = _myTitle;
    //获取分类信息
    NSArray *data = [sift getData:_myTitle];
    //获取按钮标题
    NSArray *title = [sift gettitle:_myTitle];
    SelectionView *selection = [[SelectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30) TitleArray:title DataArray:data[0]];
    
    selection.Data = data;
    
    [self.view addSubview:selection];

}

//搜索框
-(void)_creatSearchBar{
    NSString *urlString;
    if([_myTitle isEqualToString:@"周边游"]){
        urlString = karound;
    }else{
        urlString = kscenic_hotel;
    }
    
    JuntuSeacherBar *searchBar = [[JuntuSeacherBar alloc] initWithFrame:CGRectMake(0, 94, kScreenWidth, 30) AndPlaceholderText:@"输入关键字搜索旅游和酒店信息"];
    //进行分类搜索
    searchBar.type = _myTitle;
    
    searchBar.urlString = urlString;
    
    [self.view addSubview:searchBar];
    __weak __typeof(self) weakSelf = self;
    [searchBar setBlock:^(NSArray *array,NSString *text){
        NSLog(@"%@",array);
        //已经获取到数据
        if (array.count>0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //将self转成strong才能访问属性
                SiftViewController *siftVC = [[SiftViewController alloc] init];
                [weakSelf.navigationController pushViewController:siftVC animated:YES];
                siftVC.myTitle = weakSelf.myTitle;
                siftVC.searchData = array;
                siftVC.hidesBottomBarWhenPushed = YES;
                //            __strong __typeof(self) strongSelf = weakSelf;
            });
            
        }
        
    }];
    
}

//tableView

-(void)_creatTableView{
    _tableView = [[JuntutableView alloc] initWithFrame:CGRectMake(0, 60+64, kScreenWidth, kScreenHeight-60-64) style:UITableViewStylePlain];
    _tableView.type = _myTitle;

    [self.view addSubview:_tableView];

}

//加载数据

-(void)_loadData{
    //创建遮罩视图
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
    
    [self.view addSubview:horseimage];
    [self.view addSubview:progress];
    [self.view addSubview:hiddenView];
    
    
    NSString *urlString;
    if([_myTitle isEqualToString:@"周边游"]){
        urlString = karoundList;
    }else{
        urlString = kscenic_hotelList;
    }
    
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        //需要区分景区和旅游
        NSArray *list;
        if([_myTitle isEqualToString:@"周边游"]){
            list = result[@"toursList"];
        }else {
            
            list = result[@"info"];
        }
        
        NSMutableArray *listData = [[NSMutableArray alloc] init];
        //处理数据
        for (NSDictionary *dic in list) {
            SifiModel *model = [[SifiModel alloc] initContentWithDic:dic];
            [listData addObject:model];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [horseimage removeFromSuperview];
            [progress removeFromSuperview];
            [hiddenView removeFromSuperview];
            _tableView.sifiArray = listData;
        });
        
    } errorHandle:^(NSError *error) {
        NSLog(@"请求失败%@",error);
    }];

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
