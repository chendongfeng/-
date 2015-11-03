//
//  HotelModel.h
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseModel.h"

@interface HotelModel : BaseModel
@property(nonatomic,copy)NSString *hotelID;
@property(nonatomic,copy)NSString *juntu_price;
@property(nonatomic,copy)NSString *map;
@property(nonatomic,copy)NSString *market_price;
@property(nonatomic,copy)NSString *position;
@property(nonatomic,copy)NSString *thumb;
@property(nonatomic,copy)NSString *title;

@end
