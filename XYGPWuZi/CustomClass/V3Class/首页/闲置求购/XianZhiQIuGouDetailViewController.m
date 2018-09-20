//
//  XRQiuGouDetailVC.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/11/7.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XianZhiQIuGouDetailViewController.h"
#import "FaSongGouMaiYiYuanViewController.h"
@interface XianZhiQIuGouDetailViewController ()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *fabuTimeLabel;

@property(nonatomic,strong)UILabel *keyWordLabel;

@property(nonatomic,strong)UILabel *addressLabel;

@property(nonatomic,strong)UILabel *fabuPersonLabel;

@property(nonatomic,strong)UILabel *companyLabel;

@property(nonatomic,strong)UIImageView *liuChengImageV;

@property(nonatomic,strong)UITextView *detailTextView;

@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation XianZhiQIuGouDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(id)init{
    if (self=[super init]) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.color = [UIColor groupTableViewBackgroundColor];
        
    }
    return self;
}
-(void)setupUI{
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, S_W-20, 20)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_titleLabel];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+20+10, 70, 20)];
    label1.text = @"发布时间";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = [UIColor blackColor];
    [self.view addSubview:label1];
    
    _fabuTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10+20+10, S_W-80-10, 20)];
    _fabuTimeLabel.font = [UIFont systemFontOfSize:14];
    _fabuTimeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_fabuTimeLabel];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+20+10+20+10, 70, 20)];
    label2.text = @"关键字";
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [UIColor blackColor];
    [self.view addSubview:label2];
    
    _keyWordLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,  10+20+10+20+10, S_W-80-10, 20)];
    _keyWordLabel.font = [UIFont systemFontOfSize:14];
    _keyWordLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_keyWordLabel];
    
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+20+10+30+30, 70, 20)];
    label3.text = @"所在地区";
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = [UIColor blackColor];
    [self.view addSubview:label3];
    
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,  10+20+10+30+30, S_W-80-10, 20)];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_addressLabel];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+20+10+30+30+30, 70, 20)];
    label4.text = @"发布姓名";
    label4.font = [UIFont systemFontOfSize:14];
    label4.textColor = [UIColor blackColor];
    [self.view addSubview:label4];
    
    _fabuPersonLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,  10+20+10+30+30+30, S_W-80-10, 20)];
    _fabuPersonLabel.font = [UIFont systemFontOfSize:15];

    [self.view addSubview:_fabuPersonLabel];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 10+20+10+30+30+30+30+30, S_W, 0.3)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    
    UILabel *companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+20+10+30+30+30+30, 70, 20)];
    companyLabel.text = @"公司名称";
    companyLabel.font = [UIFont systemFontOfSize:14];
    companyLabel.textColor = [UIColor blackColor];
    [self.view addSubview:companyLabel];
    
    _companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,  10+20+10+30+30+30+30, S_W-80-10, 20)];
    _companyLabel.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:_companyLabel];
    
    
    
    UILabel *gongYingLiuChengLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,  10+20+10+30+30+30+30+10+30, 80, 20)];
    gongYingLiuChengLabel.font = [UIFont boldSystemFontOfSize:15];
    gongYingLiuChengLabel.text = @"供应流程";
    gongYingLiuChengLabel.textColor = [UIColor blackColor];
    [self.view addSubview:gongYingLiuChengLabel];
    
    _liuChengImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10+20+10+30+30+30+30+10+30+20, S_W, S_W/4)];
    _liuChengImageV.image = [UIImage imageNamed:@"supplyWish"];
    [self.view addSubview:_liuChengImageV];
    
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectZero];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_liuChengImageV).offset(10);
        make.size.mas_equalTo(CGSizeMake(S_W, 0.3));
    }];
    
    _detailTextView = [[UITextView alloc]initWithFrame:CGRectZero];
    _detailTextView.font = [UIFont systemFontOfSize:14];
    _detailTextView.textColor = [UIColor blackColor];
    _detailTextView.editable = NO;
    [self.view addSubview:_detailTextView];
    
   
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    UIButton *button = [UIButton buttonWithStyle:(StrapDefaultStyle) andTitle:@"发送供应意愿" andFrame:CGRectMake(16, 0, S_W-32, 44) target:self action:@selector(sendSupplyWish)];
    [bottomView addSubview:button];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(S_W, kViewAtBottomHeight));
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [_detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(10);
        make.bottom.equalTo(bottomView.mas_top).offset(-10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
}
-(void)sendSupplyWish{

    if ([kStringToken length]) {
        FaSongGouMaiYiYuanViewController *vc = [[FaSongGouMaiYiYuanViewController alloc]init];
        vc.riId = self.riId;
        vc.lmTitle = self.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }
    
}
-(void)setRiId:(NSString *)riId{
    
    _riId = riId;
    
    NSLog(@"----%@",_riId);
    [self requestWithTnid:_riId];
    
}

-(void)requestWithTnid:(NSString *)riId{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:riId forKey:@"riId"];
    __weak typeof(self)weakSelf = self;
    
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindRequInfoDetail] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self setupUI];
        [weakSelf.hud hide:YES];
        NSLog(@"--求购详情--%@",responseObject);
        /*
         object =     {
         riCountyId = "191",
         riPerson = "吴玮楠",
         riIsAdmin = "0",
         riTel = "15230518339",
         riCretime = "2017-12-21 14:59:11",
         riModuser = "18931586415",
         riCreuser = "18931586415",
         facUserid = "402880865fb414550160001b335200e7",
         riStatus = "0",
         riKeyword = "测试",
         riTitle = "测试",
         riId = "40288086606d8b67016077de652c0135",
         riProvinceId = "3",
         riModtime = "2017-12-21 14:59:11",
         riEmail = "erzhuwwn@163.com",
         riCode = "10000040",
         riCount = "0",
         riCityId = "10",
         },
         code = 200,

         */
        if ([responseObject[@"code"] intValue] == 200) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                NSString* str = responseObject[@"object"][@"riContent"];
                NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    weakSelf.titleLabel.text = responseObject[@"object"][@"riTitle"];
                    weakSelf.fabuTimeLabel.text = responseObject[@"object"][@"riCretime"];
                    weakSelf.keyWordLabel.text = responseObject[@"object"][@"riKeyword"];
                    weakSelf.addressLabel.text = responseObject[@"object"][@"riAddress"];
                    weakSelf.fabuPersonLabel.text = responseObject[@"object"][@"riPerson"];
                    weakSelf.companyLabel.text = responseObject[@"object"][@"riCompanyName"];

                    weakSelf.detailTextView.attributedText = attrStr;
                    
                });
                
            });
            
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.hud hide:YES];
    }];

    
    
}
@end
