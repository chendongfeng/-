//
//  LineLabel.m
//  LineLabel
//
//  Created by 俞烨梁 on 15/10/19.
//  Copyright (c) 2015年 俞烨梁. All rights reserved.
//

#import "LineLabel.h"

@implementation LineLabel


-(void)setLabelText:(NSString *)labelText{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:labelText];
    
    [attrString addAttribute:NSStrikethroughStyleAttributeName value:@1 range:[labelText rangeOfString:labelText]];
    
    self.attributedText = attrString;

    
}

@end
