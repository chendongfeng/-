//
//  JuntutableView.h
//  骏途旅游
//
//  Created by mac10 on 15/10/20.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SifiModel.h"
#import "SifiCell.h"
#import "BaseHead.h"
#import "MyNetWorkQuery.h"
#import "TourDetailViewController.h"
#import "UIView+UIViewController.h"
//旅游和景点列表tableView
@interface JuntutableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSArray *sifiArray;
@property(nonatomic,copy)NSString *type;
@end
