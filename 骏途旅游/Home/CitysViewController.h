//
//  CitysViewController.h
//  骏途旅游
//
//  Created by mac10 on 15/10/22.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^CityBlock)(NSDictionary *);
@interface CitysViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)CityBlock CityBlock;
-(void)setCityBlock:(CityBlock)CityBlock;
@end
