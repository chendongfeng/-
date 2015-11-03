//
//  SifiCell.h
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
 "is_train" : "N",
 "group_type" : "group", //是否跟团
 "offered_nature" : "2"
 }
 */

#import <UIKit/UIKit.h>
#import "SifiModel.h"
#import "LineLabel.h"
@interface SifiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thumpImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet LineLabel *oldPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UILabel *cutLabel;

@property (strong,nonatomic)SifiModel *model;

@end
