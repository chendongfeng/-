//
//  AccountCell.m
//  骏途旅游
//
//  Created by mac10 on 15/10/9.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "AccountCell.h"

@implementation AccountCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(AccountModel *)model{
    _messageLabel.text = model.message;
    _wordLabel.text = model.word;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
