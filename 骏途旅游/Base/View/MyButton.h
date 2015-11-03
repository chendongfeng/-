//
//  MyButton.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/13.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton
- (id)initWithTitle:(NSString *)title
          imageName:(NSString *)imageName
              frame:(CGRect)frame;
@property(nonatomic, strong) UIImageView *myImageView;
@property(nonatomic, strong) UIImage *normalImage;
@property(nonatomic, strong) UIImage *selctImage;
@property(nonatomic, assign) BOOL isSelect;
-(void)isSelectAction;
@end
