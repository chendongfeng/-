//
//  TourHeadView.m
//  骏途旅游
//
//  Created by mac10 on 15/10/18.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "TourHeadView.h"
#import "UIImageView+WebCache.h"
#import "BaseHead.h"
@implementation TourHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"TourHeadView" owner:self options:nil]lastObject];;
        [view setFrame:frame];
        view.backgroundColor = [UIColor whiteColor];
        self  = (TourHeadView *)view;
        
    }
    return self;
}

-(void)setHeadData:(NSDictionary *)headData{
    if (_headData!=headData) {
        _headData = headData;
          //图片
        NSArray *images = headData[@"images"];
        NSString *urlString = images[0][@"url"];
        [_ImageViews sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:kplaceImage]];
        _imageCountLabel.text = [NSString stringWithFormat:@"%li张",images.count];
        //日程
        _spend_timeLabel.text = [NSString stringWithFormat:@"行程：%@天",headData[@"spend_time"]];
        //标题
        _titleLabel.text = headData[@"title"];
        //价格
        _juntu_PriceLabel.text = [NSString stringWithFormat:@"￥%@",headData[@"juntu_price"]];
        //出发地
        _setUp_cityLabel.text = [NSString stringWithFormat:@"出发地：%@",headData[@"setup_city"]];
        //编号
        _production_noLabel.text = [NSString stringWithFormat:@"编号：%@",headData[@"production_no"]];
        
        
    }
  
  

}

@end
