//
//  AccountCell.h
//  骏途旅游
//
//  Created by mac10 on 15/10/9.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"
@interface AccountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *wordLabel;
@property(nonatomic,strong)AccountModel *model;
@end
