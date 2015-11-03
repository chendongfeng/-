//
//  ScenticTableView.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/24.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "ScenticTableView.h"
#import "ScenticCell2.h"
#import "UIImageView+WebCache.h"
#import "HeadView.h"
#import "MapViewController.h"
#import "UIView+UIViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ScenticTableView
{
    NSMutableArray *_dicArray;//list不为空的字典
    NSMutableArray *_headImageNames;//头视图标签图名字
    NSMutableArray *_headViewArray; //头视图数组
    HeadView *_headView;
    NSMutableArray *_isHiddenArray;//判断是否收起
    NSMutableArray *_numberArray;//记录在六项数据中哪几项数据不为空
    UILabel *_scenicLabel;//景区特色的文本
    int j;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self == [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        NSArray *array = @[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"];
        _isHiddenArray = [NSMutableArray arrayWithArray:array];
        _numberArray = [[NSMutableArray alloc] init];
        _dicArray = [[NSMutableArray alloc] init];
        _headImageNames = [[NSMutableArray alloc] init];
        _headViewArray = [[NSMutableArray alloc] init];
        //        self.backgroundColor = [UIColor clearColor];
        j = 0;
        
    }
    return self;
}

//数据处理


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < _dicArray.count + 2 && section >= 2 ) {
        if (_dicArray.count != 0) {
            if ([_isHiddenArray[section - 2] isEqualToString:@"0"]) {
                NSDictionary *dic = _dicArray[section - 2];
                NSArray *array = [dic objectForKey:@"lists"];
                
                return array.count;
            }else{
                
                return 0;
                
            }
        }
        
    }else if (section == _dicArray.count + 2){
        
        return 1;
        
    }
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _dicArray.count + 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        }
        if (_scenicLabel.text == nil) {
            _scenicLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth, 200)];
            _scenicLabel.numberOfLines = 0;
            _scenicLabel.backgroundColor = [UIColor clearColor];
            _scenicLabel.text = _model.dest_highlight;
            _scenicLabel.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:_scenicLabel];
        }
        
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg.jpg"]];
        
        return cell;
    }else{
        ScenticCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"scenticCell"];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ScenticCell2" owner:self options:nil]lastObject];
        }
        if (_dicArray.count != 0) {
            NSDictionary *dic = _dicArray[indexPath.section - 2];
            NSArray *listArray = [dic objectForKey:@"lists"];
            cell.dicData = listArray[indexPath.row];
            NSInteger i = [_numberArray[indexPath.section - 2] integerValue];
            cell.index = i;
        }
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg.jpg"]];
        
        return cell;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    NSArray *imagesNames = @[@"maizeng@2x",@"ticket",@"maizeng@2x",@"taocan@2x",@"jingjiajiu@2x",@"taocan@2x"];
    
    for (int i = 0; i < _model.show.count; i++) {
        NSDictionary *dic = _model.show[i];
        NSString *imageStr = imagesNames[i];
        NSArray *listArray = [dic objectForKey:@"lists"];
        
        if (j < _model.show.count ) {
            if (listArray.count != 0) {
                [_dicArray addObject:dic];
                [_headImageNames addObject:imageStr];
                NSString *number = [NSString stringWithFormat:@"%d",i];
                [_numberArray addObject:number];
            }
        }
        
        j++;
    }
    return _dicArray.count + 5;
    
}

#pragma mark --头视图的设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        //背景大图
        UIImageView *bigImageview  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        [bigImageview sd_setImageWithURL:[NSURL URLWithString:_model.thumb]];
        //景区名称
        UILabel *scenicNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 150, 15)];
        scenicNameLabel.text = _model.title;
        
        scenicNameLabel.font = [UIFont systemFontOfSize:12];
        scenicNameLabel.textColor = [UIColor whiteColor];
        [bigImageview  addSubview:scenicNameLabel];
        
        //门票的背景图片
        UIImageView *numberImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 160, 40, 20)];
        numberImageView.image = [UIImage imageNamed:@"weiba2x"];
        [bigImageview  addSubview:numberImageView];
        
        //门票数量
        NSString *numberStr = [NSString stringWithFormat:@"%ld张",_model.images.count];
        UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        numberLable.textAlignment = NSTextAlignmentCenter;
        numberLable.text = numberStr;
        numberLable.textColor = [UIColor whiteColor];
        numberLable.font = [UIFont systemFontOfSize:12];
        [numberImageView addSubview:numberLable];
        return bigImageview;
    }else if (section == 1){
        
        //地理位置
        HeadView *positionView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)
                                                       ImageName:@"location"
                                                       LabelText:_model.position
                                                  arrowImageName:@"arrow2x"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [positionView addGestureRecognizer:tap];
        
        return positionView;
    }else if (section < _dicArray.count +2 ){
        NSDictionary *dic = _dicArray[section - 2];
        HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)
                                                   ImageName:_headImageNames[section - 2]
                                                   LabelText:[dic objectForKey:@"type_name"]
                                              arrowImageName:@"down_12x"];
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        button.tag = section - 2;
        [headView addSubview:button];
        
        [_headViewArray addObject:headView];
        return headView;
        
        
    }else if (section == _dicArray.count + 2 ){
        
        HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)
                                                   ImageName:@"star12x"
                                                   LabelText:@"景区特色"
                                              arrowImageName:nil];
        return headView;
    }else if(section == _dicArray.count + 3 ){
        HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)
                                                   ImageName:@"detail@2x"
                                                   LabelText:@"景区详情"
                                              arrowImageName:@"arrow2x"];
        return headView;
        
    }else{
        
        HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)
                                                   ImageName:@"wenhao2"
                                                   LabelText:@"预订须知"
                                              arrowImageName:@"arrow2x"];
        return headView;
    }
    
    return nil;
}

//下放收起响应事件
-(void)buttonAction:(UIButton *)btn{
    
    if ([_isHiddenArray[btn.tag] isEqualToString:@"0"]) {
        [_isHiddenArray replaceObjectAtIndex:btn.tag withObject:@"1"];
        
    }else{
        
        [_isHiddenArray replaceObjectAtIndex:btn.tag withObject:@"0"];
        
        
    }
    //    NSIndexSet *set = [NSIndexSet indexSetWithIndex:btn.tag + 2];
    //    [self reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    [self reloadData];
}


//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _dicArray.count + 2) {
        return 200;
    }
    return 100;
}

//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 200;
    }
    return 44;
    
}

//尾视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 ) {
        return 20;
    }
    return 0;
    
}

//手势
-(void)tapAction{
    MapViewController *map = [[MapViewController alloc] init];
    map.hidesBottomBarWhenPushed = YES;
    NSArray *mapArray = [_model.map componentsSeparatedByString:@"|"];
    map.mapArray = mapArray;
    map.position = _model.position;
    [self.viewController.navigationController pushViewController:map animated:YES];
    
}
@end
