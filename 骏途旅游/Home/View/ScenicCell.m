//
//  ScenicCell.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "ScenicCell.h"

@implementation ScenicCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setDataDic:(NSDictionary *)dataDic{

    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
    
    
    
    
    UILabel *_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280, 20)];
    _nameLabel.text = [_dataDic objectForKey:_labelName];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_nameLabel];
    //预购时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 200, 20)];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.text = @"可在14:00前预订今日票";
    timeLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:timeLabel];
    
    //购物须知
    UIButton *attentionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 70, 20)];
    attentionButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [attentionButton setTitleColor:[UIColor colorWithRed:116/255 green:116/255 blue:116/255 alpha:1] forState:UIControlStateNormal];
    attentionButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [attentionButton setTitle:@"购物须知" forState:UIControlStateNormal];
    [self.contentView addSubview:attentionButton];
    
    //价格
    NSString *juntuPriceStr = [NSString stringWithFormat:@"￥%@",[_dataDic objectForKey:_juntuPrice]];
    UILabel *juntuPiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 30, 70, 30)];
    juntuPiceLabel.text = juntuPriceStr;
    juntuPiceLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:juntuPiceLabel];
    
    NSString *markPriceStr = [NSString stringWithFormat:@"￥%@",[_dataDic objectForKey:_marketPrice]];
    UILabel *marketPiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(203, 50, 70, 30)];
    marketPiceLabel.text = markPriceStr;
    marketPiceLabel.font = [UIFont systemFontOfSize:12];
    marketPiceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:marketPiceLabel];
    
    ////能否订票
    UIImageView *orderImage = [[UIImageView alloc] initWithFrame:CGRectMake(250, 30, 50, 50)];
    orderImage.image = [UIImage imageNamed:@"order-btn"];
    orderImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:orderImage];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
