//
//  TourDetailViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/15.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "TourDetailViewController.h"
#import "TourHeadView.h"
#import "BaseHead.h"
#import "MyNetWorkQuery.h"
@interface TourDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    TourHeadView *_headView;
    UIView *_calendar; //日历单元格
    UILabel *_dateLabel;//日历数字
    UIView *_changeView;//切换按钮视图
    UIWebView *_webView;//网页视图
    UIImageView *_selectedImage;//选中图片
    UILabel *_webLabel;//网页上的label
}
@end

@implementation TourDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"出游详情";
    //创建头视图
    [self _creatHeadView];
    //创建日历单元格
    [self _creatCalendar];
    //创建切换视图
    [self _creatChangeView];
    //创建webView
    [self _creatWebView];
    //创建tableView
    [self _creatTableView];
    //创建电话购买界面
    [self _creatPhoneView];
    //这里的返回应该直接返回首页
    
    [self _creatShareAction];
}

//分享按钮
-(void)_creatShareAction{
    ShareButton *share = [[ShareButton alloc] initWithFrame:CGRectMake(0, 0, 31, 33)];
    
    //添加到导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
}


-(void)setDetailData:(NSDictionary *)detailData{
    if (_detailData!=detailData) {
        _detailData = detailData;
    }
    
}
//创建tableView
-(void)_creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _headView;
    [self.view addSubview:_tableView];
    
}

//1.头视图（图片，详细信息）
-(void)_creatHeadView{
    _headView = [[TourHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 230)];
    _headView.headData = self.detailData;
    
}
//2.第一个单元格（日历）

-(void)_creatCalendar{
    _calendar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _calendar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _calendar.layer.borderWidth = 1;
    //添加ImageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 28, 28)];
    imageView.image = [UIImage imageNamed:@"rili12x"];
    [_calendar addSubview:imageView];
    //label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 150, 34)];
    label.text = @"选择出发日期";
    [_calendar addSubview:label];
    //日期label
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-150, 5, 150, 34)];
    _dateLabel.text = @"2015-10-19";
    _dateLabel.textColor = [UIColor cyanColor];
    [_calendar addSubview:_dateLabel];

}
//3.单选切换头视图
-(void)_creatChangeView{
    //按钮的属性
    _changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, kScreenWidth, 38)];
    _changeView.backgroundColor = [UIColor grayColor];
    //选中图片
    _selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 37, kScreenWidth/4, 3)];
    _selectedImage.image = [UIImage imageNamed:@"1136_menu_background_lvkuang11"];
    [_changeView addSubview:_selectedImage];
    NSArray *titleArray = @[@"行程介绍",@"线路特色",@"费用说明",@"重要提示"];
      CGFloat width = kScreenWidth/titleArray.count;
    for(int i = 0;i<4;i++){

        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 39)];
        button.tag = 100+i;
        [button addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        //设置字体
        
        NSAttributedString *attribute = [[NSAttributedString alloc]initWithString:titleArray[i] attributes:@{
                                                                                                       NSFontAttributeName: [UIFont systemFontOfSize:13]
                                                                                                       
                                                                                                       }];
        
        [button setAttributedTitle:attribute forState:UIControlStateNormal];

        //设置背景
        button.backgroundColor = [UIColor whiteColor];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changeView addSubview:button];
    }

}
//点击方法
-(void)changeAction:(UIButton *)button{
    NSInteger index = button.tag-100;
    NSLog(@"tag = %li",index);
    CGFloat width = kScreenWidth/4;
    _selectedImage.frame = CGRectMake(index*width, 37, width, 3);
    //移除label
    if(_webLabel !=nil){
        [_webLabel removeFromSuperview];
    }
    if (index==0) {
    //发送请求行程介绍
        NSString *url = @"http://s.juntu.com/index.php?m=mobile&c=tours&a=stroke_detail&id=";
        NSString *fullUrl = [NSString stringWithFormat:@"%@%@&client_type=3",url,_detailData[@"id"]];
        [self loadData:fullUrl];

    }else if (index==1){
    //发送请求线路特色
        
        CGFloat fontSize = 14;
        NSString *fontColor = @"Gray";
        NSString *text =[ _detailData[@"features"] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
        NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                              "<head> \n"
                              "<style type=\"text/css\"> \n"
                              "body {font-size: %f; color: %@;}\n"
                              "</style> \n"
                              "</head> \n"
                              "<body>%@</body> \n"
                              "</html>", fontSize, fontColor, text];
        [_webView loadHTMLString:jsString baseURL:nil];
    }else if (index==2){
    //发送请求费用说明
        NSString *url = @"http://s.juntu.com/index.php?m=mobile&c=tours&a=fee_detail&id=";
        NSString *fullUrl = [NSString stringWithFormat:@"%@%@&client_type=3",url,_detailData[@"id"]];
        [self loadData:fullUrl];
    }else{
    //发送请求重要提示
        NSString *url = @"http://s.juntu.com/index.php?m=mobile&c=tours&a=notice_detail&id=";
        NSString *fullUrl = [NSString stringWithFormat:@"%@%@&client_type=3",url,_detailData[@"id"]];
        [self loadData:fullUrl];
    }
    
    
}
-(void)loadData:(NSString *)url{
   
    //重新创建一个webView
//       _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    NSURL *fullUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:fullUrl];
    _webView.scrollView.delegate = self;
    [_webView loadRequest:request];
    
    //刷新数据
    [_tableView reloadData];
}
//4.WEBView
-(void)_creatWebView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    NSString *urlString = @"http://s.juntu.com/index.php?m=mobile&c=tours&a=stroke_detail&id=";
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@&client_type=3",urlString,_detailData[@"id"]];
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
   _webView.scrollView.delegate = self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当网页滚动到最上方就使tableView滚动到最下方
    if (_webView.scrollView.contentOffset.y <0) {

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }

}

//5.电话遮盖视图
-(void)_creatPhoneView{
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneView];
    
    //两个按钮
    UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth/2-15, 30)];
    UIButton *buyButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 5, kScreenWidth/2, 30)];
    
    [phoneView addSubview:buyButton];
    [phoneView addSubview:phoneButton];
    
    
    //添加按钮属性
    [buyButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    //圆角
    buyButton.layer.cornerRadius = 15;
    phoneButton.layer.cornerRadius = 15;
    //背景
    buyButton.backgroundColor = [UIColor orangeColor];
    phoneButton.backgroundColor = [UIColor whiteColor];
    //文字
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [phoneButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    //文字颜色
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    //添加边框
    buyButton.layer.borderWidth = 1;
    phoneButton.layer.borderWidth = 1;
    
    buyButton.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    
}
//底部点击事件
-(void)buyAction{
    NSLog(@"购买");
}
-(void)callAction{
    NSLog(@"打电话");
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *tourDetailcell = [tableView dequeueReusableCellWithIdentifier:@"tourDetailcell"];
    if(tourDetailcell == nil){
        tourDetailcell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tourDetailcell"];
    }
    if(indexPath.section == 0){
        [tourDetailcell.contentView addSubview:_calendar];
        tourDetailcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        [tourDetailcell.contentView addSubview:_webView];
        tourDetailcell.accessoryType = UITableViewCellAccessoryNone;
    }
    tourDetailcell.selectionStyle = UITableViewCellSelectionStyleNone;
    return tourDetailcell;
    
    
}


#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0){
        return nil;
    }
    return _changeView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 44;
    }
    
    return kScreenHeight;
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
