//
//  SelectionView.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/13.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, copy)NSArray *titleArray;
@property(nonatomic, copy)NSArray *dataArray;
//存储所有的数据
@property(nonatomic,copy)NSArray *Data;
-(instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray DataArray:(NSArray *)dataArray;
@end
