//
//  ScenicHotelTableView.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenicHotelModel.h"
@interface ScenicHotelTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)ScenicHotelModel *model;
@end
