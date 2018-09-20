//
//  SendWishViewController.m
//  XYGPWuZi
//
//  Created by apple on 2017/6/10.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "SendWishViewController.h"

@interface SendWishViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *myTextView;

@end

@implementation SendWishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"购买意愿留言";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSLog(@"=====%@======%@",self.piId,self.productName);
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    float textViewWidth = S_W-20;
    float textViewHeight = 0.618*textViewWidth;
    

    self.myTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 20, textViewWidth, textViewHeight)];
    self.myTextView.backgroundColor = [UIColor whiteColor];
    _myTextView.font = [UIFont systemFontOfSize:16];
    
    _myTextView.delegate = self;
    _myTextView.returnKeyType = UIReturnKeySend;
    [_myTextView becomeFirstResponder];
    [self.view addSubview:self.myTextView];
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        
        NSLog(@"发送");
        [self sendMessage];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

-(void)sendMessage{
    [self.view endEditing:YES];
    //token:登录令牌 | piId:产品主键 | lmTitle：产品名称 | lmContent：意愿留言 | lmTel：联系电话 | lmEmail：电子邮箱
    //发送信息
    NSString *url = [requestUrlHeader stringByAppendingString:addLeaveMessageUrl];
    NSLog(@"-----url====%@",url);
    if (self.myTextView.text.length>0) {
        if (self.myTextView.text.length >512) {
            MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hudd.mode = MBProgressHUDModeText;
            hudd.labelText = @"字数太多";
            [hudd hide:YES afterDelay:0.7];
        }else{
            __weak typeof(self)weakSelf = self;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            //token:登录令牌 | piId:产品主键 | lmTitle：产品名称 | lmContent：意愿留言
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:self.piId forKey:@"piId"];
            [dict setObject:kStringToken forKey:@"token"];
            [dict setObject:self.productName forKey:@"lmTitle"];
            [dict setObject:self.myTextView.text forKey:@"lmContent"];
            NSLog(@"--发送参数---%@",dict);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"-----response---%@",responseObject);
                
                int codeStr = [responseObject[@"code"]intValue];
                if (codeStr==200) {
                    
                    hud.labelText = @"发送成功";
                    [hud hide:YES afterDelay:0.7];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    hud.labelText = @"发送失败";
                    [hud hide:YES afterDelay:0.7];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
    }
    else{
        MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hudd.mode = MBProgressHUDModeText;
        hudd.labelText = @"请补全信息";
        [hudd hide:YES afterDelay:0.7];
    }
}
-(void)backBtnSelsct{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
