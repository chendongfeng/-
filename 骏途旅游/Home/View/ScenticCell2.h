//
//  ScenticCell2.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/24.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenticModel.h"
#import "LineLabel.h"
@interface ScenticCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet LineLabel *marketPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *juntuPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSDictionary *dicData;
@end
