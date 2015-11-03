//
//  HotelDetailCell.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "HotelDetailCell.h"
#import "UIImageView+WebCache.h"
#import "BaseHead.h"
@implementation HotelDetailCell

- (void)awakeFromNib {

}
-(void)setDataDic:(NSDictionary *)dataDic{
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
   
    if ([[_dataDic objectForKey:@"thumb"] isEqualToString:@""]) {
        _hotelImageView.image = [UIImage imageNamed:@"160.jpg"] ;

    }else{
        [_hotelImageView sd_setImageWithURL:[NSURL URLWithString:[_dataDic objectForKey:@"thumb"]]placeholderImage:[UIImage imageNamed:kplaceImageSmall]];

    }
    _roomNameLabel.text = [_dataDic objectForKey:@"room_name"];
    
    NSString *breakfast = [_dataDic objectForKey:@"breakfast"];
    NSString *bedType = [_dataDic objectForKey:@"bed_type"];
    NSString *str = [NSString stringWithFormat:@"%@  %@",breakfast,bedType];
    _breakfastAndBedTypeLabel.text = str;
    
    NSString *juntuPricce = [NSString stringWithFormat:@"￥%@",[_dataDic objectForKey:@"juntu_price"]];
    _JuntuPriceLabel.text = juntuPricce;
    
    NSString *marketPricce = [NSString stringWithFormat:@"￥%@",[_dataDic objectForKey:@"market_price"]];
    _marketPriceLabel.labelText = marketPricce;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
