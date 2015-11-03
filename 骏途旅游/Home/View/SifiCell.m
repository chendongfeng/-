//
//  SifiCell.m
//  骏途旅游
//
//  Created by mac10 on 15/10/13.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "SifiCell.h"
#import "UIImageView+WebCache.h"
@implementation SifiCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(SifiModel *)model{
    if(_model!=model){
        _model = model;
        //图片
        NSString *thump = _model.thumb;
        [_thumpImageView sd_setImageWithURL:[NSURL URLWithString:thump] placeholderImage:[UIImage imageNamed:@"160.jpg"]];
        _titleLabel.text = _model.title;
        //子标题
        _descriptionLabel.text = _model.myDescription;
        
        if(_model.myDescription.length == 0){
            _descriptionLabel.text = _model.sub_title;
        }
        //市场价格
        _oldPriceLabel.hidden = YES;
        if(_model.market_price.length!=0){
            _oldPriceLabel.labelText = [NSString stringWithFormat:@"￥%@",_model.market_price];
            _oldPriceLabel.hidden = NO;
        }
        if(_model.min_price.length!=0){
            _oldPriceLabel.labelText = [NSString stringWithFormat:@"￥%@",_model.min_price];
            _oldPriceLabel.hidden = NO;
        }

       //当前价格
        _priceLabel.hidden = YES;
        if(_model.juntu_price.length!=0){
         _priceLabel.text = [NSString stringWithFormat:@"￥%@起",_model.juntu_price];
            _priceLabel.hidden = NO;
        }
        if(_model.max_price.length!=0){
            _priceLabel.text = [NSString stringWithFormat:@"￥%@起",_model.max_price];
            _priceLabel.hidden = NO;
        }
       
        //跟团
        if([_model.group_type isEqualToString:@"group"]){
            _typeImageView.image = [UIImage imageNamed:@"gentuan_xiao12x"];
            
        }
        //自驾
        if ([_model.is_self_drive isEqualToString:@"Y"]){
            _typeImageView.image = [UIImage imageNamed:@"zijiayou_xiao"];
            
        }//直通
        if ([_model.is_train isEqualToString:@"Y"]){
             _typeImageView.image = [UIImage imageNamed:@"zhitoncghe_xiao"];
        }
        _couponLabel.hidden = YES;
//                if(_model.minus !=0){
//                    _couponLabel.hidden = YES;
//                }
        
        _cutLabel.hidden = NO;
        if([_model.coupon_status isEqualToString:@"N"]){
            _cutLabel.hidden = YES;
        }
    }
 
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
