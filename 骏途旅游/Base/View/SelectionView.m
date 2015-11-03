//
//  SelectionView.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/13.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "SelectionView.h"
#import "MyButton.h"
//@interface SelectionView ()
//{
//    }
@implementation SelectionView
{
    UIImageView *_imageView;
    NSMutableArray *_buttonArray;
    UITableView *_tableView;


}

-(instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray DataArray:(NSArray *)dataArray
{
    if (self == [super initWithFrame:frame]) {
        _titleArray = titleArray;
        _dataArray = dataArray;
        [self _creatView];
    }
    return self;
}
-(void)_creatView{

   

//    NSArray *title = @[@"游玩天数",@"主题分类",@"参团性质",@"价格排序"];
    
    //计算每个button的大小
    CGFloat width = [UIScreen mainScreen].bounds.size.width/_titleArray.count;
    
    _buttonArray = [[NSMutableArray alloc] init];
    
    for (int i = 0;i < _titleArray.count; i++) {
       
        //初始化
        MyButton *button = [[MyButton alloc] initWithTitle:_titleArray[i] imageName:@"arrow_down_expanablelistview111" frame:CGRectMake(i*width, 0, width, self.frame.size.height)];
        
        //添加点击事件
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside
         ];
        
        //设置普通状态和选中状态的图片
        button.selctImage = [UIImage imageNamed:@"arrow_down_expanablelistview111"];
        button.normalImage = [UIImage imageNamed:@"arrow_up_expanablelistview111"];
        
        //设置tag值
        button.tag = 100 + i;
        
        //将button添加到数组
        [_buttonArray addObject:button];
        
        [self addSubview:button];
    }
    
    
}




-(void)buttonAction:(MyButton *)btn{
    [_tableView removeFromSuperview];
   
    NSInteger index = btn.tag - 100;
    
    //根据tag值改变tableView的数据
    _dataArray = _Data[index];
    
    [self _creatTabelView];
    //循环修改button的isSelect
    for (int i = 0; i < _buttonArray.count; i++) {
        
        //选中的button不进行修改
        if (i == index) {
            continue;
        }
        
        MyButton *button = _buttonArray[i];
        button.isSelect = NO;
        
    }
    
    //取反
    btn.isSelect =! btn.isSelect ;
    
    //当处于选中状态创建tableview,否则移除
    if (btn.isSelect == YES) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _tableView.hidden = NO;
        }];
        
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            [_tableView removeFromSuperview];
            _tableView.hidden = YES;
        }];
        
        
    }
    
}



//创建tableView
-(void)_creatTabelView{
    
    
    CGFloat height = 0;
    if (_dataArray.count * 44 < 300) {
        
        height = _dataArray.count * 44;
        
    }else{
    
        height = 300;
    }
    
    CGFloat y = self.frame.origin.y+self.frame.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.superview addSubview:_tableView];
    
}

//tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当选中时应该根据

}



@end
