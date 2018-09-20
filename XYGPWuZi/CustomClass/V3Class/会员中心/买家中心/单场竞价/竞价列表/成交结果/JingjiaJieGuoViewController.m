//
//  JingjiaJieGuoViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/11/1.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "JingjiaJieGuoViewController.h"

@interface JingjiaJieGuoViewController ()
@property(nonatomic,strong)UILabel *titleDataLabel;

@property(nonatomic,strong)UILabel *bianHaoDataLabel;

@property(nonatomic,strong)UILabel *nameDataLabel;

@property(nonatomic,strong)UILabel *startPriceDataLabel;

@property(nonatomic,strong)UILabel *dealPriceDataLabel;

@property(nonatomic,strong)UILabel *completeTimeDataLabel;

@property(nonatomic,strong)UILabel *zhiFuZhuangtaiDataLabel;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation JingjiaJieGuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"成交结果";
    [self requestWithTsid:self.tsId andType:self.type];
    [self setupUI];
}
#pragma mark - UI
-(void)setupUI{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, S_W, 335)];
    if (self.view.bounds.size.height == 812) {
        backView.frame = CGRectMake(0, 20+20, S_W, 335);
    }
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    for (int i = 1; i < 5; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 45*i, S_W, 0.3)];
        line.backgroundColor = [UIColor grayColor];
        [backView addSubview:line];
    }
    UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 180, S_W, 20)];
    spaceView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [backView addSubview:spaceView];
    for (int i = 1; i<3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 200+45*i, S_W, 0.3)];
        line.backgroundColor = [UIColor grayColor];
        [backView addSubview:line];
    }
    /******************************* ↑ 底部控件布局 ↑ ***********************************/
    
    
    //label布局
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 70, 20)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"场次名称";
    [backView addSubview:titleLabel];
    
    
    _titleDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+70+5, 12, S_W-95, 20)];
    _titleDataLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleDataLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_titleDataLabel];
    
    
    UILabel *bianHaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12+45, 70, 20)];
    bianHaoLabel.text = @"场次编号";
    bianHaoLabel.font = [UIFont systemFontOfSize:14];
    bianHaoLabel.textColor = [UIColor blackColor];
    [backView addSubview:bianHaoLabel];
    
    _bianHaoDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 12+45, S_W-95, 20)];
    _bianHaoDataLabel.font = [UIFont systemFontOfSize:14];
    _bianHaoDataLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_bianHaoDataLabel];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12+45+45, 70, 20)];
    nameLabel.text = @"卖方名称";
    nameLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:nameLabel];
    _nameDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 12+45+45, S_W-95, 20)];
    _nameDataLabel.font = [UIFont systemFontOfSize:14];
    _nameDataLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_nameDataLabel];
    
    UILabel *startPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12+45+45+45, 70, 20)];
    startPriceLabel.text = @"起拍价";
    startPriceLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:startPriceLabel];
    
    _startPriceDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 12+45+45+45, S_W-95, 20)];
    _startPriceDataLabel.font = [UIFont systemFontOfSize:14];
    _startPriceDataLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_startPriceDataLabel];
    
    UILabel *dealPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12+45+45+45+20+45, 70, 20)];
    dealPriceLabel.text = @"成交金额";
    dealPriceLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:dealPriceLabel];
    _dealPriceDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 12+45+45+45+20+45, S_W-95, 20)];
    _dealPriceDataLabel.font = [UIFont systemFontOfSize:14];
    _dealPriceDataLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_dealPriceDataLabel];
    
    UILabel *completeTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12+45+45+45+20+45+45, 70, 20)];
    completeTimeLabel.text = @"竞得时间";
    completeTimeLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:completeTimeLabel];
    _completeTimeDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 12+45+45+45+20+45+45, S_W-95, 20)];
    _completeTimeDataLabel.font = [UIFont systemFontOfSize:14];
    _completeTimeDataLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_completeTimeDataLabel];
    
    UILabel *zhiFuZhuangtaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12+45+45+45+20+45+45+45, 70, 20)];
    zhiFuZhuangtaiLabel.text = @"支付状态";
    zhiFuZhuangtaiLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:zhiFuZhuangtaiLabel];
    _zhiFuZhuangtaiDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 12+45+45+45+20+45+45+45, S_W-95, 20)];
    _zhiFuZhuangtaiDataLabel.font = [UIFont systemFontOfSize:14];
    _zhiFuZhuangtaiDataLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_zhiFuZhuangtaiDataLabel];
    _zhiFuZhuangtaiDataLabel.text = self.zhiFuZhuangTai;
   
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
}
/* type = 1
{
    "code": 200,
    "object": {
        "tsName": "电流时间转换装置拍卖",
        "tsSiteType": "0",
        "tsMinPrice": "10000",
        "tsEndPrice": "18001",
        "tsTradeNo": "P20171118091054311543",
        "saleUsername": "滦平建龙矿业有限公司",
        "productList": [
                        {
                            "piName": "电流时间转换装置",
                            "piNumber": "5",
                            "piCpxh": "DJ1-E",
                            "piCpcd": "欣灵电气",
                            "pNum": "1个"
                        }
                        ],
        "buyTime": "2017-11-18 09:28:44",
        "diNeedPay": "1000"
    },
    "success": true
}
 type == 2
 {
 success = 1,
 object =     {
 tsMinPrice = "10000",
 tsEndPrice = "18001",
 tsTradeNo = "P20171118091054311543",
 saleUsername = "滦平建龙矿业有限公司",
 tsName = "电流时间转换装置拍卖",
 buyTime = "2017-11-18 09:28:44",
 },
 code = 200,
 }

*/
#pragma mark - Action
#pragma mark 请求数据并赋值
-(void)requestWithTsid:(NSString *)tsId andType:(NSString *)type{
    NSLog(@"---tsId-%@---type-%@",tsId,type);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:tsId forKey:@"tsId"];
    [dict setObject:type forKey:@"type"];
    [dict setObject:kStringToken forKey:@"token"];
    __weak typeof(self)weakSelf = self;
    
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetTradeSiteDetailInBidList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf.hud hide:YES];
        NSLog(@"--XRJieGuoViewController--%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {

            weakSelf.titleDataLabel.text = responseObject[@"object"][@"tradeInfo"][@"tsName"];
            weakSelf.bianHaoDataLabel.text = responseObject[@"object"][@"tradeInfo"][@"tsTradeNo"];
            weakSelf.nameDataLabel.text = responseObject[@"object"][@"tradeInfo"][@"saleUsername"];
            NSString *startPrice = responseObject[@"object"][@"tradeInfo"][@"tsMinPrice"];
            if (startPrice) {
                weakSelf.startPriceDataLabel.text = [NSString stringWithFormat:@"%@",[NSObject moneyStyle:startPrice]];
            }
            NSString *dealPrice = responseObject[@"object"][@"tradeInfo"][@"tsEndPrice"];
            if (dealPrice) {
                weakSelf.dealPriceDataLabel.text = [NSString stringWithFormat:@"%@",[NSObject moneyStyle:dealPrice]];
            }
            weakSelf.completeTimeDataLabel.text = responseObject[@"object"][@"tradeInfo"][@"buyTime"];
            weakSelf.zhiFuZhuangtaiDataLabel.text = responseObject[@"object"][@"zfzt"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



@end
