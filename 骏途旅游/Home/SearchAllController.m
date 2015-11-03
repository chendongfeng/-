//
//  SearchAllController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/11.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "SearchAllController.h"
#import "JuntuSeacherBar.h"
#import "BaseHead.h"
#import "JuntuHistoryTable.h"
#import "MyNetWorkQuery.h"
#import "SiftViewController.h"
#import "HotelSIftViewController.h"
@interface SearchAllController ()
{
    NSMutableArray *_searchArray;
    NSString *_sifiTitle;
    NSInteger _index;

}
@end

@implementation SearchAllController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
 
    //在导航栏插入UISearchBar
    JuntuSeacherBar *searchBar = [[JuntuSeacherBar alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth-50, 40) AndPlaceholderText:@"搜索目的地、景点、酒店等"];
    searchBar.urlString = @"http://www.juntu.com/index.php?m=app&c=index&a=search&keywords=";
    self.navigationItem.titleView = searchBar;
    //将搜索到的数据返回
    
    
    [searchBar setBlock:^(NSArray *array,NSString *text){
        self.searchText = text;
        //初始化数据
        _searchArray = [NSMutableArray array];
//        NSLog(@"array%@",array);
        for (NSDictionary *dic in array) {
            if (![dic[@"num"] isEqualToString:@"0"]) {
                //添加到新的数组中
                [_searchArray addObject:dic];
            } ;
        }
        //回到主线程刷新UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self _creatButton:_searchArray];
            
        });
        
    }];
    //添加显示
    
    //在导航栏下插入9个UICollectionView
    
    
    //在最下面插入可变数据量的UItableView
//    NSArray *array = @[@"江弘1",@"江弘2",@"江弘3",@"江弘4"];
//    NSInteger count = array.count;
//    if (count>6) {
//        count=6;
//    }
//    JuntuHistoryTable *history = [[JuntuHistoryTable alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44*(count+1))];
//    history.tableData = array;
//    [self.view addSubview:history];
    
}
-(void)_creatButton:(NSArray *)array{
    //先移除以前的视图
    
    for(UIView *view in self.view.subviews){
        [view removeFromSuperview];
    }
    
    NSArray *typeArray = @[@"scenic",@"around",@"inland",@"foreign",@"hotel",@"scenic_hotel"];
    
    for (int i =0; i<array.count; i++) {
        
        
        NSDictionary *dic = array[i];
        //添加按钮试图
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 64+i*40, kScreenWidth, 40)];
        [self.view addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        //设置边框
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1;
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString *type = dic[@"type"];
        //遍历数组 并设置tag值
        for (int j=0; j<typeArray.count; j++) {
            if ([typeArray[j] isEqualToString:type]) {
                //处理字符串
                NSString *newString = [self changeText:typeArray[j]];
                
                NSString *string = [NSString stringWithFormat:@"拥有%@相关%@项",newString,dic[@"num"]];
                //设置标题
                [button setTitle:string forState:UIControlStateNormal];
                //设置文本对齐
                button.titleLabel.textAlignment = NSTextAlignmentLeft;
                button.tag = 100+j;
            };
        }
    }
}
//改变现实的数据
-(NSString *)changeText:(NSString *)type{
    if([type isEqualToString:@"scenic"])
    {
        return @"景区";
    }else if ([type isEqualToString:@"around"]){
        return @"周边游";
    }else if ([type isEqualToString:@"inland"]){
        return @"国内游";
    }else if ([type isEqualToString:@"foreign"]){
        return @"境外游";
    }else if ([type isEqualToString:@"scenic_hotel"]){
        return @"景+酒";
    }else{
        return @"酒店";
    }
}

-(void)searchAction:(UIButton *)button{
//    _hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _hiddenView.backgroundColor = [UIColor lightGrayColor];
//    _hiddenView.alpha = 0.2;
//    _hiddenView.hidden = NO;
//    [self.view addSubview:_hiddenView];
    NSInteger index = button.tag-100;
    _index = index;
//    NSLog(@"%li",index);
    NSString *string;
    if(index==0){
        string = kscenic;
        _sifiTitle = @"景区";
    }
    if(index==1){
        string = karound;
        _sifiTitle = @"周边游";
    }
    if(index==2){
        string = kinland;
        _sifiTitle = @"国内游";
    }
    if(index==3){
        string = kforeign;
        _sifiTitle = @"境外游";
    }
    if(index==4){
        string = khotel;
        _sifiTitle = @"酒店";
    }
    if(index==5){
        string = kscenic_hotel;
        _sifiTitle = @"景+酒";
    }
    string = [string stringByAppendingString:self.searchText];
    //开启搜索
    //需要根据文本框的key进行二级搜索
    [self searchDetail:string];
    
}

-(void)searchDetail:(NSString *)urlString{
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
    
    [self.view addSubview:horseimage];
    [self.view addSubview:progress];
    [self.view addSubview:hiddenView];
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
       
        NSArray *array = [[NSArray alloc] init];
        if (_index == 0) {
            array = result[@"destList"];
        }else if (_index == 4){
            array = result[@"hotelList"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [horseimage removeFromSuperview];
                [progress removeFromSuperview];
                [hiddenView removeFromSuperview];
                
//                 _hiddenView.hidden = YES;
                HotelSIftViewController *sift = [[HotelSIftViewController alloc]init];
                [self.navigationController pushViewController:sift animated:YES];
                sift.hidesBottomBarWhenPushed = YES;
                sift.data = array;
            });
            return ;
        }else if (_index == 5){
            array = result[@"info"];
        }else{
            array = result[@"toursList"];
        }
        //转到筛选界面
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            //移除遮罩
            [horseimage removeFromSuperview];
            [progress removeFromSuperview];
            [hiddenView removeFromSuperview];
            SiftViewController *sift = [[SiftViewController alloc]init];
            [self.navigationController pushViewController:sift animated:YES];
            sift.myTitle = _sifiTitle;
            sift.hidesBottomBarWhenPushed = YES;
            sift.searchData = array;
            sift.type = _sifiTitle;
        });
        
    } errorHandle:^(NSError *error) {
        //移除遮罩
        [horseimage removeFromSuperview];
        [progress removeFromSuperview];
        [hiddenView removeFromSuperview];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

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
