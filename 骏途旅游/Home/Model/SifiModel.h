//
//  SifiModel.h
//  骏途旅游
//
//  Created by mac10 on 15/10/13.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//
/*
 {
 "id" : "1957",
 "thumb" : "http:\/\/image.juntu.com\/uploadfile\/2015\/1010\/20151010113216261.jpg",
 "description" : "西安成团含全陪",
 "is_self_drive" : "N",//自驾游
 "juntu_price" : "1980",
 "coupon_status" : "N",//优惠券
 "minus" : 0, //立减吧？
 "title" : "【爸妈游】<广深珠、港澳、厦门、鼓浪屿双卧11日游>",
 "is_train" : "N",//直通车
 "group_type" : "group", //是否跟团
 "offered_nature" : "2"
 }
 */
/*风景
{
    "minus" : "0",
    "position" : "西安市长安区太乙宫镇翠华山",
    "map" : "109.013076|33.999559|18",
    "id" : "92",
    "coupon_status" : "N",
    "title" : "翠华山国家地质公园",
    "market_price" : "70",
    "thumb" : "http:\/\/image.juntu.com\/uploadfile\/2015\/0916\/20150916050005340.jpg",
    "description" : "景色如画古迹多，峰顶湫池荡凌波",
    "juntu_price" : "60"
},
*/





#import "BaseModel.h"

@interface SifiModel : BaseModel
@property(nonatomic,copy)NSString *thumb;//图片
@property(nonatomic,copy)NSString *myDescription;//描述
@property(nonatomic,copy)NSString *is_self_drive;//自驾游YN
@property(nonatomic,copy)NSString *juntu_price;//价格
@property(nonatomic,copy)NSString *coupon_status;//优惠券YN
@property(nonatomic,copy)NSString *minus;//这个还是测不出来
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *group_type;//组团类型group
@property(nonatomic,copy)NSString *is_train;//直通车YN
@property(nonatomic,copy)NSString *myID;//城市ID
@property(nonatomic,copy)NSString *map;//地图位置 109.013076|33.999559|18
@property(nonatomic,copy)NSString *market_price;//市场价格
@property(nonatomic,copy)NSString *position;//地址信息
@property(nonatomic,copy)NSString *offered_nature;//自然提供难道是
@property(nonatomic,copy)NSString *sub_title;//也是描述（在首页按钮进入）
@property(nonatomic,copy)NSString *max_price;//最高价格（在酒店使用）
@property(nonatomic,copy)NSString *min_price;//最低价格（在酒店使用）

-(NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic;
@end
