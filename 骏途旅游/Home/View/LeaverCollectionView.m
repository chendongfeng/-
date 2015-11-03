//
//  LeaverCollectionView.m
//  骏途旅游
//
//  Created by mac10 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "LeaverCollectionView.h"
#import "BaseHead.h"
@implementation LeaverCollectionView
{
    NSInteger _selectedIndex;
    UIView *_selecteView;
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    UILabel *_label4;
    UILabel *_label5;
    
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self){
        //设置属性
        [self setAttribute];
        [self _creatSubView];
    }
    return self;
}
-(void)setTitles:(NSArray *)titles{
    if( _titles!=titles){
        _titles = titles;

        [self reloadData];
    }
}
//子视图
-(void)_creatSubView{
    _selecteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    _selecteView.backgroundColor = [UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.f alpha:1];
    
   _label1 = [self label:_label1];
   _label2 = [self label:_label2];
    _label3 = [self label:_label3];
    _label4 = [self label:_label4];
    _label5 = [self label:_label5];
    
}
-(UILabel *)label:(UILabel *)label{
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    return label;
}

//设置属性
-(void)setAttribute{
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor clearColor];
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"leaveCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return _titles.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
   
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"leaveCell" forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 1;
#warning ......这里需要改进
    if(indexPath.row==_selectedIndex){
        [cell.contentView addSubview:_selecteView];
    }
    if(indexPath.row==0){
        
        _label1.text = @"不限";

        [cell.contentView addSubview:_label1];
    }else if(indexPath.row==1){
         _label2.text = _titles[indexPath.row];
            [cell.contentView addSubview:_label2];
    }else if(indexPath.row==2){
         _label3.text = _titles[indexPath.row];
        [cell.contentView addSubview:_label3];
    }else if(indexPath.row==3){
         _label4.text = _titles[indexPath.row];
        [cell.contentView addSubview:_label4];
    }else{
         _label5.text = _titles[indexPath.row];
        [cell.contentView addSubview:_label5];
    }
    
    return cell;
}
//选中事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",_titles[indexPath.row]);
    NSString *string = _titles[indexPath.row];
    if([string containsString:@"0"]){
//        NSLog(@"这是价格");
        //写入本地吧o(╯□╰)o
        string = [self _makeString:string];
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:kselectedPrice];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        

    }else{
//        NSLog(@"这是等级");
        //写入本地吧o(╯□╰)o
        string = [self _makeString:string];
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:kselectedLeave];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        

    }
 //改变选中图片
    _selectedIndex = indexPath.row;

    [self reloadData];
}
-(NSString *)_makeString:(NSString *)string{
    NSString *keyword;
     NSArray *priceArray = @[@"0不限",@"￥150以下",@"￥150-￥300",@"￥300-￥600",@"￥600以上"];
    NSArray *leaveArray = @[@"不限",@"二星级以下",@"三星级",@"四星级",@"五星级"];
    if([string isEqualToString: priceArray[0]]){
        keyword = @"-";
    }else  if([string isEqualToString: priceArray[1]]){
        keyword = @"-150";
    }else  if([string isEqualToString: priceArray[2]]){
        keyword = @"150-300";
    }else  if([string isEqualToString: priceArray[3]]){
        keyword = @"300-600";
    }else  if([string isEqualToString: priceArray[4]]){
        keyword = @"600-";
    }else if([string isEqualToString: leaveArray[0]]){
        keyword = @"-";
    }else if([string isEqualToString: leaveArray[1]]){
        keyword = @"2";
    }else if([string isEqualToString: leaveArray[2]]){
        keyword = @"3";
    }else if([string isEqualToString: leaveArray[3]]){
        keyword = @"4";
    }else if([string isEqualToString: leaveArray[4]]){
        keyword = @"5";
    }
        
    return keyword;
}




@end
