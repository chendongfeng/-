//
//  MyButton.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/13.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // 创建图片和label
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 15, 10, 15, 15)];
        
        _myImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_myImageView];
        
        // 设置图片的拉伸模式
        _myImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 38)];
        label.text = title;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [self addObserver:self forKeyPath:@"isSelect" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //    [self selectImage:[UIImage imageNamed:@"arrow_up_expanablelistview111"] NormalImage:[UIImage imageNamed:@"arrow_down_expanablelistview111"]];
    [self isSelectAction];
    
}

-(void)isSelectAction{
    if (_isSelect == YES) {
        _myImageView.image = _selctImage;
    }else{
        _myImageView.image = _normalImage;
        
        
    }
    
}


-(void)dealloc{
    [self removeObserver:self forKeyPath:@"isSelect"];
    
}

@end
