//
//  HomeViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/5.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "HomeViewController.h"
//网络处理
#import "BaseHead.h"
#import "MyNetWorkQuery.h"
#import "RequestJSON.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
//子视图
#import "ClassifyCollectionView.h"
#import "JuntuImageView.h"
#import "TourTableViewCell.h"
#import "TourModel.h"
//下级跳转界面
#import "MyJuntuViewController.h"
#import "SearchAllController.h"
#import "TourDetailViewController.h"

//进度条与刷新
#import "HUProgressView.h"
#import "MJDIYHeader.h"
#import "MJRefresh.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIView *_baseView;//上部基础视图
    UIScrollView *_scrollView;//滚动视图
    NSArray *_scrollViewData;//滚动视图的数据
    NSArray *_specialViewData;//推荐旅游数据
    NSArray *_leftTourData;//国外旅游的数据
    NSArray *_rightTourData;//国内旅游的数据
    UIWebView *_webView;//旅游网页打开
    UITableView *_tableView;//表视图
    NSMutableArray *_leftTourModel;//旅游信息
    NSMutableArray *_rightTourModel;
    NSArray *_selectedTourModel;//选中的信息利用这个改变境外和国内
    UIPageControl *_pageControl;//分页控制器
    UIButton *_inCountry;
    UIButton *_outCountry;
    BOOL _isSelectBool;//是否选中国内外游
    NSArray *_titles;
    ClassifyCollectionView *_classifyCollection;//8个按钮
    UIView *_secondView;//第二组的头视图
    NSTimer *_timer;//定时器对象

    UIView *_hiddenView;    //遮罩视图
    int _t;//用于滚动视图防止越界
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏设置
    self.title = nil;
    //导航栏
    [self _ceaatNav];
    //创建一个总的视图
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 420)];
    _baseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg.jpg"]];
    
     [self creatFirstCell];
    
    //创建表视图
    [self creatTableView];
    
    //第二头视图
    [self _creatSecondView];
   
    //获取数据
    [self getNetData];
   
}
-(void)viewDidAppear:(BOOL)animated{
    [self starTimerAction];
}
-(void)viewDidDisappear:(BOOL)animated{
    [_timer invalidate];
    _pageControl.currentPage = 0;
    _scrollView.contentOffset = CGPointMake(0, 0);
}

//导航栏
-(void)_ceaatNav{
    //    self.navigationController.navigationBar.alpha = 0.5;
    //1.创建小马图片
    UIImage *leftImage = [UIImage imageNamed:@"图标新2"];
    UIImageView *leftImageView = [[UIImageView alloc]initWithImage:leftImage];
    leftImageView.frame = CGRectMake(0, 0, 40, 25);
    //2.创建BarItem
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithCustomView:leftImageView];
    self.navigationItem.leftBarButtonItem = leftItem1;
    //导航栏搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 230, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = titleView.bounds;
    //设置字体
    [button setTitle:@"搜索目的地、景点、酒店等" forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    //设置搜索条
    [button setBackgroundImage:[UIImage imageNamed:@"1136_menu_btn_sousuotiao"] forState:UIControlStateNormal];
    //设置圆角
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    
    [button addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:button];
    [self.navigationItem setTitleView:titleView];
}

-(void)searchAction {
    //跳到搜索页
    SearchAllController *seach = [[SearchAllController alloc] init];
    seach.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seach animated:YES];
    
}

//获取网络资源
-(void)getNetData{
    NSString *urlString = @"http://www.juntu.com/index.php?m=app&c=index&a=index_focus&version=1.3";
    //开启多线程
   [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
       NSDictionary *response = result;
    
       //滚动视图的数据
       _scrollViewData = response[@"subject"];
       //特别推荐的数据
       _specialViewData = response[@"recommend"];
       
       //更新UI要在主线程中处理
       dispatch_sync(dispatch_get_main_queue(), ^{
       //获取第一张图片并将其传递给我的骏途
           NSDictionary *dic = _scrollViewData[0];
           //获取图片
           NSString *url = dic[@"thumb"];
           MyJuntuViewController *myJuntu = [[MyJuntuViewController alloc] init];
           myJuntu.headImageUrl = url;
           
           //创建第一个单元格
            //滚动视图
           [self _creatScrollView];
           //四个选项视图
           [self _creatSpecialButton];
           
           [_tableView reloadData];
       });
   } errorHandle:^(NSError *error) {
       
   }];
    

    //使用封装好的方法获取网络Json数据
    NSString *tourURLString = @"http://www.juntu.com/index.php?m=app&c=member&a=classification_list";
    //开启多线程
    [MyNetWorkQuery requestData:tourURLString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        NSDictionary *response = result;
        
        //国内外旅游的数据
        _leftTourData = response[@"returnProductList_left"];
        _rightTourData = response[@"returnProductList_right"];
        
        //更新UI要在主线程中处理
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_tableView.header endRefreshing];
             [self makeTourModel];
            [_tableView reloadData];
        });
    } errorHandle:^(NSError *error) {
        
    }];

    
  
   
//    [_tableView reloadData];
}

-(void)makeTourModel{
    _leftTourModel = [[NSMutableArray alloc] init];
    _rightTourModel = [[NSMutableArray alloc] init];
    //将获取的国内游和国外游数据添加到类中，并将其加入到数组中
    for (int i =0; i<_leftTourData.count; i++) {
        //经过检查当中存在空数据需要排除
        
        NSDictionary *dic = _leftTourData[i];
        if ((NSNull *)dic == [NSNull null] ) {
            continue;
        }
      TourModel *tour = [[TourModel alloc] initContentWithDic:dic];
        [_leftTourModel addObject:tour];
    }
    for (int i =0; i<_rightTourData.count; i++) {
        
        NSDictionary *dic = _rightTourData[i];
        if ((NSNull *)dic == [NSNull null] ) {
            continue;
        }
        TourModel *tour = [[TourModel alloc] initContentWithDic:dic];
        [_rightTourModel addObject:tour];
    }
    //将初始值赋给当前界面
    _selectedTourModel = _leftTourModel;
}

-(void)creatFirstCell{
 
  
    //八个选项分类视图
    NSArray *imageNames = @[@"1@2x",@"2@2x",@"3@2x",@"4@2x",@"5@2x",@"6@2x",@"7@2x",@"8@2x"];
    _titles = @[@"景点门票",@"出境游",@"国内游",@"天天特价",@"西安周边游",@"度假酒店",@"景加酒",@"自驾游"];
    _classifyCollection = [[ClassifyCollectionView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 180) ImageNames:imageNames Titles:_titles];
    
    _classifyCollection.backgroundColor = [UIColor whiteColor];
    [_baseView addSubview:_classifyCollection];
   
}
//滚动视图
-(void)_creatScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth*_scrollViewData.count, 150);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    //添加子视图
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    //循环添加图片
    for (int i = 0; i<_scrollViewData.count; i++) {
        NSDictionary *dic = _scrollViewData[i];
        //获取图片
        NSString *url = dic[@"thumb"];
        //获取打开的链接
       NSString *linkurl = dic[@"linkurl"];
        
        JuntuImageView *imageView = [[JuntuImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 150)];
        imageView.urlString = linkurl;
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"384.jpg"]];
        [_scrollView addSubview:imageView];
    }
    
    [_baseView addSubview:_scrollView];
    
    //创建分页控制器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth/4, 130, kScreenWidth/2, 15)];
    //    _pageControl.backgroundColor = [UIColor redColor];
    _pageControl.numberOfPages = _scrollViewData.count;
    _pageControl.currentPage = 0;
    
    [_baseView addSubview:_pageControl];
}
//四个分页视图
-(void)_creatSpecialButton{
    _t = 0;
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            JuntuImageView *imageView = [[JuntuImageView alloc] initWithFrame:CGRectMake(j*(kScreenWidth/2+2), 340+i*(45+2), kScreenWidth/2, 45)];
            //设置tag值响应点击
            imageView.tag = 100+_t;
            imageView.backgroundColor = [UIColor whiteColor];
          
            //为按钮添加图片
            NSDictionary *dic = _specialViewData[_t];
            //获取图片
            NSString *urlString = dic[@"thumb"];
            //获取打开的链接
            NSString *linkurl = dic[@"linkurl"];
            
            imageView.urlString = linkurl;
        
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"240.jpg"]];
            
            [_baseView addSubview:imageView];
            _t++;
        }
        
    }

}

//特别推荐位置的点击事件
-(void)specialAction:(UIButton *)button{
    NSInteger tag = button.tag-100;
    NSLog(@"特色推荐点击了%ld",tag);
    
}


-(void)creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    //设置下拉刷新
    _tableView.header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshAction)];
    
    //将tableView添加到self.View
    [self.view addSubview:_tableView];
}
-(void)freshAction{
    NSLog(@"刷新数据");
    _specialViewData = nil;
    _scrollViewData = nil;
    _t = 0;
    [self getNetData];
}
#pragma mark - UIScrollViewDelegate
//利用定时器启动改变滚动视图的当前页数
-(void)starTimerAction{
   _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}
-(void)timeAction{
   //page= 0,1,2,3,4,5,6,7
    //current = 1,2,3,4,5,6,7,8
    
//    NSInteger current = _pageControl.currentPage;

//    NSLog(@"%li",_pageControl.currentPage);
//    NSLog(@"%li",_scrollViewData.count);
    [UIView animateWithDuration:0.5 animations:^{
        if (_pageControl.currentPage == _scrollViewData.count-1) {
             _pageControl.currentPage=0;
            _scrollView.contentOffset = CGPointMake(_pageControl.currentPage*kScreenWidth, 0);
           
        }else{
             _pageControl.currentPage++;
            _scrollView.contentOffset = CGPointMake(_pageControl.currentPage*kScreenWidth, 0);
           
        }
    }];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger offset = scrollView.contentOffset.x;
    NSInteger page = offset/kScreenWidth;
    _pageControl.currentPage = page;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//第一组不需要头视图，需要一个单元格
{
    if (section==1) {
        
        return _selectedTourModel.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    if (indexPath.section==0) {
        //为第一组设置单元格
        UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        if (headCell==nil) {
            headCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headCell"];
        }
        [headCell.contentView addSubview: _baseView];
        headCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headCell;
    }
    
        // 从闲置池中获取cell
        TourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TourTableViewCell"];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TourTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.tourModel = _selectedTourModel[indexPath.row];

        return cell;
   
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //第一组的头视图高度为0
    if (section==0) {
        return 1;
    }
    return 30;
}
//设置头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    if (_isSelectBool == NO) {
        [_inCountry setTitleColor:[UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.f alpha:1] forState:UIControlStateNormal];
        [_outCountry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_inCountry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_outCountry setTitleColor:[UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.f alpha:1] forState:UIControlStateNormal];
    }

    return _secondView;
    
}
-(void)_creatSecondView{
    _secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    _secondView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1_2"]];
    //添加两个按钮到视图上
    _inCountry = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth/2, 20)];
    _outCountry = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2, 5, kScreenWidth/2, 20)];
    //为两个按钮添加相同的方法，改变表格的数据
    [_inCountry setTitle:@"境外精品游" forState:UIControlStateNormal];
    [_outCountry setTitle:@"国内错峰游" forState:UIControlStateNormal];
    
    _inCountry.titleLabel.font = [UIFont systemFontOfSize:13];
    _outCountry.titleLabel.font = [UIFont systemFontOfSize:13];
    
    if (_isSelectBool == NO) {
        [_inCountry setTitleColor:[UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.f alpha:1] forState:UIControlStateNormal];
        [_outCountry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_inCountry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_outCountry setTitleColor:[UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.f alpha:1] forState:UIControlStateNormal];
    }
    
    //被选择的情况
    //    [inCountry setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    //    [outCountry setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    //设置tag值用于区分哪个点击
    _inCountry.tag = 200;
    _outCountry.tag = 201;
    [_inCountry addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_outCountry addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_secondView addSubview:_inCountry];
    [_secondView addSubview:_outCountry];
    
}

//点击改变国内游和境外游
-(void)changeAction:(UIButton *)button{
    NSInteger index = button.tag-200;
//    NSLog(@"旅游路线点击了%li",index);
    if(index==0){
        _selectedTourModel = _leftTourModel;
        _isSelectBool = NO;
       
        
    }else{
        _selectedTourModel = _rightTourModel;
        
        _isSelectBool = YES;

    }
    [_tableView reloadData];
}


//设置单元格宽度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 430;
    }
    return 168;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建遮罩视图防止点击冲突
   
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
    
    [self.view addSubview:horseimage];
    [self.view addSubview:progress];
    [self.view addSubview:hiddenView];

    if (indexPath.section==1) {
        //实现点击直接跳转到详情界面
        TourModel *model = _selectedTourModel[indexPath.row];
        NSString *toursid = model.product_id;
        NSString *toursUrl = [NSString stringWithFormat:@"%@%@",ktoursDetail,toursid];
        //需要发送请求并将获得的数据传递给下个视图
        [MyNetWorkQuery requestData:toursUrl HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
      
            NSDictionary *toursShow = [result[@"toursShow"]lastObject];
//            NSLog(@"%@",toursShow);
            //返回主线程
            dispatch_sync(dispatch_get_main_queue(), ^{
                [horseimage removeFromSuperview];
                [progress removeFromSuperview];
                [hiddenView removeFromSuperview];
                _hiddenView.hidden = YES;
                TourDetailViewController *toursDetail = [[TourDetailViewController alloc] init];
                //传递数据
                toursDetail.detailData = toursShow;
                //打开旅游详情界面
                [self.navigationController pushViewController:toursDetail animated:YES];
                toursDetail.hidesBottomBarWhenPushed = YES;
            });
            
            
        } errorHandle:^(NSError *error) {
            NSLog(@"旅游详情%@",error);
        }];
        NSLog(@"%@",model.product_id);
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
