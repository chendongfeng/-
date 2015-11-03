//
//  JuntuSeacherBar.m
//  骏途旅游
//
//  Created by mac10 on 15/10/11.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "JuntuSeacherBar.h"
#import "MyNetWorkQuery.h"
#import "BaseHead.h"
@implementation JuntuSeacherBar

-(instancetype)initWithFrame:(CGRect)frame AndPlaceholderText:(NSString *)placeholderText{
    self = [super initWithFrame:frame];
    if(self){
        [self setPlaceholder:placeholderText];
        [self _setAttribute];
    }
    return self;
}

-(void)_setAttribute{
    
    //设置自身代理和属性
    self.delegate = self;
    _isNilText = YES;
    //设置背景并没有用
//    [self setBackgroundImage:[UIImage imageNamed:@"1136_menu_btn_sousuotiao"]];
  
}

//代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
  
//       NSLog(@"搜索%@",self.text);
    [self AFNetWorking:self.text];
    //使其上层控制器关闭键盘
   [super resignFirstResponder];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
     
    if(_isNilText){
        self.showsCancelButton = NO;
    }else{
//        NSLog(@"搜索%@",self.text);
        //开始搜索
        [self AFNetWorking:self.text];
    //    http://www.juntu.com/index.php?m=app&c=index&a=search&keywords=
    }
     //使其上层控制器关闭键盘
    [super resignFirstResponder];
}

-(void)AFNetWorking:(NSString *)keyword{
    //遮罩视图
    UIView *hiddenView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    hiddenView.backgroundColor = [UIColor lightGrayColor];
    hiddenView.alpha = 0.4;
    hiddenView.hidden = NO;
    HUProgressView *progress = [[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
    progress.center = hiddenView.center;
    progress.strokeColor = [UIColor cyanColor];
    [hiddenView addSubview:progress];
    [progress startProgressAnimating];
    UIImageView *horseimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    horseimage.center = hiddenView.center;
    horseimage.image = [UIImage imageNamed:@"ma"];
    
    [self.superview addSubview:horseimage];
    [self.superview addSubview:progress];
    [self.superview addSubview:hiddenView];
    
    NSString *urlString = self.urlString;
    NSString *searchString = [urlString stringByAppendingString:keyword];
    [MyNetWorkQuery requestData:searchString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
       
        //需要对不同的进行处理
        if([_type isEqualToString:@"景区"]){
            result = result[@"destList"];
        }else if ([_type isEqualToString:@"出境游"]){
            result = result[@"toursList"];
        }else if([_type isEqualToString:@"国内游"]){
            result = result[@"toursList"];
        }else if ([_type isEqualToString:@"周边游"]){
            result = result[@"toursList"];
        }else if([_type isEqualToString:@"景+酒"]){
            result = result[@"info"];
        }
        NSArray *resultArray = result;
        if(resultArray.count==0){
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            [horseimage removeFromSuperview];
            [progress removeFromSuperview];
            [hiddenView removeFromSuperview];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有搜索结果" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
//                self.text = @"";
            
        });
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                [horseimage removeFromSuperview];
                [progress removeFromSuperview];
                [hiddenView removeFromSuperview];
                //                self.text = @"";
                
            });            //需要将搜索到的数据返回
            self.block(result,self.text);
           
        }
     
    } errorHandle:^(NSError *error) {
        //移除遮罩
        [horseimage removeFromSuperview];
        [progress removeFromSuperview];
        [hiddenView removeFromSuperview];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];

}

//编辑的事件
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.showsCancelButton = YES;
    
    //设置取消
    UIView *topView = self.subviews[0];
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            _cancelButton = (UIButton *)subView;
            [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //判断是否为空
    if([searchText isEqualToString: @""]){
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _isNilText = YES;
    }else{
    
    [_cancelButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    
    [_cancelButton setTitle:@"搜索" forState:UIControlStateNormal];
        _isNilText = NO;
    }
}


@end
