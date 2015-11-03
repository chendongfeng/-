//
//  SetViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "SetViewController.h"
#import "BaseHead.h"
#import "AboutJunTuViewController.h"
@interface SetViewController ()<UIAlertViewDelegate>
{
    UITableView *_tableView;
    UIAlertView *_alertView;
    NSString *_cachData;
    UIButton *_logoutButton;
}
@end

@implementation SetViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    _cachData = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
   
    [self _creatAlertView];
    [self _creatTableView];
     [self logOut];
}
-(void)logOut{
    _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, kScreenWidth-20, 30)];
    _logoutButton.backgroundColor = [UIColor orangeColor];
    [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [_logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logoutButton];
    //判断是否登录，显示
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:kisLogin];
    if(![login isEqualToString:@"YES"]){
        _logoutButton.hidden = YES;
    }
}
-(void)logoutAction{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, kScreenHeight-100, kScreenWidth-100, 30)];
    label.text = @"登出账号";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor whiteColor];

    [self.view addSubview:label];
    [self performSelector:@selector(performAction) withObject:nil afterDelay:0.5];
   
    
}
//登出动作
-(void)performAction{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kisLogin];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)_creatAlertView{
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将会清除用户信息与缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}

-(void)_creatTableView{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 208+44) style:UITableViewStylePlain ];
    [self.view addSubview:_tableView];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //第一组加上文字和单选按钮
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"通知时声音";
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-60, 5, 30, 30)];
            switchButton.on = YES;
            [cell.contentView addSubview:switchButton];
            
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"通知时震动";
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-60, 5, 30, 30)];
            switchButton.on = YES;
            [cell.contentView addSubview:switchButton];
            
        }
    }
    
    
    if (indexPath.section==1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存     %@",_cachData];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"通知";
    }
    return @"缓存";
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        [_alertView show];
      
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self performSelector:@selector(getPathOfCatch) withObject:nil afterDelay:0.5f];
        _cachData = @"清理中...";
        [_tableView reloadData];
    
    }
}
#pragma mark - 清理缓存
-(CGFloat)countCacheFileSize{
    //获取沙盒路径
    NSString *filePath= NSHomeDirectory();
    //    NSLog(@"%@",filePath);
    //查看需要清理的文件路径，进行拼接
    /*
     1.tmp/MediaCache
     2.Library/Caches/com.hackemist.SDWebImageCache.default
     3.Library/Caches/john.JohnMovie
     */
    CGFloat fileSize=0;
    NSArray *fileArray = @[@"/Library/Caches/",@"/Library/Cookies/",@"/Library/Preferences/",@"/tmp/"];
    //    遍历拼接
    for(NSString *str in fileArray){
        NSString *file=[NSString stringWithFormat:@"%@%@",filePath,str];
        //        调用计算文件大小的方法
        fileSize+=[self getFileSize:file];
    }
    return fileSize/1024.0f/1024;
    
}
-(CGFloat)getFileSize:(NSString *)filePath{
    //文件管理类，单例
    NSFileManager *manager=[NSFileManager defaultManager];
    //获取文件数组
    NSArray *fileName=[manager subpathsAtPath:filePath];
    //遍历文件夹
    long long fileSize=0;
    for(NSString *str in fileName){
        NSString *file=[NSString stringWithFormat:@"%@/%@",filePath,str];
        NSDictionary *oneFile=[manager attributesOfItemAtPath:file error:nil];
        //        NSLog(@"one%@",oneFile);
        NSNumber *oneFileSize =oneFile[NSFileSize];
        fileSize+=[oneFileSize longLongValue];
    }
    return fileSize;
}
//获取缓存路径
-(void)getPathOfCatch{
    NSString *path = NSHomeDirectory();
    NSLog(@"%@",path);
    //目标文件夹
    /*
     1./library/Caches/com.hackemist.SDWebImageCache.default
     2./library/Caches/john.----
     3./library/Cookies
     4./library/Preferences
     
     */
    NSArray *fileArray = @[@"/Library/Caches/",@"/Library/Cookies/",@"/Library/Preferences/",@"/tmp/"];
    
    //文件管理
    NSFileManager *manager = [NSFileManager defaultManager];
    //遍历子文件并删除
    for(NSString *str in fileArray){
        NSString *file=[NSString stringWithFormat:@"%@%@",path,str];
        //获取子文件
        NSArray *fileNames=[manager subpathsOfDirectoryAtPath:file error:nil];
        //    再次拼接子文件路径
        for(NSString *fileName in fileNames){
            NSString *oneFile=[NSString stringWithFormat:@"%@%@",file,fileName];
            [manager removeItemAtPath:oneFile error:nil];
        }
    }
    //清理完重新计算
      _cachData = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    [_tableView reloadData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
