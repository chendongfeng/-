//
//  HotelDetailViewController.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "MyNetWorkQuery.h"
#import "UIImageView+WebCache.h"
#import "HeadView.h"
#import "HotelDetailCell.h"
#import "BaseHead.h"
#define kScrennWidth [UIScreen mainScreen].bounds.size.width

@interface HotelDetailViewController ()
{
    UITableView *_tableView;
    NSDictionary *_dataDic;
    NSArray *_roomList;
    NSMutableArray *_numberArray;
}
@end

@implementation HotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatTableView];
    self.title = @"酒店详情";
    [self _creatShareAction];
}
//分享按钮
-(void)_creatShareAction{
    ShareButton *share = [[ShareButton alloc] initWithFrame:CGRectMake(0, 0, 31, 33)];
    
    //添加到导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
}

#pragma mark - 创建tableView
-(void)_creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate =self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [self _loadData];
}

#pragma mark - 数据处理
-(void)_loadData{
    
    _numberArray = [[NSMutableArray alloc] init];
    
    NSArray *hotelShowArray = [_result objectForKey:@"hotelShow"];
    _dataDic = hotelShowArray[0];
    _roomList = [_dataDic objectForKey:@"roomlist"];
    
    for (int i = 0; i < _roomList.count; i++) {
        NSDictionary *dic = _roomList[i];
        if ([[dic objectForKey:@"juntu_price"] isEqualToString:@"0"]) {
        }else{
            
            [_numberArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
    }
    
    //刷新UI
    [_tableView reloadData];
        
  
}

#pragma mark - tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 4) {
        if (_numberArray != nil) {
            
            return _numberArray.count;
        }
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotelCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelDetailCell" owner:self options:nil]lastObject];
    }
    NSString *number = _numberArray[indexPath.row];
    int i = [number intValue];
    cell.dataDic = _roomList[i];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 4) {
        
        return 98;
    }
    return 0;
}
//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    //打图
    if (section == 0) {
        
        return 200;
        
    }else if (section == 1){
    
        return 20;
    
    }

    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    //图片的数据读取
    NSArray *images = [_dataDic objectForKey:@"images"];
    NSDictionary *imagesDic = images[0];
    
    if (section == 0) {
        if (_dataDic != nil) {
            
            UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth, 200)];
            [headImageView sd_setImageWithURL:[NSURL URLWithString:[imagesDic objectForKey:@"url"]]placeholderImage:[UIImage imageNamed:kplaceImage]];
            return headImageView;
            
        }
    }else if (section == 1){
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth, 20)];
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.text = [_dataDic objectForKey:@"title"];
        return nameLabel;
    
    }else if (section == 2){
        
        HeadView *positionView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth, 44)
                                                       ImageName:@"location"
                                                       LabelText:[_dataDic objectForKey:@"position"]
                                                  arrowImageName:@"arrow2x.png"];
        return positionView;
        
    }else if (section == 3){
    
        HeadView *detailView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth, 44)
                                                ImageName:@"detail@2x"
                                                LabelText:@"酒店介绍"
                                           arrowImageName:@"arrow2x.png"];
        return detailView;
        
    }else if (section == 4){

        //富文本
        NSString *arrivalTime = @"2015-10-30";
        NSString *leaveTime = @"2015-11-1";
        NSString *timeStr = [NSString stringWithFormat:@"入住 %@  离店 %@   修改",arrivalTime,leaveTime];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:timeStr];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.0 alpha:1] range:[timeStr rangeOfString: @"2015-10-30" ]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.0 alpha:1] range:[timeStr rangeOfString: @"2015-11-1" ]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.0 alpha:1] range:[timeStr rangeOfString: @"修改" ]];
        
        //头视图的控件
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScrennWidth, 44)];
        timeLabel.attributedText = attrStr;
        timeLabel.font = [UIFont systemFontOfSize:14];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, 15, 15, 15)];
        arrowImage.contentMode = UIViewContentModeScaleAspectFit;
        arrowImage.image =[UIImage imageNamed:@"arrow2x.png"];
        arrowImage.userInteractionEnabled = YES;
        
        UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth, 44)];
        [timeView addSubview:timeLabel];
        [timeView addSubview:arrowImage];
        timeView.backgroundColor = [UIColor whiteColor];
        return timeView;
       
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 20;
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
