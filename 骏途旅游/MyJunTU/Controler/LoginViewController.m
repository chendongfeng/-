//
//  LoginViewController.m
//  骏途旅游
//
//  Created by 黄翔宇 on 15/10/23.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import "LoginViewController.h"

#import "MyNetWorkQuery.h"
#import "MyJuntuViewController.h"
#import "BaseHead.h"

#define kScrennWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIImageView *_selectImage;//头部选中视图
    NSMutableArray *_buttonArray;//button数组
    UIView *_juntuView;//骏途账号登陆视图
    UIView *_phoneView;//手机登陆视图

    NSString *_accountStr;//账号
    NSString *_codeStr;//密码
    NSString *_phoneStr;//手机号码
    NSString *_textStr;//验证码
    UILabel *_label;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号登陆";
    [self _creatTopView];
}

#pragma mark - 登陆
-(void)login{
    //按照选中视图的坐标，来确定是哪种登陆方式
    if (_selectImage.center.x < kScrennWidth/2) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:_accountStr forKey:@"username"];
        [params setValue:_codeStr forKey:@"password"];
        [MyNetWorkQuery requestData:@"http://www.juntu.com/index.php?m=app&c=member&a=login"
                         HTTPMethod:@"POST"
                             params:params
                   completionHandle:^(id result) {
                       NSLog(@"%@",result);
                       NSDictionary *loginListDic = [result objectForKey:@"loginList"];
                       NSString *status = [loginListDic objectForKey:@"status"];
                       if ([status isEqualToString:@"Y"]) {
                           //写入本地吧o(╯□╰)o
                           [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kisLogin];
                           [[NSUserDefaults standardUserDefaults] setObject:_accountStr forKey:kacount];
                           
                           [[NSUserDefaults standardUserDefaults] synchronize];
                           
                           
                           dispatch_sync(dispatch_get_main_queue(), ^{
                               UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScrennWidth/2-50, kScreenHeight-100, 100, 20)];
                               label.text = @"登陆成功";
                               label.textAlignment = 1;
                               label.textColor = [UIColor whiteColor];
                               label.backgroundColor = [UIColor blackColor];
                               [self.view addSubview:label];
                               [self performSelector:@selector(performAction) withObject:nil afterDelay:0.5];
                           });
                       }else{
                           dispatch_sync(dispatch_get_main_queue(), ^{
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                           [alert show];
                       });
                }
                   }
                        errorHandle:^(NSError *error) {
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert show];
                            });
                        }];

    }else{
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:_phoneStr forKey:@"mobile"];
        [params setValue:_textStr forKey:@"code"];
        [MyNetWorkQuery requestData:@"http://www.juntu.com/index.php?m=member&c=index&a=public_f_verification"
                         HTTPMethod:@"POST"
                             params:params
                   completionHandle:^(id result) {
                       NSDictionary *loginListDic = [result objectForKey:@"loginList"];
                       NSString *status = [loginListDic objectForKey:@"status"];
                       if ([status isEqualToString:@"Y"]) {
                           //写入本地吧o(╯□╰)o
                           [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kisLogin];
                           [[NSUserDefaults standardUserDefaults] setObject:_accountStr forKey:kacount];
                           
                           [[NSUserDefaults standardUserDefaults] synchronize];
                           
                           dispatch_sync(dispatch_get_main_queue(), ^{
                               UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScrennWidth/2-50, kScreenHeight-100, 100, 20)];
                               label.text = @"登陆成功";
                               label.textAlignment = 1;
                               label.textColor = [UIColor whiteColor];
                               label.backgroundColor = [UIColor blackColor];
                               [self.view addSubview:label];
                               [self performSelector:@selector(performAction) withObject:nil afterDelay:0.5];
                           });
                           
                       }
        } errorHandle:^(NSError *error) {
            
        }];
        
    
    
    }
   
}
#pragma mark - 返回上一页面
-(void)performAction{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - 头部视图
-(void)_creatTopView{
    
    //----------------登陆按钮-----------------------------
    //按钮名字
    NSArray *buttonNames = @[@"骏途账号登陆",@"手机验证登陆"];
    
    //宽度
    CGFloat width = kScrennWidth/2;
    
    _buttonArray = [[NSMutableArray alloc] init];
    
    //循环创建
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 64, width, 44)];
        
        //设置颜色
        [button setTitleColor:[UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.0 alpha:1] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        //添加点击事件
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        //设置标题
        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
        
        button.tag = 200 + i;
        [self.view addSubview:button];
        if (i == 0) {
            button.selected = YES;
        }
        //将BUTTON加入数组
        [_buttonArray addObject:button];
    }

    //选中视图
    _selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 108, width, 1.5)];
    _selectImage.image = [UIImage imageNamed:@"1136_menu_background_lvkuang11"];
    [self.view addSubview:_selectImage];
    [self _juntuLoginView];

    //登陆
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 290, kScrennWidth - 40, 40)];
    [loginButton setImage:[UIImage imageNamed:@"orangebar"] forState:UIControlStateNormal];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 10;
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth - 40, 40)];
    loginLabel.text = @"登陆";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    [loginButton addSubview:loginLabel];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    

}

#pragma mark - 头部视图button响应事件
-(void)buttonAction:(UIButton *)btn{
    
    CGFloat x = btn.center.x;
    
    //选中视图的滑动动画
    [UIView animateWithDuration:0.2 animations:^{
   
        _selectImage.center = CGPointMake(x, 108);

}];

    //当button不被选中时变成灰色
    for (UIButton *button in _buttonArray) {
        CGFloat x2 = button.center.x;
        if (_selectImage.center.x == x2) {
            button.selected = YES;
            
        }else{
            button.selected = NO;
        }
    }
    
   //两个视图的切换
    if (x <= kScrennWidth/4) {
        [self _juntuLoginView];
        [_phoneView removeFromSuperview];
    }else{
        [self _phoneLoginView];
        [_juntuView removeFromSuperview];
    }
}

#pragma mark - 骏途登陆视图
-(void)_juntuLoginView{
    
    _juntuView = [[UIView alloc] initWithFrame:CGRectMake(0, 111, kScrennWidth, 110)];

    UIView *codeView =[[UIView alloc] initWithFrame:CGRectMake(0, 57, kScrennWidth, 55)];
    codeView.backgroundColor = [UIColor whiteColor];
    UILabel *codeLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 55)];
    codeLable.text = @"密码";
    codeLable.textColor = [UIColor blackColor];
    
    UITextField *codeText = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, kScrennWidth-130, 55)];
    codeText.placeholder = @"请输入密码";
    codeText.tag = 101;
    codeText.secureTextEntry = YES;

    [codeText addTarget:self action:@selector(edingAction:) forControlEvents:UIControlEventEditingChanged];
    
    
    [codeView addSubview:codeLable];
    [codeView addSubview:codeText];
    [_juntuView addSubview:codeView];
    
    
   
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth, 55)];
    accountView.backgroundColor = [UIColor whiteColor];
    UILabel *accountLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 55)];
    accountLable.text = @"账号";
    accountLable.textColor = [UIColor blackColor];
    
    UITextField *accountText = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, kScrennWidth-130, 55)];
    accountText.placeholder = @"手机号/用户名";
    accountText.tag = 100;

    [accountText addTarget:self action:@selector(edingAction:) forControlEvents:UIControlEventEditingChanged];
    [accountView addSubview:accountLable];
    [accountView addSubview:accountText];
    [_juntuView addSubview:accountView];
    
   
    [self.view addSubview:_juntuView];

}

#pragma mark - 使用手机登陆
-(void)_phoneLoginView{
    _phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 111, kScrennWidth, 110)];

    //手机号
    UIView *phoneNumberView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrennWidth, 55)];
    phoneNumberView.backgroundColor = [UIColor whiteColor];
    UILabel *phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 55)];
    phoneLable.text = @"手机号";
    phoneLable.textColor = [UIColor blackColor];
    
    //手机号输入框
    UITextField *phoneText = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, kScrennWidth-130, 55)];
    phoneText.placeholder = @"请输入手机号码";
    phoneText.tag = 102;
    [phoneText addTarget:self action:@selector(edingAction:) forControlEvents:UIControlEventEditingChanged];
    [phoneNumberView addSubview:phoneLable];
    [phoneNumberView addSubview:phoneText];
    [_phoneView addSubview:phoneNumberView];
    
    //发送验证码按钮
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(kScrennWidth - 80, 20, 70, 20)];
    [testButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    testButton.backgroundColor = [UIColor orangeColor];
    testButton.layer.masksToBounds = YES;
    testButton.layer.cornerRadius = 4;
    testButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [testButton addTarget:self action:@selector(testButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [phoneNumberView addSubview:testButton];
    
    //验证码
    UIView *testNumberView =[[UIView alloc] initWithFrame:CGRectMake(0, 57, kScrennWidth, 55)];
    testNumberView.backgroundColor = [UIColor whiteColor];
    UILabel *testLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 55)];
    testLable.text = @"验证码";
    testLable.textColor = [UIColor blackColor];
    
    //验证码输入框
    UITextField *testText = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, kScrennWidth-130, 55)];
    testText.placeholder = @"请输入验证码";
    testText.tag = 103;
    [testText addTarget:self action:@selector(edingAction:) forControlEvents:UIControlEventEditingChanged];
    [_phoneView addSubview:testNumberView];
    [testNumberView addSubview:testText];
    [testNumberView addSubview:testLable];
    [self.view addSubview:_phoneView];
    

}

#pragma mark - 发送验证码
-(void)testButtonAction{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
   
    [params setValue:_phoneStr forKey:@"mobile"];
    [MyNetWorkQuery requestData:@"http://www.juntu.com/index.php?m=member&c=index&a=public_message"
                     HTTPMethod:@"GET"
                         params:params
               completionHandle:^(id result) {
                   NSLog(@"%@",result);
                   NSString *msg = [result objectForKey:@"msg"];
                   
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           _label = [[UILabel alloc] initWithFrame:CGRectMake(kScrennWidth/2-50, kScreenHeight-100, 100, 20)];
                           _label.text = msg;
                           _label.textAlignment = 1;
                           _label.textColor = [UIColor whiteColor];
                           _label.backgroundColor = [UIColor blackColor];
                           [self.view addSubview:_label];
                           [self performSelector:@selector(performAction2) withObject:nil afterDelay:0.5];
                       });
                   
                  } errorHandle:^(NSError *error) {
    
}];
}

-(void)performAction2{
    [_label removeFromSuperview];

}

-(void)isopenAction{
//    _codeView.isSecure =! _codeView.isSecure;

}

//当在编辑时调用
-(void)edingAction:(UITextField *)textField{

    if (textField.tag == 100) {
        _accountStr = textField.text;
    }else if (textField.tag == 101){
        _codeStr = textField.text;
    }else if (textField.tag == 102){
        _phoneStr = textField.text;
    }else if (textField.tag == 101){
        _textStr = textField.text;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
