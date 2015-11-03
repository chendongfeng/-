//
//  MyJuntuViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/5.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "MyJuntuViewController.h"
#import "BaseHead.h"
#import "AccountViewController.h"
#import "UIImageView+WebCache.h"
#import "SetViewController.h"
#import "LoginViewController.h"
#import "AboutJunTuViewController.h"
@interface MyJuntuViewController ()
{
    NSArray *_titles;
    NSArray *_imageNames;
    NSString *_login;
    UIImageView *_imageView;
    UITableView *_tableView;
}
@end

@implementation MyJuntuViewController

//读取本地数据
-(void)viewDidAppear:(BOOL)animated{
    _login = [[NSUserDefaults standardUserDefaults] objectForKey:kisLogin];
    //地区本地图片
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
    _imageView.image = [UIImage imageNamed:kplaceImageSmall];
    //账号是否存在
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:kisLogin];
    UIImage *image = [UIImage imageWithData:data];
    if([login isEqualToString:@"YES"]){
        _imageView.image = image;
    }
}

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
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 55, 55)];
    _imageView.image = [UIImage imageNamed:kplaceImageSmall];
    
    [self creatTableView];
    self.title = @"我的骏途";
    [self _creatRightButton];
    // Do any additional setup after loading the view.
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
-(void)creatTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,315+64+100)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    _titles = @[@"账号:",@"我的订单",@"我的电子券",@"我的优惠券",@"设置",@"关于骏途"];
    _imageNames = @[@"icon_dingdan2x",@"dian_zi_quan",@"icon_youhuiquan2x",@"icon_setting2x",@"icon_aboutx"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
        
    }
    
    if (indexPath.row != 0) {
        //添加label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        label.text = _titles[indexPath.row];
        [cell.contentView addSubview:label];
        //添加图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 40, 40)];
        imageView.image = [UIImage imageNamed:_imageNames[indexPath.row-1]];
        [cell.contentView addSubview:imageView];
    }else if(indexPath.row ==0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 200, 40)];
        label.text = _titles[indexPath.row];
        
        [cell.contentView addSubview:label];

        [cell.contentView addSubview:_imageView];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    return cell;
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 100)];
    imageView.backgroundColor = [UIColor yellowColor];
    //这里的图片应该来自首页加载的
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://image.juntu.com//uploadfile//2015//0914//20150914050948194.jpg"] placeholderImage:[UIImage imageNamed:kplaceImage]];
    
    [view addSubview:imageView];
    return view;
  
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    
    return 100;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 65;
    }
    return 50;

}

//选中单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        //判断是否已经登陆
        
        
        if([_login isEqualToString:@"YES"]){
            AccountViewController *account = [[AccountViewController alloc] init];
            [self.navigationController pushViewController:account animated:YES];
            [account setHidesBottomBarWhenPushed:YES];
        }
        else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login setHidesBottomBarWhenPushed:YES];
        }
    }
    if (indexPath.row==4) {
        SetViewController *setVC = [[SetViewController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
        setVC.hidesBottomBarWhenPushed = YES;
    }
    if(indexPath.row==5){
                    AboutJunTuViewController *about = [[AboutJunTuViewController alloc] init];
            [self.navigationController pushViewController:about animated:YES];
            about.hidesBottomBarWhenPushed = YES;
    }
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
