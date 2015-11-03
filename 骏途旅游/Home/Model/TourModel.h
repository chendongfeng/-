//
//  TourModel.h
//  骏途旅游
//
//  Created by mac10 on 15/10/7.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface TourModel :BaseModel
//利用BaseModel快速读取Json文件
@property(nonatomic,copy) NSString *product_title;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *product_sec_title;
@property(nonatomic,copy)NSString *product_price;
@property(nonatomic,copy)NSString *product_thumb;
@property(nonatomic,copy)NSString *product_id;
@end
