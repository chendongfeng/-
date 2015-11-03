//
//  HotelSIftViewController.h
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseViewController.h"

@interface HotelSIftViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSArray *data;
@end
