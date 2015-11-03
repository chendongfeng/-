//
//  TourTableViewCell.h
//  骏途旅游
//
//  Created by mac10 on 15/10/7.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TourModel.h"
@interface TourTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *product_thumbImage;
@property (weak, nonatomic) IBOutlet UILabel *product_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *product_sec_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *product_priceLabel;

@property(nonatomic,strong)TourModel *tourModel;
@end
