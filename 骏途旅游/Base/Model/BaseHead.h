//
//  BaseHead.h
//  骏途旅游
//
//  Created by mac10 on 15/10/8.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#ifndef _____BaseHead_h
#define _____BaseHead_h

#import "HUProgressView.h"
#import "ShareButton.h"
//宏定义屏幕宽高
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kscenic @"http://www.juntu.com/index.php?m=app&c=scenic_rec&a=dest&keyword＝"//景区搜索
#define kforeign @"http://www.juntu.com/index.php?m=app&c=route_rec&a=tours&tourstype=3&keyword="//出境游搜索
#define kinland @"http://www.juntu.com/index.php?m=app&c=route_rec&a=tours&tourstype=2&keyword="//国内游搜索
#define karound @"http://www.juntu.com/index.php?m=app&c=route_rec&a=tours&tourstype=1&keyword="//周边游搜索
#define khotel @"http://www.juntu.com/index.php?m=app&c=hotel_rec&a=hotel&keyword="//酒店搜索
#define kscenic_hotel @"http://www.juntu.com/index.php?m=app&c=scenic_hotel&a=lists&keywords="//景加酒搜索
//出境游点击出的列表
#define kforeignList @"http://www.juntu.com/index.php?m=app&c=route_rec&a=route_recommend_list&type=foreign"
//国内游点击出的列表
#define kinlandList @"http://www.juntu.com/index.php?m=app&c=route_rec&a=route_recommend_list&type=inland"
//景区点击出的列表
#define kscenicList @"http://www.juntu.com/index.php?m=app&c=scenic_rec&a=dest_recommend"
//景加酒点击出的列表
#define kscenic_hotelList @"http://www.juntu.com/index.php?m=app&c=scenic_hotel&a=lists"
//周边游点击出的列表
#define karoundList @"http://www.juntu.com/index.php?m=app&c=route_rec&a=tours&tourstype=1"

//旅游详情
#define ktoursDetail @"http://www.juntu.com/index.php?m=app&c=route_rec&a=tours_show&toursid="
#define kscenicDetail @"http://www.juntu.com/index.php?m=app&c=scenic_rec&a=scenic_show&destid="
#define kscenic_hotelDetail @"http://www.juntu.com/index.php?m=app&c=scenic_hotel&a=show&id="


#define kplaceImage @"384.jpg"
#define kplaceImageSmall @"160.jpg"
//价格
#define kselectedPrice @"selectedPrice"
//等级
#define kselectedLeave @"selectedLeave"
//城市
#define kselectedCity @"kselectedCity"
//是否登陆
#define kisLogin @"login"
//账号
#define kacount @"acount"
//头像
#define kuserImage @"image"


#endif
