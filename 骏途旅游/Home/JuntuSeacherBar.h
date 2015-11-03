//
//  JuntuSeacherBar.h
//  骏途旅游
//
//  Created by mac10 on 15/10/11.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyBlock)(NSArray *,NSString *text);
@interface JuntuSeacherBar : UISearchBar<UISearchBarDelegate>
{
    UIButton *_cancelButton;
    BOOL _isNilText;
}

@property(nonatomic,copy)NSString *urlString;
-(instancetype)initWithFrame:(CGRect)frame AndPlaceholderText:(NSString *)placeholderText;
@property(nonatomic,copy)MyBlock block;
@property(nonatomic,copy)NSString *type;
@end
