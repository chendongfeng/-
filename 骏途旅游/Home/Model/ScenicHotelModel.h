//
//  ScenicHotelModel.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseModel.h"

@interface ScenicHotelModel : BaseModel
/*
 "id":"47",
 "title":"汤峪御宾苑酒店标准间1晚+双人早餐送汤峪温泉碧水湾门票2张",
 "juntu_price":"328",
 "code":"00000021",
 "play_day":"2",
 "images":Array[4],
 "images_num":4,
 "price":Array[1]
 */
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *juntu_price;
@property(nonatomic, copy)NSString *code;
@property(nonatomic, copy)NSString *play_day;
@property(nonatomic, copy)NSArray *images;
@property(nonatomic, copy)NSArray *price;
@end
