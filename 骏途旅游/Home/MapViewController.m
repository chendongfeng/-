//
//  MapViewController.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/26.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "juntuAnnotation.h"
@interface MapViewController ()<MKMapViewDelegate>
{
    MKMapView *_mapView;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图导航";
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    
    CGFloat latitude = [_mapArray[0] floatValue];
    CGFloat longitude = [_mapArray[1] floatValue];
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(longitude, latitude);

    [self.view addSubview:_mapView];
    
    
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {coordinate2D,span};
    [_mapView setRegion:region];
    

    juntuAnnotation *annotation = [[juntuAnnotation alloc] init];
    annotation.coordinate = coordinate2D;
    annotation.title = _position;
    
    [_mapView addAnnotation:annotation];
    

}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (pinView == nil) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
    
            //1 设置大头这颜色
            pinView.pinColor = MKPinAnnotationColorGreen;
            //2 设置从天而降的效果
            pinView.animatesDrop = YES;
            //3 设置显示标题
            pinView.canShowCallout = YES;
            //设置辅助视图
            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
        }
        
        return pinView;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
