//
//  TourViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/20.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "TourViewController.h"
#import "BaseHead.h"
#import "JuntuSeacherBar.h"
#import "JuntutableView.h"
#import "SifiModel.h"
#import "SiftViewController.h"
#import "UIImageView+WebCache.h"
#import "JuntuImageView.h"

@interface TourViewController ()
{
    JuntuSeacherBar *_searchBar;
    NSArray *_listArray;
    JuntutableView *_tableView;
    JuntuImageView *_headImageView;
}
@end

@implementation TourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _myTitle;
    
    [self _creatHeadView];
    
    [self _creatTableView];
    
    [self _creatSearchBar];
    
    [self loadListData];
    
    [self _creatShareAction];
}
//分享按钮
-(void)_creatShareAction{
    ShareButton *share = [[ShareButton alloc] initWithFrame:CGRectMake(0, 0, 31, 33)];
    
    //添加到导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
}



//创建搜索栏
-(void)_creatSearchBar{
    NSString *urlString;
    if([_myTitle isEqualToString:@"景区"]){
        urlString = kscenic;
    }else if ([_myTitle isEqualToString:@"出境游"]){
        urlString = kforeign;
    }else{
        urlString = kinland;
    }
    
    _searchBar = [[JuntuSeacherBar alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30) AndPlaceholderText:@"输入关键字搜索旅游信息"];
    //进行分类搜索
    _searchBar.type = _myTitle;
    
    _searchBar.urlString = urlString;
   
    [self.view addSubview:_searchBar];
    __weak __typeof(self) weakSelf = self;
    [_searchBar setBlock:^(NSArray *array,NSString *text){
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
//创建
-(void)loadListData{
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
    if([_myTitle isEqualToString:@"景区"]){
        urlString = kscenicList;
    }else if ([_myTitle isEqualToString:@"出境游"]){
        urlString = kforeignList;
    }else{
        urlString = kinlandList;
    }
    
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
     
        //需要区分景区和旅游
        NSArray *list;
        if([_myTitle isEqualToString:@"景区"]){
            list = result[@"destList"];
        }else {
           
             list=result[@"list"];
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
//创建tableView
-(void)_creatTableView{
    _tableView = [[JuntutableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight-30) style:UITableViewStylePlain];
    _tableView.tableHeaderView = _headImageView;
    _tableView.type = _myTitle;
    [self.view addSubview:_tableView];
}
//加入头部图片
-(void)_creatHeadView{
    _headImageView = [[JuntuImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    NSString *urlString;
    if([_myTitle isEqualToString:@"景区"]){
        urlString = @"http://www.juntu.com/index.php?m=app&c=scenic_rec&a=get_scenic_pic";
    }else if ([_myTitle isEqualToString:@"出境游"]){
        urlString = @"http://www.juntu.com/index.php?m=app&c=route_rec&a=get_foreign_pic";
    }else{
        urlString = @"http://www.juntu.com/index.php?m=app&c=route_rec&a=get_inland_pic";
    }
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        NSDictionary *oneLink = [result firstObject];
        NSString *url = oneLink[@"thumb"];
        NSString *linkurl = oneLink[@"linkurl"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            _headImageView.urlString = linkurl;
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:kplaceImage]];

        });
        
    } errorHandle:^(NSError *error) {
        NSLog(@"失败%@",error);
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
