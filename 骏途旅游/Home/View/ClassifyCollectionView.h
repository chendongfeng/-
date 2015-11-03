//
//  ClassifyCollectionView.h
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/7.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame ImageNames:(NSArray *)imageNames Titles:(NSArray *)titles;
@property (nonatomic ,copy)NSArray *imageNames;
@property (nonatomic ,copy)NSArray *titles;

@end
