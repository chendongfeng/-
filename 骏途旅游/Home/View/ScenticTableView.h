//
//  ScenticTableView.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/24.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenticModel.h"
@interface ScenticTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)ScenticModel *model;
@end
