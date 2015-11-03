//
//  HotelModel.m
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "HotelModel.h"

@implementation HotelModel
-(NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic{
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    [mapDic setObject:@"hotelID" forKey:@"id"];

    return mapDic;
    
    
}
@end
