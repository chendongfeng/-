//
//  TourHeadView.h
//  骏途旅游
//
//  Created by mac10 on 15/10/18.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *ImageViews;
@property (weak, nonatomic) IBOutlet UILabel *production_noLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *setUp_cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *juntu_PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *spend_timeLabel;

@property(nonatomic,copy)NSDictionary *headData;
@end
