//
//  HotelCell.m
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "HotelCell.h"
#import "UIImageView+WebCache.h"
#import "BaseHead.h"
@implementation HotelCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(HotelModel *)model{
    _market_price.labelText = [NSString stringWithFormat:@"￥%@", model.market_price];
    _juntu_Price.text = [NSString stringWithFormat:@"￥%@起",model.juntu_price];
    _positionLabel.text = model.position;
    _titleLabel.text = model.title;
    //图片
    NSURL *url = [NSURL URLWithString:model.thumb];
    [_thumbImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:kplaceImageSmall]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
