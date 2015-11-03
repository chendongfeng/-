//
//  ScenticModel.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/20.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//
/*
 "title":"华山西峰索道",
 "thumb":"http://image.juntu.com/uploadfile/2014/0519/20140519053646974.jpg",
 "position":"",
 "map":"110.087406|34.540362|12",
 "description":"华山西峰索道(太华索道)门票团购多少钱？现网上预订,特享华山西峰索道(太华索道)门票优惠价，无需排队，凭验证码即可兑换门票，1人也团购。方便快捷，省时省心，订票就到骏途旅游网。",
 "dest_highlight":"★直达华山主峰区，华山西峰索道上站是西峰绝壁硐室，西峰海拔2082米，而北峰海拔1614.7米，从北峰步行到达西峰还需要3小时左右 ★贯通华山第三条登山路线，分流高峰期的游客。旅游高峰期的游客拥堵现象将得到大大缓解 ★改变了华山游客的年龄结构，从儿童到老年人都可乘坐，西峰索道大大节省了游人体力，同时到达华山主峰区后，山路平缓，适合更多人群游览 ★华山西峰索道链接了华山主峰区、仙峪景区、瓮峪景区，形成华山旅游大环线，游客有了更多的选择上下，从此不用再走"回头路" ★乘西峰索道，可以轻松饱览"太华极顶"、"华山第一天险"、"斧劈石"等这些位于华山主峰区的著名景点",
 "train":"N",
 "images":Array[6],
 "show":Array[6]
 */
#import "BaseModel.h"

@interface ScenticModel : BaseModel
@property(nonatomic, copy)NSString *thumb;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *position;
@property(nonatomic, copy)NSArray *images;
@property(nonatomic, copy)NSString *map;
@property(nonatomic, copy)NSString *dest_highlight;
@property(nonatomic, copy)NSArray *show;


@end
