//
//  XRChangeMiMaViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/8/10.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRChangeMiMaViewController.h"

@interface XRChangeMiMaViewController ()

@property (nonatomic,strong)UITextField *yuanMimaField;//原密码
@property (nonatomic,strong)UITextField *xinMimaField;//新密码
@property (nonatomic,strong)UITextField *queRenField;//确认密码

@end

@implementation XRChangeMiMaViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //右上角按钮
    UIBarButtonItem *rightLoginBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveMiMa)];
    self.navigationItem.rightBarButtonItem = rightLoginBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    //背景view,所有控件都添加到此view上边
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 150)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    //原密码label
    UILabel *yuanMiMa = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 80, 20)];
    yuanMiMa.text = @"原密码";
    yuanMiMa.textColor = [UIColor grayColor];
    yuanMiMa.font = [UIFont systemFontOfSize:kTitleFontSize];
    [topView addSubview:yuanMiMa];
    
    
    //原密码field
    _yuanMimaField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, S_W-100-15, 30)];
    _yuanMimaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _yuanMimaField.placeholder = @"请输入原密码";
    _yuanMimaField.font = [UIFont systemFontOfSize:kValueFontSize];
    //_nameField.backgroundColor = [UIColor magentaColor];
    [topView addSubview:_yuanMimaField];
    
    //分割线
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, S_W-30, 0.2)];
    lineLabel1.backgroundColor = [UIColor blackColor];
    [topView addSubview:lineLabel1];
    
    //新密码label
    UILabel *newMiMa = [[UILabel alloc]initWithFrame:CGRectMake(15, 15+50, 80, 20)];
    newMiMa.text = @"新密码";
    newMiMa.textColor = [UIColor grayColor];
    newMiMa.font = [UIFont systemFontOfSize:kTitleFontSize];
    [topView addSubview:newMiMa];
    
    
    //新密码field
    _xinMimaField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10+50, S_W-100-15, 30)];
    _xinMimaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _xinMimaField.placeholder = @"请输入新密码";
    _xinMimaField.font = [UIFont systemFontOfSize:kValueFontSize];
    //_nameField.backgroundColor = [UIColor magentaColor];
    [topView addSubview:_xinMimaField];
    
    
    //分割线
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, S_W-30, 0.2)];
    lineLabel2.backgroundColor = [UIColor blackColor];
    [topView addSubview:lineLabel2];
    
    //确认密码label
    UILabel *querenNewMiMa = [[UILabel alloc]initWithFrame:CGRectMake(15, 15+50+50, 80, 20)];
    querenNewMiMa.text = @"确认新密码";
    querenNewMiMa.textColor = [UIColor grayColor];
    querenNewMiMa.font = [UIFont systemFontOfSize:kTitleFontSize];
    [topView addSubview:querenNewMiMa];
    
    //原密码field
    _queRenField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10+50+50, S_W-100-15, 30)];
    _queRenField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _queRenField.placeholder = @"请输确认新密码";
    _queRenField.font = [UIFont systemFontOfSize:kValueFontSize];
    
    [topView addSubview:_queRenField];
    
    //分割线
    UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 150, S_W-30, 0.2)];
    lineLabel3.backgroundColor = [UIColor blackColor];
    [topView addSubview:lineLabel3];
    
}
#pragma mark - 保存密码
-(void)saveMiMa{

    [_yuanMimaField resignFirstResponder];
    [_xinMimaField resignFirstResponder];
    [_queRenField resignFirstResponder];
    NSLog(@"----修改密码");
    //token：登录令牌 | oldpwd：原始密码 | newpwd1：新密码 | newpwd2：重复新密码
    if (_yuanMimaField.text.length<=0) {
        MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud1.mode = MBProgressHUDModeCustomView;
        hud1.labelText = @"请输入密码";
        [hud1 hide:YES afterDelay:0.7];
        
    }else{
        NSString * regex = @"^[A-Za-z0-9]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if(![pred evaluateWithObject: _xinMimaField.text]){
            NSLog(@"请输入6-16位字母数字组合");
            MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hudd.mode = MBProgressHUDModeCustomView;
            hudd.labelText = @"请输入6-16位字母数字组合";
            [hudd hide:YES afterDelay:0.7];
        }else{
            if ([_xinMimaField.text isEqualToString:_yuanMimaField.text]) {
                MBProgressHUD *hud2 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud2.mode = MBProgressHUDModeCustomView;
                hud2.labelText = @"新密码不能和原密码相同";
                [hud2 hide:YES afterDelay:0.7];
            }
            else{
                if (![_xinMimaField.text isEqualToString:_queRenField.text]) {
                    MBProgressHUD *hud5 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud5.mode = MBProgressHUDModeCustomView;
                    hud5.labelText = @"确认密码与新密码不一致";
                    [hud5 hide:YES afterDelay:0.7];
                }
                else{
                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
                    [parm setObject:kStringToken forKey:@"token"];
                    [parm setObject:_yuanMimaField.text forKey:@"oldpwd"];
                    [parm setObject:_xinMimaField.text forKey:@"newpwd1"];
                    [parm setObject:_queRenField.text forKey:@"newpwd2"];
                    NSLog(@"----%@",parm);
                    
                    __weak typeof(self)weakSelf = self;
                    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_UpdateUserPwd] parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [hud hide:YES];
                        NSLog(@"-----%@",responseObject);
                        
                        int code = [responseObject[@"code"] intValue];
                        if (code == 200) {
                            //修改密码成功
                            MBProgressHUD *hud3 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud3.mode = MBProgressHUDModeCustomView;
                            hud3.labelText = @"密码修改成功";
                            
                            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                            [userDefault removeObjectForKey:KEY_USER_picurl];
                            [userDefault synchronize];
                            [UserManager clearUserInfo];
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [hud3 hide:YES afterDelay:0.7];
                                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                            });
                        }
                        if (code == 600 || code == 1318 || code == 1320 ||code == 1321) {
                            //修改失败
                            MBProgressHUD *hud4 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud4.mode = MBProgressHUDModeCustomView;
                            hud4.labelText = @"密码修改失败";
                            [hud4 hide:YES afterDelay:0.7];
                        }
                        if (code == 1319) {
                            //旧密码输入有误
                            MBProgressHUD *hud5 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud5.mode = MBProgressHUDModeCustomView;
                            hud5.labelText = @"原密码输入有误";
                            [hud5 hide:YES afterDelay:0.7];
                        }
                        
                        //200：成功！| 600：登录令牌过期！| 1318:密码修改失败！| 1319:旧密码输入错误！|1320:两次密码输入不一致！|1321:新密码不能和原密码一样！
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [hud hide:YES];
                    }];

                }
            }
        }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
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
