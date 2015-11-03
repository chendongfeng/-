//
//  ClassifyCollectionView.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/7.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "ClassifyCollectionView.h"
#import "TourViewController.h"
#import "UIView+UIViewController.h"
#import "AroundViewController.h"
#import "HotelViewController.h"
#import "BaseWebViewController.h"
#import "BaseNaviViewController.h"
@implementation ClassifyCollectionView
-(instancetype)initWithFrame:(CGRect)frame ImageNames:(NSArray *)imageNames Titles:(NSArray *)titles{
    
    //单元格布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 70);
    layout.minimumInteritemSpacing =30;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10,10,10, 10);
    
    _imageNames = imageNames;
    _titles = titles;
    self=[super initWithFrame:frame collectionViewLayout:layout];

    
    if (self) {
        self.dataSource=self;
        
        self.delegate=self;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageNames.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 43, 43)];
    imageView.image = [UIImage imageNamed:_imageNames[indexPath.item]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 50, 20)];
    label.text = _titles[indexPath.item];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    [cell.contentView addSubview:imageView];
    //    cell.backgroundColor = [UIColor blueColor];
    return cell;
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //0,1,2跳转相同界面
    if (indexPath.item==1||indexPath.item==0||indexPath.item==2) {
        //跳转界面
        TourViewController *tour = [[TourViewController alloc] init];
        
        [self.viewController.navigationController pushViewController:tour animated:YES];
        
        tour.hidesBottomBarWhenPushed = YES;
        if(indexPath.item==0){
            tour.myTitle = @"景区";
        }if(indexPath.item==1){
            tour.myTitle = @"出境游";
        }if(indexPath.item==2){
            tour.myTitle = @"国内游";
        }
        
    }
    //4和6界面完全相同
    if (indexPath.item==4||indexPath.item==6){
        AroundViewController *around  = [[AroundViewController alloc] init];
        [self.viewController.navigationController pushViewController:around animated:YES];
        around.hidesBottomBarWhenPushed = YES;
        if(indexPath.item==4){
          around.myTitle = @"周边游";
        }else{
        around.myTitle = @"景+酒";
        }
    
    }
    
    //酒店界面
    if(indexPath.item==5){
        HotelViewController *hotel = [[HotelViewController alloc] init];
        [self.viewController.navigationController pushViewController:hotel animated:YES];
       
        hotel.hidesBottomBarWhenPushed = YES;
         hotel.mytitle = @"酒店";
    }
    if (indexPath.item==3) {
        BaseWebViewController *webView = [[BaseWebViewController alloc] init];
        webView.urlString = @"http://s.juntu.com/index.php?m=mobile&c=index&a=seckill_list&type=3";
        BaseNaviViewController *nav = [[BaseNaviViewController alloc] initWithRootViewController:webView];
        [self.viewController.navigationController presentViewController:nav animated:YES completion:nil];
    }
    if (indexPath.item==7) {
        BaseWebViewController *webView = [[BaseWebViewController alloc] init];
        webView.urlString = @"http://s.juntu.com/index.php?m=mobile&c=index&a=drive_lists&type=3";
        BaseNaviViewController *nav = [[BaseNaviViewController alloc] initWithRootViewController:webView];
        [self.viewController.navigationController presentViewController:nav animated:YES completion:nil];

    }
    
    NSLog(@"分类视图点击了%li",indexPath.item);

}



@end
