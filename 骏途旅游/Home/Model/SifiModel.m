//
//  SifiModel.m
//  骏途旅游
//
//  Created by mac10 on 15/10/13.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "SifiModel.h"

@implementation SifiModel
-(NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic{
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    [mapDic setObject:@"myID" forKey:@"id"];
     [mapDic setObject:@"myDescription" forKey:@"description"];
    return mapDic;


}
@end
