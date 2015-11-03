//
//  ScienciViewController3.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/24.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "ScienciViewController3.h"
#import "MyNetWorkQuery.h"
#import "ScenticModel.h"
#import "ScenticTableView.h"
#import "ShareButton.h"
#import "UIImageView+WebCache.h"
@interface ScienciViewController3 ()
{
    ScenticTableView *_tableView;
    ScenticModel *_model;
}
@end

@implementation ScienciViewController3

- (void)viewDidLoad {
  
    [super viewDidLoad];
    
    self.title = @"景区详情";
   
    [self _creatTableView];
    [self _loadData];
    [self _creatShareAction];
    
}

//分享按钮
-(void)_creatShareAction{
    ShareButton *share = [[ShareButton alloc] initWithFrame:CGRectMake(0, 0, 31, 33)];

    //添加到导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
}

#pragma mark - 数据处理
-(void)_loadData{

            _model = [[ScenticModel alloc] initContentWithDic:_detaiData];
            _tableView.model = _model;
            [_tableView reloadData];
  
    
}

-(void)_creatTableView{

    _tableView = [[ScenticTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
