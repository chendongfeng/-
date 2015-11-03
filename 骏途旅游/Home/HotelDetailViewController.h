//
//  HotelDetailViewController.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseViewController.h"

@interface HotelDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, copy)NSDictionary *result;
@end
