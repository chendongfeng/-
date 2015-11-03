 //
//  HotelDetailCell.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineLabel.h"
@interface HotelDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;
@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *breakfastAndBedTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *JuntuPriceLabel;
@property (weak, nonatomic) IBOutlet LineLabel *marketPriceLabel;

@property (nonatomic, copy) NSDictionary *dataDic;
@end
