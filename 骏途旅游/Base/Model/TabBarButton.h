//
//  TabBarButton.h
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/19.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton
@property(nonatomic,copy)NSString *myImageName;
@property(nonatomic,copy)UIColor *myLabelColor;

/*
 * 初始化方法
 * title 按钮下部的文字
 * imageName 按钮上部图片名
 */
- (id)initWithTitle:(NSString *)title
          imageName:(NSString *)imageName
              frame:(CGRect)frame;


@end
