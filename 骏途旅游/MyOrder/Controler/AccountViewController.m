//
//  AccountViewController.m
//  骏途旅游
//
//  Created by mac10 on 15/10/8.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "AccountViewController.h"
#import "BaseHead.h"
#import "AccountCell.h"
#import "AccountModel.h"

@interface AccountViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
        NSMutableArray *_accountData;
        UIImageView *_imageView ;
        UIView *_headView;
        UITableView *_tableView;
}
@end

@implementation AccountViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self _creatHeadView];
    //读取用户名
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:kacount];
    
    //添加一个按钮
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(20, kScreenHeight/3*2-50, kScreenWidth-40, 40)];
    saveButton.backgroundColor = [UIColor orangeColor];
    [saveButton setTitle:@"保存数据" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    // 设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg.jpg"]];
    //创建TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 240)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    //添加数据
    NSArray *message = @[@"",@"用户名",@"昵称",@"手机号码",@"邮箱"];
    NSArray *word = @[@"",account,@"请填写姓名",account,@"请填写邮箱"];
    
    _accountData = [NSMutableArray array];
    for(int i = 0;i<message.count;i++){
        AccountModel *model = [[AccountModel alloc] init];
        model.message = message[i];
        model.word = word[i];
        [_accountData addObject:model];
        
    }
}
-(void)savaAction{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}
//弹窗代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        //存入本地
        NSData *data = UIImageJPEGRepresentation(_imageView.image, 1);
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kuserImage];
    //跳转回去
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if(indexPath.row!=0){
    AccountCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AccountCell" owner:nil options:nil] lastObject];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _accountData[indexPath.row];
        NSLog(@"%@",cell.wordLabel.text);
        return cell;
    }else{
        UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"HeadCell"];
        if(headCell==nil){
            headCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeadCell"];
        }
        //此处添加一个UIView
        [headCell.contentView addSubview:_headView];
        //右边小箭头
        headCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         headCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headCell;
    }

}

-(UIView *)_creatHeadView{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, kScreenWidth/5, 80)];
    label.text = @"头像";
    [_headView addSubview:label];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-120, 7, 65,65)];
    _imageView.image = [UIImage imageNamed:kplaceImageSmall];
    
    _imageView.backgroundColor = [UIColor clearColor];
    //地区本地图片
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:kuserImage];
    UIImage *image = [UIImage imageWithData:data];
    if(image!=nil){
        _imageView.image = image;
    }
    
    [_headView addSubview:_imageView];
    
    return _headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 80;
    }
    return 40;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        [self _selectPhoto];
    }
   

}


#pragma mark - 选择照片
- (void)_selectPhoto{
    
       UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [actionSheet showInView:self.view];
    
    //UIImagePickerController
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerControllerSourceType sourceType;
    //选择相机 或者 相册
    if (buttonIndex == 0) {//拍照
        
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"摄像头无法使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
        
        
    }else if(buttonIndex == 1){ //选择相册
        
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    }else{
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}
//照片选择代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //弹出相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //2 取出照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image;
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
