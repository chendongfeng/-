//
//  HeadView.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

-(instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)imageName LabelText:(NSString *)labelText arrowImageName:(NSString *)arrowName{

    if (self == [super initWithFrame:frame]) {
        _arrowImageName = arrowName;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        //门票名字
        _label = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 280, 20)];
        _label.text = labelText;
        _label.textColor = [UIColor grayColor];
        _label.font = [UIFont systemFontOfSize:12];
        [self addSubview:_label];
        
        //门票图标
        _arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, 15, 15, 15)];
        _arrowImage.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImage.image =[UIImage imageNamed:_arrowImageName];
        _arrowImage.userInteractionEnabled = YES;
        [self addSubview:_arrowImage];
        
        

        
        UIImageView *lineLmageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, [UIScreen mainScreen].bounds.size.width, 2)];
        lineLmageView.image = [UIImage imageNamed:@"1136_menu_background_lvkuang"];
        [self addSubview:lineLmageView];
        
        self.backgroundColor = [UIColor whiteColor];
 
    }
    return self;
}

@end
