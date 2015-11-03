//
//  SiftViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/15.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "SiftViewController.h"
#import "BaseHead.h"

#import "SifiModel.h"
#import "SelectionView.h"

#import "siftType.h"
#import "JuntutableView.h"
@interface SiftViewController ()
{
    JuntutableView *_tableView;
    NSMutableArray *_sifiArray;
    NSMutableArray *_selectionArray;
}
@end

@implementation SiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _myTitle;
    _selectionArray = [NSMutableArray array];

    //头部筛选视图
    [self _creatHeadView];
    [self _creatTableView];
    [self _creatShareAction];
}
//分享按钮
-(void)_creatShareAction{
    ShareButton *share = [[ShareButton alloc] initWithFrame:CGRectMake(0, 0, 31, 33)];
    
    //添加到导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
}


-(void)_creatHeadView{
   
    siftType *sift = [[siftType alloc]init];
    sift.type = _type;
    //获取分类信息
    NSArray *data = [sift getData:_type];
    //获取按钮标题
    NSArray *title = [sift gettitle:_type];
    SelectionView *selection = [[SelectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30) TitleArray:title DataArray:data[0]];
    
    selection.Data = data;
   
    [self.view addSubview:selection];
}

-(void)_creatTableView{
    _tableView = [[JuntutableView alloc] initWithFrame:CGRectMake(0, 64+30,kScreenWidth, kScreenHeight-94) style:UITableViewStylePlain];
    //    _tableView.backgroundColor = [UIColor redColor];
   _tableView.sifiArray = _sifiArray;
    _tableView.type = _myTitle;
    [self.view addSubview:_tableView];
}

-(void)setSearchData:(NSArray *)searchData{
    //当有数据传入时
    if(_searchData!=searchData){
        _searchData = searchData;
        _sifiArray = [[NSMutableArray alloc]init];
        //存入数据
        for(NSDictionary *dic in _searchData){
            SifiModel *model = [[SifiModel alloc]initContentWithDic:dic];
            [_sifiArray addObject:model];
        }
       
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
