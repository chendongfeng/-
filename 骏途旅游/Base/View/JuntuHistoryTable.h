//
//  JuntuHistoryTable.h
//  骏途旅游
//
//  Created by mac10 on 15/10/11.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuntuHistoryTable : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)NSArray *tableData;


@end
