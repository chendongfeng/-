//
//  HotelCell.h
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelModel.h"
#import "LineLabel.h"
@interface HotelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *juntu_Price;
@property (weak, nonatomic) IBOutlet LineLabel *market_price;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@property(nonatomic,strong)HotelModel *model;
@end
