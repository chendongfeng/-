//
//  TabBarButton.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/19.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton{
    UIImageView *_imageView;
    UILabel *_label;
}

- (id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 创建图片和label
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 20) / 2, 8, 20, 22)];
        _imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_imageView];
        
        // 设置图片的拉伸模式
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, frame.size.width, 15)];
        _label.text = title;
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = [UIColor grayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    
    return self;
}
-(void)setMyImageName:(NSString *)myImageName{
    // 改变图片
    _imageView.image = [UIImage imageNamed:myImageName];

}
-(void)setMyLabelColor:(UIColor *)myLabelColor{
    _label.textColor = myLabelColor;
}


@end
