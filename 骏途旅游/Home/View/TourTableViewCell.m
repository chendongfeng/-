//
//  TourTableViewCell.m
//  骏途旅游
//
//  Created by mac10 on 15/10/7.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "TourTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TourTableViewCell


-(void)setTourModel:(TourModel *)tourModel{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //通过传递的model改变单元格的数据
    _nameLabel.text = [NSString stringWithFormat:@"%@",tourModel.name];
    _product_priceLabel.text = [NSString stringWithFormat:@"￥%@",tourModel.product_price];
    _product_sec_titleLabel.text = tourModel.product_sec_title;
    //设置图片
    _product_thumbImage.layer.cornerRadius = 7;
    _product_thumbImage.layer.masksToBounds = YES;
    [_product_thumbImage sd_setImageWithURL:[NSURL URLWithString:tourModel.product_thumb] placeholderImage:[UIImage imageNamed:@""]];
    _product_titleLabel.text = tourModel.product_title;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
