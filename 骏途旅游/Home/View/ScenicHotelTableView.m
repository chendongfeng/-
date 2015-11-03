//
//  ScenicHotelTableView.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "ScenicHotelTableView.h"
#import "UIImageView+WebCache.h"
#import "HeadView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ScenicHotelTableView
{
    NSString *_priceStr;
    NSDictionary *_priceDic;
    NSArray *_itemsArray;
    UIButton *_arrowButton;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setModel:(ScenicHotelModel *)model{
    if (_model != model) {
        _model = model;
    }
    NSArray *array = _model.price;
    _priceDic = array[0];
    _itemsArray = [_priceDic objectForKey:@"items"];
    _arrowButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 15, 15, 15)];

}

#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 4) {
        if (_arrowButton.selected) {
            return 0;
        }
        return _itemsArray.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 6;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scenticHotelCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scenticHotelCell"];
    }
//    _itemsArray
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSDictionary *dic = _itemsArray[indexPath.row];
    NSArray *imageNames = @[@"ticket12x",@"图标新1"];
    NSString *str = [[NSString alloc] init];
    if (indexPath.row == 0) {
        str = [NSString stringWithFormat:@"%@%@%@张",[dic objectForKey:@"title"],[dic objectForKey:@"sub_title"],[dic objectForKey:@"num"]];
    }else if (indexPath.row == 1){
        str = [NSString stringWithFormat:@"%@%@%@张",[dic objectForKey:@"title"],[dic objectForKey:@"sub_title"],[dic objectForKey:@"times"]];
    
    }

    HeadView *ticketView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)
                                             ImageName:imageNames[indexPath.row]
                                             LabelText:str
                                        arrowImageName:nil];
    ticketView.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:ticketView];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 200;
    }else if (section == 1){
    
        return 25;
    }else if (section == 2){
    
        return 100;
    
    }else if (section == 3 || section == 4 || section == 5){
    
        return 44;
    }
    return 0;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //大图
    if (section == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*0.3)];
        NSDictionary *imageDic = _model.images[0];
        NSString *imageUrl = [imageDic objectForKey:@"url"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        return imageView;
    }else if (section == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
        view.backgroundColor = [UIColor whiteColor];
        
        NSString *numberStr = [NSString stringWithFormat:@"产品编号:%@",_model.code];
        NSString *timeStr = [NSString stringWithFormat:@"行程: %@天",_model.play_day];
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 25)];
        numberLabel.text = numberStr;
        numberLabel.textColor = [UIColor grayColor];
        numberLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:numberLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 100, 25)];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.text = timeStr;
        timeLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:timeLabel];
        return view;
    
    }else if (section == 2){
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 10, 50)];
        titelLabel.text = _model.title;
        titelLabel.numberOfLines = 0;
        titelLabel.textColor = [UIColor grayColor];
        [view addSubview:titelLabel];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 50, 100, 50)];
        price.textColor = [UIColor orangeColor];
        _priceStr = [NSString stringWithFormat:@"￥%@起/人",_model.juntu_price];
        
        price.text = _priceStr;
        [view addSubview:price];
        
        return view;
    }else if (section == 3){
    
        HeadView *specialView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)
                                                      ImageName:@"star12x"
                                                      LabelText:@"特色介绍"
                                                 arrowImageName:@"arrow2x"];
        return specialView;
    
    }else if (section == 4) {


        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        titleView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-40, 44)];
        titleLabel.text = [_priceDic objectForKey:@"price_name"];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [titleView addSubview:titleLabel];
        
        [_arrowButton setImage:[UIImage imageNamed:@"down_12x"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"on2x"] forState:UIControlStateSelected];
        [_arrowButton addTarget:self
                   action:@selector(buttonAction:)
         forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
        [titleView addGestureRecognizer:tap];
        
        [titleView addSubview:_arrowButton];
        return titleView;
    
    
    }else if (section == 5){
        //富文本
        NSString *str = [NSString stringWithFormat:@"套餐价    %@",_priceStr];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str ];
        NSRange range = NSMakeRange(3, str.length-3);
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
        
        UIView *priceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        priceView.backgroundColor = [UIColor whiteColor];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-70, 44)];
        priceLabel.attributedText = attrStr;
        
        [priceView addSubview:priceLabel];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 10, 50, 30)];
        [button setTitle:@"预订" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        button.titleLabel.textColor = [UIColor whiteColor];
        [priceView addSubview:button];
        return priceView;
    
    }

    
    return nil;

}

-(void)buttonAction:(UIButton *)btn{
    _arrowButton.selected =! _arrowButton.selected;
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:4];
        [self reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 3;
    }
    return 0;
}

@end
