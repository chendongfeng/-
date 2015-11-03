//
//  OrderListViewController.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/8.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "OrderListViewController.h"
#import "BaseHead.h"
#import "MyNetWorkQuery.h"
#import "HomeViewController.h"
@interface OrderListViewController ()
{
    UIImageView *_selectImageView;
    CGFloat width;
    NSArray *_listArray;
}
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    NSString *name = [NSString stringWithFormat:@"%@列表",_mytitle];
    self.title = name;
    
    [self _creatTopView];
    [self _loadData];
    // Do any additional setup after loading the view.
}

//创建头部选中视图
-(void)_creatTopView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 43)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1_3"]];
    NSArray *buttonNames = @[@"全部",@"未支付",@"未验证",@"退款单"];
    width = self.view.frame.size.width/4;
    
    _selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 37, width, 4)];
    _selectImageView.image = [UIImage imageNamed:@"1136_menu_background_lvkuang11"];
    [view addSubview:_selectImageView];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 43)];
        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button.tag = i + 100;
    }
    [self.view addSubview:view];
    
    
}

-(void)_creatOrderView{
    if (_listArray.count == 0) {
        //笑脸图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 30, kScreenHeight/2, 60, 60)];
        imageView.image = [UIImage imageNamed:@"no_list_tu"];
        [self.view addSubview:imageView];
        
        //提示
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 40, kScreenHeight/2 +60, 80, 30)];
        label.text = @"还木有订单哦~";
        label.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:label];
        
        //返回首页
        UIButton *backHomeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 50, kScreenHeight/2 + 100, 100 , 20)];
        [backHomeBtn setTitle:@"去首页逛逛" forState:UIControlStateNormal];
        [backHomeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        backHomeBtn.layer.masksToBounds = YES;
        backHomeBtn.layer.borderWidth = 1;
        backHomeBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [backHomeBtn addTarget:self action:@selector(backHomeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backHomeBtn];
    }else{
        for (int i = 0; i < _listArray.count; i++) {
            //背景图
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 102+i * ((kScreenHeight-102)/3) , kScreenWidth, (kScreenHeight-102)/3)];
            bgImageView.image = [UIImage imageNamed:@"tuoyuan12x"];
            [self.view addSubview:bgImageView];
            
            //订单名称
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth, 40)];
            titleLabel.numberOfLines = 0;
            titleLabel.font = [UIFont systemFontOfSize:14];
            NSDictionary *dic = _listArray[i];
            if ([_typeNumber isEqualToString:@"1"]) {
                NSString *title = [dic objectForKey:@"hotel_name"];
                title = [NSString stringWithFormat:@"%@-%@%@间",title,dic[@"room_name"],dic[@"num"]];
                
                titleLabel.text = title;
            }else{
                NSString *title = [dic objectForKey:@"order_name"];
                titleLabel.text = title;
            }
            [bgImageView addSubview:titleLabel];
            
            //订单编号
            NSString *orderNumber = [dic objectForKey:@"order_id"];
            orderNumber = [NSString stringWithFormat:@"订单编号:%@",orderNumber];
            UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, kScreenWidth-100, 30)];
            numberLabel.text = orderNumber;
            numberLabel.font = [UIFont systemFontOfSize:10];
            numberLabel.textColor = [UIColor grayColor];
            [bgImageView addSubview:numberLabel];
            
            //购买日期
            NSString *buyTime = [dic objectForKey:@"create_time"];
            NSTimeInterval t = [buyTime doubleValue];
            NSDate *time = [NSDate dateWithTimeIntervalSince1970:t ];
            buyTime = [NSString stringWithFormat:@"%@",time];
            buyTime = [buyTime substringToIndex:buyTime.length - 15];
            buyTime = [NSString stringWithFormat:@"购买日期:%@",buyTime];
            
            UILabel *buyTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 70,100 , 30)];
            buyTimeLabel.text = buyTime;
            buyTimeLabel.font = [UIFont systemFontOfSize:10];
            buyTimeLabel.textColor = [UIColor grayColor];
            [bgImageView addSubview:buyTimeLabel];
            
            //出游日期
            NSString *tourTime = [dic objectForKey:@"travel_start_date"];
            NSTimeInterval t2 = [tourTime doubleValue];
            NSDate *time2 = [NSDate dateWithTimeIntervalSince1970:t2 ];
            tourTime = [NSString stringWithFormat:@"%@",time2];
            tourTime = [tourTime substringToIndex:tourTime.length - 15];
            tourTime = [NSString stringWithFormat:@"出游日期:%@",tourTime];
            
            
            UILabel *tourTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 100,100 , 30)];
            tourTimeLabel.text = tourTime;
            tourTimeLabel.font = [UIFont systemFontOfSize:10];
            tourTimeLabel.textColor = [UIColor grayColor];
            [bgImageView addSubview:tourTimeLabel];
            
            //价格
            UILabel *priceLabel= [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4 * 3 , 70, 80, 30)];
            priceLabel.textColor = [UIColor orangeColor];
            NSString *price = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"total"]];
            priceLabel.text = price;
            [bgImageView addSubview:priceLabel];
            
            //支付状态
            UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/4 * 3, 100, 60, 30)];
            if ([dic[@"status"] isEqualToString:@"3"]) {
                payButton.backgroundColor = [UIColor grayColor];
            }else {
                payButton.backgroundColor = [UIColor orangeColor];
            }
            payButton.layer.masksToBounds = YES;
            payButton.layer.cornerRadius = 4;
            [payButton setTitle:[dic objectForKey:@"order_status_name"] forState:UIControlStateNormal];
            [bgImageView addSubview:payButton];
            
        }
        
        
    }
}

-(void)buttonAction:(UIButton *)btn{
    NSInteger i = btn.tag - 100;
    [UIView animateWithDuration:0.2 animations:^{
        _selectImageView.frame = CGRectMake(i*width, 38, width, 4) ;
        
    }];
    
}

//网络请求
-(void)_loadData{
    NSString *url = [NSString stringWithFormat:@"http://www.juntu.com/index.php?m=app&c=member_order&a=%@&type=%@&page=1&userid=47551",_type,_typeNumber ];
    [MyNetWorkQuery requestData:url HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        
        _listArray = [result objectForKey:@"list"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self _creatOrderView];
        });
        
    } errorHandle:^(NSError *error) {
        
    }];
    
    
}

-(void)backHomeBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
    _selectImageView.frame = CGRectMake(0, 0, kScreenWidth/4, 4);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
