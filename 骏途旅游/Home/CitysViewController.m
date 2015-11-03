//
//  CitysViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "CitysViewController.h"
#import "MyNetWorkQuery.h"
#import "BaseHead.h"
@interface CitysViewController ()
{
    NSArray *_cityName;
    NSArray *_cityData;
    UITableView *_tableView;
}
@end

@implementation CitysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"目的地选择";
    [self _creatTableView];
    [self _loadData];
    
}
//表视图
-(void)_creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //注册单元格
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];
    [self.view addSubview:_tableView];
}

-(void)_loadData{
    NSString *urlString = @"http://www.juntu.com/index.php?m=app&c=scenic_rec&a=city";
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        //        NSLog(@"%@",result);
        NSArray *cityArray = result[@"cityList"];
        //获得城市名字ID
        NSMutableArray *citys = [[NSMutableArray alloc] init];
        NSMutableArray *cityIds = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in cityArray){
            NSString *cityName = dic[@"city"];
            NSString *cityID = dic[@"cityid"];
            [citys addObject:cityName];
            [cityIds addObject:cityID];
        }
        //存储数据
        _cityName = citys;
        _cityData = cityArray;
        //刷新表格
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    } errorHandle:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cityName.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _cityName[indexPath.row];
    return cell;
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //移除之前的数据
//     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"selectedCity"];
    //写入本地吧o(╯□╰)o
    [[NSUserDefaults standardUserDefaults] setObject:_cityData[indexPath.row] forKey:kselectedCity];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    //返回上个界面
    [self.navigationController popViewControllerAnimated:YES];
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
