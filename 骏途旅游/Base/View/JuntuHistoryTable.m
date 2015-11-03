//
//  JuntuHistoryTable.m
//  骏途旅游
//
//  Created by mac10 on 15/10/11.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "JuntuHistoryTable.h"
#import "BaseHead.h"
@implementation JuntuHistoryTable
{
    UIView *_clearView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setAttribute];
        
    }
    return self;
}
-(void)setAttribute{
    self.delegate=self;
    self.dataSource=self;

    //创建清除图
    _clearView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:_clearView.frame];
    label.text = @"清空搜索记录";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor cyanColor];
    label.textAlignment = NSTextAlignmentCenter;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3-2, 7, 15, 15)];
    imageView.image = [UIImage imageNamed:@"top_qingkong2x"];
    
    [_clearView addSubview:label];
    [_clearView addSubview:imageView];
    
    
//    self.scrollEnabled = NO;
}
-(void)setTableData:(NSArray *)tableData{
    if(_tableData!=tableData){
        _tableData = tableData;
         [self reloadData];
    }
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.tableData.count+1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"historyCell"];
    }
//    cell.backgroundColor = [UIColor redColor];
    if(indexPath.row==self.tableData.count){
        [cell.contentView addSubview:_clearView];
        return cell;
    }else{
    cell.textLabel.text = self.tableData[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
      
        return cell;
    }
    
}

//选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==_tableData.count) {
        NSLog(@"清除数据");
    }
    
}

@end
