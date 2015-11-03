//
//  MyOrderViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/5.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderListViewController.h"
#import "BaseHead.h"
#import "LoginViewController.h"
#define kScrennWidth [UIScreen mainScreen].bounds.size.width
#define kScrennHeight [UIScreen mainScreen].bounds.size.height

@interface MyOrderViewController ()
{
    NSArray *_titles;
}
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏图案
    //1.创建小马图片
    UIImage *leftImage = [UIImage imageNamed:@"组合3"];
    UIImageView *leftImageView = [[UIImageView alloc]initWithImage:leftImage];
    leftImageView.frame = CGRectMake(0, 0, 40, 25);
    //2.创建BarItem
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftImageView];
    //3.设置Item添加到导航栏
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self _creatRightButton];
    [self _creatTableView];
    //导航栏标题
    self.title = @"我的订单";
    _titles = @[@"酒店订单",@"景区订单",@"旅游路线订单",@"景加酒店订单",@"体验团订单",@"套餐订单",@"门加门订单"];
}
//创建导航栏联系客服的Button
-(void)_creatRightButton{
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButton setImage:[UIImage imageNamed:@"tel_zuixin"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)rightButtonAction{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"400-029-9966" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alertView show];
    
}

//创建tableView
-(void)_creatTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth,370 ) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titles.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
        
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
    label.text = _titles[indexPath.row];
    [cell.contentView addSubview:label];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断是否登录
    NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:kisLogin];
    if([isLogin isEqualToString:@"YES"]){
        
        
        OrderListViewController *orderList = [[OrderListViewController alloc] init];
        orderList.mytitle = _titles[indexPath.row];
        NSArray *orderArray = @[@"hotel_order",@"dest_order",@"tours_order",@"scenic_hotel_order",@"package_ticket_order",@"group_ticket_order",@"packet_group_order"];
        orderList.type = orderArray[indexPath.row];
        orderList.typeNumber = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        
        //隐藏标签栏
        [orderList setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:orderList animated:YES];
    }
    else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login setHidesBottomBarWhenPushed:YES];
    }

   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
