//
//  JuntutableView.m
//  骏途旅游
//
//  Created by mac10 on 15/10/20.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "JuntutableView.h"
#import "ScienciViewController3.h"
#import "HUProgressView.h"
#import "ScenicHotelViewController.h"
@implementation JuntutableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if(self){
        [self _initTable];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)awakeFromNib{
    
    [self _initTable];
    
}
-(void)_initTable{
    self.delegate = self;
    self.dataSource = self;
    self.showsVerticalScrollIndicator = NO;
    //注册单元格
    UINib *nib  = [UINib nibWithNibName:@"SifiCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"SifiCell"];
    
}

-(void)setSifiArray:(NSArray *)sifiArray{
    if(_sifiArray!=sifiArray){
        _sifiArray = sifiArray;
        [self reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _sifiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    SifiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SifiCell" forIndexPath:indexPath];
    cell.model = _sifiArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

//选中事件
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
    
    [hiddenView addSubview:horseimage];
    [self.superview addSubview:horseimage];
    [self.superview addSubview:progress];
    [self.superview addSubview:hiddenView];
//    NSLog(@"%li",indexPath.row);
    //根据不同的type进行跳转判断
    NSString *urlString;
    if([_type isEqualToString:@"景+酒"]){
        urlString = kscenic_hotelDetail;
    }else if([_type isEqualToString:@"景区"]){
        urlString = kscenicDetail;
    }else{
        urlString = ktoursDetail;
    }
    //获取旅游路线的ID
    SifiModel *model = _sifiArray[indexPath.row];
    NSString *toursid = model.myID;
    NSString *toursUrl = [NSString stringWithFormat:@"%@%@",urlString,toursid];
    //需要发送请求并将获得的数据传递给下个视图
    [MyNetWorkQuery requestData:toursUrl HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        if([_type isEqualToString:@"景+酒"]){
            dispatch_sync(dispatch_get_main_queue(), ^{
            //停止动画
            [progress stopProgressAnimating];
            [progress removeFromSuperview];
            [hiddenView removeFromSuperview];
            [horseimage removeFromSuperview];
            ScenicHotelViewController *scenicHotelDetail = [[ScenicHotelViewController alloc] init];
            //传递数据
            scenicHotelDetail.detailData = result;
            //打开旅游详情界面
            [self.viewController.navigationController pushViewController:scenicHotelDetail animated:YES];
            scenicHotelDetail.hidesBottomBarWhenPushed = YES;
        });

        }else if([_type isEqualToString:@"景区"]){
//            NSLog(@"%@",result);
            NSDictionary *destShow = [result[@"destShow"] lastObject];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                //停止动画
                [progress stopProgressAnimating];
                [progress removeFromSuperview];
                [hiddenView removeFromSuperview];
                [horseimage removeFromSuperview];
                ScienciViewController3 *scenicDetail = [[ScienciViewController3 alloc] init];
              
                //打开旅游详情界面
                [self.viewController.navigationController pushViewController:scenicDetail animated:YES];
                scenicDetail.hidesBottomBarWhenPushed = YES;
                //传递数据
                scenicDetail.detaiData = destShow;
            });
            
        }else{
            NSDictionary *toursShow = [result[@"toursShow"]lastObject];
//            NSLog(@"%@",toursShow);
            //返回主线程
            dispatch_sync(dispatch_get_main_queue(), ^{
                [progress stopProgressAnimating];
                [progress removeFromSuperview];
                [hiddenView removeFromSuperview];
                [horseimage removeFromSuperview];                TourDetailViewController *toursDetail = [[TourDetailViewController alloc] init];
                //传递数据
                toursDetail.detailData = toursShow;
                //打开旅游详情界面
                [self.viewController.navigationController pushViewController:toursDetail animated:YES];
                toursDetail.hidesBottomBarWhenPushed = YES;
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

@end
