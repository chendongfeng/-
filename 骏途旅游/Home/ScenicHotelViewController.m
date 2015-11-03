//
//  ScenicHotelViewController.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "ScenicHotelViewController.h"
#import "MyNetWorkQuery.h"
#import "ScenicHotelModel.h"
#import "ScenicHotelTableView.h"
#import "BaseHead.h"
@interface ScenicHotelViewController ()
{
    NSMutableArray *_dataArray;
    ScenicHotelModel *_model;
    ScenicHotelTableView *_scenicHotelTabelView;
    
}
@end

@implementation ScenicHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"景+酒详情";
    _dataArray = [[NSMutableArray alloc] init];
   
    _scenicHotelTabelView = [[ScenicHotelTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scenicHotelTabelView];
     [self _loadData];
    [self _creatShareAction];
    // Do any additional setup after loading the view.
}

//分享按钮
-(void)_creatShareAction{
    ShareButton *share = [[ShareButton alloc] initWithFrame:CGRectMake(0, 0, 31, 33)];
    
    //添加到导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)_loadData{
    
    
_model = [[ScenicHotelModel alloc] initContentWithDic:_detailData];
        _scenicHotelTabelView.model = _model;

    [_scenicHotelTabelView reloadData];
    

}

@end
