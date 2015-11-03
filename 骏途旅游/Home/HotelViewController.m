//
//  HotelViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "HotelViewController.h"
#import "BaseHead.h"
#import "CitysViewController.h"
#import "LeaverCollectionView.h"
#import "MyNetWorkQuery.h"
#import "HotelSIftViewController.h"
@interface HotelViewController ()
{
    UITableView *_tableView;
    
    UILabel *_destinationLabel;
    UILabel *_searchView;
    UITextField *_keywordText;
    
    UILabel *_leavelLabel;
    UIView *_leavelView;
    
    UIView *_bgView;
    //查询数据
    //http://www.juntu.com/index.php?m=app&c=hotel_rec&a=hotel&city=610100&level=3&min_price=300&max_price=600&keyword=%E5%B8%83%E4%B8%81
    NSString *_cityID;
    NSString *_leavel;
    NSString *_min_price;
    NSString *_max_price;
    NSString *_keyword;

}
@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _mytitle;
    //初始化数据
    [[NSUserDefaults standardUserDefaults] setObject:@"-" forKey:kselectedPrice];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kselectedLeave];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kselectedCity];
    //存入本地
    [[NSUserDefaults standardUserDefaults] synchronize];
    _leavel = @"";
    _min_price = @"";
    _max_price = @"";
    
    [self _creatSearchView];//查询按钮
    [self _creatTextField];//文本输入
    [self _creatDestination];//目的地选择
    [self _creatTableView];//表视图
    [self _creatLeavelView];//等级
}
//-(void)viewWillAppear:(BOOL)animated{

    
//}
-(void)viewDidAppear:(BOOL)animated{
        //读取本地数据
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *selectedCity = [defaults objectForKey:kselectedCity];
    if(selectedCity!=nil){
        _destinationLabel.text = selectedCity[@"city"];
    }
        if(_destinationLabel.text==nil){
        _destinationLabel.text = @"点击选择";
        }
        //获得查询城市ID
        _cityID = selectedCity[@"cityid"];
        [_tableView reloadData];
}

//UItableView
-(void)_creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44*4+80+64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;

}
#pragma UItableViewDelegate&dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotelCell"];

    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotelCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row!=4){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //目的地
    if(indexPath.row==0){
        cell.textLabel.text = @"选择目的地";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor =[UIColor grayColor];
        [cell.contentView addSubview:_destinationLabel];
    }
    //查询
    if(indexPath.row==4){
        [cell.contentView addSubview:_searchView];
    }
    //文本输入
    if(indexPath.row==2){
        [cell.contentView addSubview:_keywordText];
    }
    //时间显示
    if(indexPath.row==1){
        cell.textLabel.text = [self nowTime];
    }
    //选择等级和价格
    if(indexPath.row==3){
        cell.textLabel.text = [NSString stringWithFormat:@"价格%@-%@,星级%@",_min_price,_max_price,_leavel];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    return cell;
}
#pragma mark - 获取当前时间
-(NSString *)nowTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"查询时间 HH:mm"];
    NSString *nowTime=[formatter stringFromDate:[NSDate date]];
    return nowTime;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==4){
        return 80;
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        //模态视图弹出tableView
        CitysViewController *city = [[CitysViewController alloc] init];
        [self.navigationController pushViewController:city animated:YES];
        city.hidesBottomBarWhenPushed = YES;
    }
    if(indexPath.row==4){
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
        
        NSString *baseUrl = @"http://www.juntu.com/index.php?m=app&c=hotel_rec&a=hotel&";
        
        NSString *urlString =[NSString stringWithFormat:@"%@&city=%@&level=%@&min_price=%@&max_price=%@&keyword=%@",baseUrl,_cityID,_leavel,_min_price,_max_price,_keywordText.text];
        
        [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
            NSLog(@"%@",result);
            if (result!=nil) {
                //回到主线程跳转界面
                dispatch_sync(dispatch_get_main_queue(), ^{
                    //移除遮罩视图
                    [horseimage removeFromSuperview];
                    [progress removeFromSuperview];
                    [hiddenView removeFromSuperview];
                    NSArray *data = result[@"hotelList"];
                    HotelSIftViewController *hotel = [[HotelSIftViewController alloc] init];
                    hotel.data = data;
                    [self.navigationController pushViewController:hotel animated:YES];
                    hotel.hidesBottomBarWhenPushed = YES;
                    
                });
          
    
            }
       
        } errorHandle:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    //选择等级
    if(indexPath.row==3){
        _leavelView.hidden = NO;
     _bgView.hidden = NO;
    }
}


//目的地
-(void)_creatDestination{
    if(_destinationLabel==nil){
    _destinationLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-130, 0, 100, 44)];
        
    }
    _destinationLabel.textAlignment = NSTextAlignmentRight;
    _destinationLabel.font = [UIFont systemFontOfSize:15];
}

//日历左，日历右

//日历差值Label

//文本框
-(void)_creatTextField{
    _keywordText = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth-20,34)];
    _keywordText.font = [UIFont systemFontOfSize:15];
    _keywordText.placeholder = @"输入关键字搜索酒店信息";
    
}

//价格和星级显示
-(void)_creatLeavelView{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2+20)];
    _bgView.backgroundColor = [UIColor lightGrayColor];
    _bgView.alpha = 0.4;
    _bgView.hidden = YES;
    [self.view addSubview:_bgView];
    
    _leavelView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2+20, kScreenWidth, kScreenHeight/2-20)];
    _leavelView.backgroundColor = [UIColor whiteColor];
    _leavelView.hidden = YES;

    [self _creatLeaverSubs];
    [self.view addSubview:_leavelView];

}
-(void)_creatLeaverSubs{
    //价格
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 20)];
    price.backgroundColor = [UIColor clearColor];
    price.textColor = [UIColor grayColor];
    price.text = @"价格";
    price.font = [UIFont systemFontOfSize:14];
    [_leavelView addSubview:price];
    //价格数组
    NSArray *priceArray = @[@"0不限",@"￥150以下",@"￥150-￥300",@"￥300-￥600",@"￥600以上"];
    
    //CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 20);
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    LeaverCollectionView *priceView = [[LeaverCollectionView alloc] initWithFrame:CGRectMake(10,20 ,kScreenWidth-20 , kScreenHeight/4) collectionViewLayout:layout];
    priceView.titles = priceArray;
    
    [_leavelView addSubview:priceView];
    
    
    
    //星级
    UILabel *leaver = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 50, 20)];
    leaver.backgroundColor = [UIColor clearColor];
    leaver.textColor = [UIColor grayColor];
    leaver.text = @"星级";
    leaver.font = [UIFont systemFontOfSize:14];
    [_leavelView addSubview:leaver];
    
    NSArray *leaveArray = @[@"不限",@"二星级以下",@"三星级",@"四星级",@"五星级"];
    
    LeaverCollectionView *leaveView = [[LeaverCollectionView alloc] initWithFrame:CGRectMake(10,120 ,kScreenWidth-20 , kScreenHeight/4) collectionViewLayout:layout];
    leaveView.titles = leaveArray;
    
    [_leavelView addSubview:leaveView];

    
    //确定按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 215, kScreenWidth-20, 30)];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(_returnLeave)forControlEvents:UIControlEventTouchUpInside];
    [_leavelView addSubview:button];
    
}
-(void)_returnLeave{
    //读取本地数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *selectedPrice = [defaults objectForKey:kselectedPrice];
    NSString *selectedLeave = [defaults objectForKey:kselectedLeave];
    _leavelView.hidden = YES;
    _bgView.hidden = YES;
    //存储数据到url(星级和价格)
    _leavel = selectedLeave;
    NSArray *prices = [selectedPrice componentsSeparatedByString:@"-"];
    _min_price = prices[0];
    _max_price = prices[1];
    
    [_tableView reloadData];

}
//查询
-(void)_creatSearchView{
    _searchView = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20,40 )];
    _searchView.backgroundColor = [UIColor orangeColor];
    _searchView.text = @"查询";
    _searchView.textAlignment = NSTextAlignmentCenter;
    _searchView.textColor = [UIColor whiteColor];
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
