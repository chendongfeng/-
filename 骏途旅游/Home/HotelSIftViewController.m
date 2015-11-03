//
//  HotelSIftViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "HotelSIftViewController.h"
#import "HotelCell.h"
#import "HotelModel.h"
#import "BaseHead.h"
#import "SelectionView.h"
#import "siftType.h"
#import "HotelDetailViewController.h"
#import "MyNetWorkQuery.h"
@interface HotelSIftViewController ()
{
    NSMutableArray *_hotelData;
    UITableView *_tableView;
}
@end

@implementation HotelSIftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酒店";
    [self _makeData];
    [self _creatSelectionView];
    [self _creatTableView];
}
-(void)_makeData{
    //存取Model到数组中
    _hotelData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _data) {
        HotelModel *model = [[HotelModel alloc] initContentWithDic:dic];
        [_hotelData addObject:model];
    }
}
//筛选框
-(void)_creatSelectionView{
    siftType *sift = [[siftType alloc]init];
    //获取分类信息
    sift.type = @"酒店";
    NSArray *data = [sift getData:@"酒店"];
    //获取按钮标题
    NSArray *title = [sift gettitle:@"酒店"];
    SelectionView *selection = [[SelectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30) TitleArray:title DataArray:data[0]];
    selection.Data = data;
    
    [self.view addSubview:selection];
}

//表视图
-(void)_creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, kScreenWidth, kScreenHeight-30) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"HotelCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"HotelCell"];

    [self.view addSubview:_tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return _hotelData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    HotelCell *hotelCell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
    hotelCell.selectionStyle = UITableViewCellSelectionStyleNone;
    hotelCell.model = _hotelData[indexPath.row];
    return hotelCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//点击跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    
    //获取HotelID
    HotelModel *model = _hotelData[indexPath.row];
    NSString *hotelId = model.hotelID;
    //发送请求
    NSString *string = @"http://www.juntu.com/index.php?m=app&c=hotel_rec&a=hotel_show&hotelid=";
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",string,hotelId];
    
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        NSLog(@"resule%@",result);
        if (result!=nil) {
            //跳转界面
            dispatch_sync(dispatch_get_main_queue(), ^{
                [horseimage removeFromSuperview];
                [progress removeFromSuperview];
                [hiddenView removeFromSuperview];
                HotelDetailViewController *hotelDetail = [[HotelDetailViewController alloc] init];
                hotelDetail.hidesBottomBarWhenPushed = YES;
                hotelDetail.result = result;
                [self.navigationController pushViewController:hotelDetail animated:YES];
            });
        }
    
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
