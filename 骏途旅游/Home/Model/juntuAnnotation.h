//
//  juntuAnnotation.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/26.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface juntuAnnotation : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end
