//
//  HeadView.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView
-(instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)imageName LabelText:(NSString *)labelText arrowImageName:(NSString *)arrowName;
@property(nonatomic, strong)UILabel *label;
@property(nonatomic, copy)NSString *arrowImageName;
@property(nonatomic, strong)UIImageView *arrowImage;
@end
