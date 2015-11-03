//
//  ScenticCell2.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/24.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "ScenticCell2.h"

@implementation ScenticCell2

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setIndex:(NSInteger)index{
    if (_index != index) {
        _index = index;
    }
    if (_dicData.count != 0) {
        //        NSArray *array = [_dicData allValues];
        //        _titleLabel = array[1];
        //        NSLog(@"%@",array[5]);
        //        _marketPriceLabel.text = array[5];
        //        _juntuPriceLabel.text = array[7];
        NSArray *names = @[@"seckill_name",@"ticket_name",@"seckill_name",@"package_ticket_name",@"title",@"seckill_name"];
        NSArray *price1 = @[@"seckill_price",@"juntu_price",@"seckill_price",@"juntu_price",@"min_price",@"seckill_price"];
        NSArray *price2 = @[@"market_price",@"market_price",@"market_price",@"market_price",@"max_price",@"market_price"];
        NSString *title = [_dicData objectForKey:names[_index]];
        NSString *markPrice = [_dicData objectForKey:price2[_index]];
        NSString *juntuPrice = [_dicData objectForKey:price1[_index]];
        
        markPrice = [NSString stringWithFormat:@"￥%@",markPrice];
        juntuPrice = [NSString stringWithFormat:@"￥%@",juntuPrice];
        _titleLabel.text = title;
        _marketPriceLabel.labelText = markPrice;
        _juntuPriceLabel.text = juntuPrice;
    }

}

@end
