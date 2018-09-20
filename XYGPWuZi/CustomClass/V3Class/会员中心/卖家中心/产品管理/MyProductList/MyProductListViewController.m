//
//  MyProductListViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "MyProductListViewController.h"
#import "MyProductTCell.h"
#import "MyProductModel.h"
#import "AddProductViewController.h"
#import "ChaKanFanKuiViewController.h"

#import "UIViewController+KNSemiModal.h"
#import "TradeSiteListViewController.h"
#import "ProductDetailViewController.h"

#import "AddBiddingSingleViewController.h"
#import "AddBiddingTradeSiteViewController.h"

@interface MyProductListViewController ()<UITableViewDelegate, UITableViewDataSource, MyProductTCellDelegate>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)TradeSiteListViewController *listVC;

@property (nonatomic,assign)__block int page;

@end

static NSString * const cellIdentifier = @"cellIdentifier";

@implementation MyProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;

    [self configMyTableView];
    [self serveData];

//    if (self.myProductAuditStatus == kMyProductAuditStatus_Success) {
//        [self serveData];
//    }
//    else{
//        __weak typeof(self)weakSelf = self;
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
//            [weakSelf serveData];
//        });
//    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.myProductAuditStatus == kMyProductAuditStatus_Success) {
        self.tradeSiteListArray = [NSObject unarchiverWithName:kTradeSiteCache];
        if (self.tradeSiteListArray.count >0) {
            [self configBottomView];
        }
    }
}
#pragma mark - UI
-(void)configMyTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = NO;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
    __weak typeof(self)weakSelf = self;
    self.myTableView.mj_header  = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf serveData];
        
    }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf serveData];
    }];
}
-(void)hidBottomView{
    [self.bottomView setHidden:YES];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myTableView.contentInset = insets;
    self.myTableView.scrollIndicatorInsets = insets;
}
-(void)configBottomView{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49, 0);
    self.myTableView.contentInset = insets;
    self.myTableView.scrollIndicatorInsets = insets;
    if (!self.bottomView) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(kViewAtBottomHeight + kMyPadding/2);
        }];
        self.bottomView = bottomView;
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"生成拼盘" forState:UIControlStateNormal];
            [btn setTitleColor:kColorNav forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [btn setCornerRadius:20];
            [btn setClipsToBounds:YES];
            [btn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [btn.layer setBorderWidth:1];
            [btn addTarget:self action:@selector(actionCreateTradeSite:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bottomView).offset(kMyPadding *2);
                make.top.equalTo(bottomView).offset(kMyPadding/2);
                make.size.mas_equalTo(CGSizeMake(((kScreen_Width - 32)/2) -32, 44));
            }];
        }
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"查看拼盘" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:kColorNav];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
            [btn setCornerRadius:20];
            [btn setClipsToBounds:YES];
            [btn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [btn.layer setBorderWidth:1];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [btn addTarget:self action:@selector(actionShowTradeSiteList:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(bottomView).offset(-kMyPadding *2);
                make.top.equalTo(bottomView).offset(kMyPadding/2);
                make.size.mas_equalTo(CGSizeMake(((kScreen_Width - 32)/2) -32, 44));
            }];
        }
    }
    self.bottomView.hidden = NO;

}



#pragma mark - Action
-(void)serveData{
    if (!self.dataSourceArray) {
        self.dataSourceArray = [NSMutableArray new];
    }
    NSString *page = [NSString stringWithFormat:@"%d",self.page];
    NSString *piStatus = @"";
    if (self.myProductAuditStatus ==kMyProductAuditStatus_ToDo) {
        piStatus = @"0";
    }else if (self.myProductAuditStatus ==kMyProductAuditStatus_Reject){
        piStatus = @"2";
    }else{
        piStatus = @"1";
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:page forKey:@"pageNum"];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    [dict setObject:piStatus forKey:@"piStatus"];
    
    __weak typeof(self)weakself = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindMyProductList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回数据：%@",responseObject);
        [weakself.myTableView.mj_header endRefreshing];
        [weakself.myTableView.mj_footer endRefreshing];

        if (weakself.page == 1) {
            [weakself.dataSourceArray removeAllObjects];
        }
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
            NSArray *array = (NSArray *)responseObject[@"object"];
            if (array.count== 0) {
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.dataSourceArray addObjectsFromArray:[MyProductModel arrayOfModelsFromDictionaries:array error:nil]];
            }
        }
        
        [weakself.myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself.myTableView.mj_header endRefreshing];
        [weakself.myTableView.mj_footer endRefreshing];

    }];

}
-(void)actionCreateTradeSite:(id)sender{
    AddBiddingTradeSiteViewController *vc = [AddBiddingTradeSiteViewController new];
    vc.title = @"拼盘竞价";
    vc.productListArray = [NSObject unarchiverWithName:kTradeSiteCache];
    [self.navigationController pushViewController:vc animated:YES];
    [self hidBottomView];
}
-(void)actionShowTradeSiteList:(id)sender{//    NSLog(@"查看拼盘");
    if (!self.listVC){
        self.listVC = [[TradeSiteListViewController alloc] init];
    }
    self.listVC.parentVC = self;
    self.listVC.dataSourceArray = [NSObject unarchiverWithName:kTradeSiteCache];
    __weak typeof(self)weakself = self;

    self.listVC.block = ^(NSMutableArray *goodsArr) {
        weakself.tradeSiteListArray = goodsArr;
        if (goodsArr.count>0) {
            [weakself actionCreateTradeSite:nil];
        }
    };
    [self.navigationController presentSemiViewController:self.listVC
                                             withOptions:
          @{KNSemiModalOptionKeys.pushParentBack    : @(YES),
            KNSemiModalOptionKeys.animationDuration : @(0.5),
            KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
            KNSemiModalOptionKeys.backgroundView : [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor clearColor] withFrame:CGRectMake(0, 0, 1, 1)]]}];
}



#pragma mark - Delegate
-(void)btnOnCell:(MyProductTCell *)cell tag:(NSInteger)tag{
    NSIndexPath *indexpath = [self.myTableView indexPathForCell:cell];
    MyProductModel *indexModel = [self.dataSourceArray objectAtIndex:indexpath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tradeSiteAnimationPic"]];
    imageView.size = CGSizeMake(30, 30);

    
    switch (tag) {
        case 101230:
            //@"下架"
        {
            NSLog(@"点击了下架按钮");
            __weak typeof(self)weakself = self;
            //UIAlertController风格：UIAlertControllerStyleAlert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确认要下架该产品吗？"message:@"下架后，该产品将不再平台显示"preferredStyle:UIAlertControllerStyleAlert];
            //添加取消到UIAlertController中
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:cancelAction];
            
            //添加确定到UIAlertController中
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //token：登录令牌 | piId：产品主键ID | status：寄售按钮(传参数：1) 下架（传参数：0）
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                NSString *status = @"0";
                [dict setObject:cell.productM.piId forKey:@"piId"];
                [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
                [dict setObject:status forKey:@"status"];
                
                [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_UpdateProductIsSj] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [weakself serveData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
            }];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 101231:
            //@"上架"
        {
            NSLog(@"点击了寄售按钮");
            __weak typeof(self)weakself = self;
            //UIAlertController风格：UIAlertControllerStyleAlert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确认要寄售该产品吗？"message:@"寄售后，该产品将在闲置购专区显示"preferredStyle:UIAlertControllerStyleAlert];
            
            //添加取消到UIAlertController中
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:cancelAction];
            
            //添加确定到UIAlertController中
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //token：登录令牌 | piId：产品主键ID | status：寄售按钮(传参数：1) 下架（传参数：0）
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                NSString *status = @"1";
                [dict setObject:cell.productM.piId forKey:@"piId"];
                [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
                [dict setObject:status forKey:@"status"];
                NSLog(@"----%@",dict);
                [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_UpdateProductIsSj] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [weakself serveData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            }];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 101232:{
            //@"编辑"
            [NSObject HUDActivityShowStr:nil];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:cell.productM.piId forKey:@"piId"];
            [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
            __weak typeof(self)weakSelf = self;
            [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_EdictProductInfo] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [NSObject HUDActivityHide];
                NSLog(@"------编辑产品--产品信息--%@",responseObject);
                if ([responseObject[@"code"]intValue] == 200) {
                    NSDictionary *dic = responseObject[@"object"];
                    AddProductModel *addProductM = [[AddProductModel alloc] initWithDictionary:dic error:nil];

                    AddProductViewController *vc = [AddProductViewController new];
                    vc.addProductM = addProductM;

                    vc.isEdit = YES;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else{
                    [NSObject ToastShowStr:@"信息加载失败!"];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [NSObject HUDActivityHide];
                [NSObject ToastShowStr:@"信息加载失败!"];

            }];
            
            
            
//            NSLog(@"点击了编辑按钮");
//            [NSObject HUDActivityShowStr:nil];
//            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//            [dict setObject:cell.productM.piId forKey:@"piId"];
//            [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
//            __weak typeof(self)weakSelf = self;
//
//            [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_EdictProductInfo] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                [NSObject HUDActivityHide];
//                NSLog(@"------编辑产品--产品信息--%@",responseObject);
//                int codestr = [responseObject[@"code"]intValue];
//                if (codestr == 200) {
//                    XRAddProductAndEditViewController *vc = [[XRAddProductAndEditViewController alloc]init];
//                    //拼接后的图片url数组
//                    NSMutableArray *completedImageUrlArray = [[NSMutableArray alloc]init];
//                    //拼接前的url数组
//                    NSArray *imageArray = (NSArray *)responseObject[@"object"][@"picUrls"];
//                    //目前手机端只支持4张照片的编辑,但是pc端有的有5张照片,为了不大量修改代码,暂时选4张展示在手机端
//                    if (imageArray.count>0) {
//                        if (imageArray.count>4) {
//                            for (int i = 0; i<4; i++) {
//                                NSString *imageUrl = (NSString *)imageArray[i];
//                                NSString *completedUrl = [myCDNUrl stringByAppendingString:imageUrl];
//                                [completedImageUrlArray addObject:completedUrl];
//                            }
//
//                        }else{
//                            for (NSString *imageUrl in imageArray) {
//                                NSString *completedUrl = [myCDNUrl stringByAppendingString:imageUrl];
//                                [completedImageUrlArray addObject:completedUrl];
//                            }
//                        }
//                        //图片url
//                        vc.imageUrlArray = completedImageUrlArray;
//                    }
//                    else{
//                        vc.imageUrlArray = [[NSMutableArray alloc]init];
//                    }
//                    vc.piId = (NSString*)responseObject[@"object"][@"piId"];
//
//                    //名称
//                    vc.nameField.text = (NSString*)responseObject[@"object"][@"piName"];
//                    /*** 类别 ****/
//                    NSString *fitsrName = (NSString*)responseObject[@"object"][@"cateFirst"];
//                    NSString *secondName = (NSString*)responseObject[@"object"][@"cateSecond"];
//                    NSString *threeName = (NSString*)responseObject[@"object"][@"cateThird"];
//                    if (threeName) {
//                        vc.productLeiBieField.text = [NSString stringWithFormat:@"%@-%@-%@",fitsrName,secondName,threeName];
//                        vc.pfirstId = (NSString*)responseObject[@"object"][@"cateFirstId"];
//                        vc.psecondId = (NSString*)responseObject[@"object"][@"cateSecondId"];
//                        vc.pthirdId = (NSString*)responseObject[@"object"][@"cateThirdId"];
//                    }else{
//                        if (secondName) {
//                            vc.productLeiBieField.text = [NSString stringWithFormat:@"%@-%@",fitsrName,secondName];
//                            vc.pfirstId = (NSString*)responseObject[@"object"][@"cateFirstId"];
//                            vc.psecondId = (NSString*)responseObject[@"object"][@"cateSecondId"];
//                        }else{
//                            if (fitsrName) {
//                                vc.productLeiBieField.text = fitsrName;
//                                vc.pfirstId = (NSString*)responseObject[@"object"][@"cateFirstId"];
//                            }
//                        }
//                    }
//                    //数量
//                    vc.numberField.text = responseObject[@"object"][@"piNumber"];
//                    //单位
//                    vc.productUnitLabel.text = responseObject[@"object"][@"piUnit"];
//                    //型号
//                    vc.productTypeField.text = responseObject[@"object"][@"piCpxh"];
//                    //品牌
//                    vc.productBrandField.text = responseObject[@"object"][@"piCpcd"];
//                    //新旧程度
//                    vc.productOldField.text = responseObject[@"object"][@"piXjcd"];
//
//
//                    /*** 状态 ****/
//                    NSString *productStatus = responseObject[@"object"][@"piDqzt"];
//                    if (productStatus) {
//                        vc.productStatus = productStatus;
//                        if ([productStatus isEqualToString:@"0"]) {
//                            vc.productStatusField.text = @"正常使用";
//                        }
//                        if ([productStatus isEqualToString:@"1"]) {
//                            vc.productStatusField.text = @"故障";
//                        }
//                        if ([productStatus isEqualToString:@"2"]) {
//                            vc.productStatusField.text = @"报废";
//                        }
//                        if ([productStatus isEqualToString:@"3"]) {
//                            vc.productStatusField.text = @"其他";
//                        }
//                    }
//                    //工作时间
//                    vc.workTimeField.text = responseObject[@"object"][@"piGzxs"];
//                    /*** 生产日期 ****/
//                    NSString *creatTime = responseObject[@"object"][@"piScDate"];
//                    if (creatTime) {
//                        vc.createTime = [creatTime substringToIndex:creatTime.length - 9];
//                        vc.productTimeField.text = [creatTime substringToIndex:creatTime.length - 9];
//                    }
//                    //销售底价
//                    vc.minPriceField.text = responseObject[@"object"][@"piMinPrice"];
//
//                    /*** 地区 ****/
//                    vc.productAddressField.text = responseObject[@"object"][@"piAddress"];
//                    vc.piProvince = responseObject[@"object"][@"piProvince"];
//                    vc.piCity = responseObject[@"object"][@"piCity"];
//                    vc.piCounty = responseObject[@"object"][@"piCounty"];
//                    [weakSelf.navigationController pushViewController:vc animated:YES];
//
//                }
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                [NSObject HUDActivityHide];
//            }];
        }
            break;
        case 101233:
            //@"单品竞价"
            if (self.myProductAuditStatus == kMyProductAuditStatus_Success) {
                AddBiddingSingleViewController *vc = [AddBiddingSingleViewController new];
                vc.title = @"单品竞价";
                vc.myProductM = indexModel;
                [self.navigationController pushViewController:vc animated:YES];
                [self hidBottomView];
//                [self configBottomView];
            }else if (self.myProductAuditStatus == kMyProductAuditStatus_Reject){
                __weak typeof(self)weakSelf = self;
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
                [dict setObject:cell.productM.piId forKey:@"piId"];
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                //hud.backgroundColor = [UIColor lightGrayColor];
                [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindProductReson] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [hud hide:YES];
                    int codeStr = [responseObject[@"code"]intValue];
                    if (codeStr == 200) {
                        ChaKanFanKuiViewController *vc = [[ChaKanFanKuiViewController alloc]init];
                        vc.productName = responseObject[@"object"][@"piName"];
                        vc.addTime = responseObject[@"object"][@"piModtime"];
                        vc.status = (NSString *)responseObject[@"object"][@"piStatus"];
                        vc.reason = responseObject[@"object"][@"piReason"];
                        [weakSelf.navigationController pushViewController:vc animated:YES];

                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [hud hide:YES];
                }];
                [hud hide:YES afterDelay:10.0];
            }
            break;
        case 101234:
        {
            //@"加入拼盘"
            if (!self.tradeSiteListArray) {
                self.tradeSiteListArray = [NSMutableArray new];
            }
            cell.animationBtnClicked = ^(UIImageView *goodImage, CGPoint point){
                //                MyProductModel *indexModel = [self.dataSourceArray objectAtIndex:indexPath.row];
                if (self.tradeSiteListArray.count== 0) {
                    [self.tradeSiteListArray addObject:indexModel];
                    [NSObject archiverWithSomeThing:self.tradeSiteListArray someName:kTradeSiteCache];
                    
                    [[Helper sharedInstance] startAnimationandView:imageView andRect: CGRectMake([self.myTableView convertPoint:point toView:self.view].x, [self.myTableView convertPoint:point toView:self.view].y + cell.height, goodImage.size.width/5, goodImage.size.height/5) andFinisnRect:CGPointMake(kScreen_Width/2, kScreen_Height-kViewAtBottomHeight) andFinishBlock:^(BOOL finisn){
                        [Helper shakeAnimation:self.bottomView];
                    }];
                }else{
                    BOOL cotain = false;
                    NSArray * array = [NSArray arrayWithArray: self.tradeSiteListArray];
                    for (int i = 0; i<array.count; i++) {
                        MyProductModel *model = [self.dataSourceArray objectAtIndex:i];
                        if ([model.piId isEqualToString:indexModel.piId]) {
                            NSLog(@"已加入拼盘！");
                            cotain = YES;
                        }
                        if (i==array.count-1) {
                            if (cotain == NO) {
                                [self.tradeSiteListArray addObject:indexModel];
                                [NSObject archiverWithSomeThing:self.tradeSiteListArray someName:kTradeSiteCache];
                                
                                [[Helper sharedInstance] startAnimationandView:imageView andRect: CGRectMake([self.myTableView convertPoint:point toView:self.view].x, [self.myTableView convertPoint:point toView:self.view].y + cell.height, goodImage.size.width/5, goodImage.size.height/5) andFinisnRect:CGPointMake(kScreen_Width/2, kScreen_Height-kViewAtBottomHeight) andFinishBlock:^(BOOL finisn){
                                    [Helper shakeAnimation:self.bottomView];
                                }];
                            }
                        }
                    }

//                    for (MyProductModel *model in array) {
//                        if ([model.piId isEqualToString:indexModel.piId]) {
//                            NSLog(@"已加入拼盘！");
//                            cotain = YES;
//                        }else{
//                            cotain = NO;
//                            [self.tradeSiteListArray addObject:indexModel];
//                            [NSObject archiverWithSomeThing:self.tradeSiteListArray someName:kTradeSiteCache];
//
//                            [[Helper sharedInstance] startAnimationandView:imageView andRect: CGRectMake([self.myTableView convertPoint:point toView:self.view].x, [self.myTableView convertPoint:point toView:self.view].y + cell.height, goodImage.size.width/5, goodImage.size.height/5) andFinisnRect:CGPointMake(kScreen_Width/2, kScreen_Height-kViewAtBottomHeight) andFinishBlock:^(BOOL finisn){
//                                [Helper shakeAnimation:self.bottomView];
//                            }];
//                        }
//                    }
                }
//                if (![self.tradeSiteListArray containsObject:indexModel]) {
//                    [self.tradeSiteListArray addObject:indexModel];
//                    [NSObject archiverWithSomeThing:self.tradeSiteListArray someName:kTradeSiteCache];
//
//                    [[Helper sharedInstance] startAnimationandView:imageView andRect: CGRectMake([self.myTableView convertPoint:point toView:self.view].x, [self.myTableView convertPoint:point toView:self.view].y + cell.height, goodImage.size.width/5, goodImage.size.height/5) andFinisnRect:CGPointMake(kScreen_Width/2, kScreen_Height-kViewAtBottomHeight) andFinishBlock:^(BOOL finisn){
//                        [Helper shakeAnimation:self.bottomView];
//                    }];
//                }else{
//                    NSLog(@"已加入拼盘！");
//                }
            };


            [self configBottomView];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myProductAuditStatus ==kMyProductAuditStatus_Success) {
        return [MyProductTCell cellHeight];
    }else if (self.myProductAuditStatus ==kMyProductAuditStatus_ToDo){
        return [MyProductTCell cellHeight] -30;
    }else{
        return [MyProductTCell cellHeight];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyProductTCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MyProductTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.myProductAuditStatus = self.myProductAuditStatus;
    cell.productM = self.dataSourceArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyProductModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    ProductDetailViewController *vc = [ProductDetailViewController new];
    vc.hidBottomView = YES;

    vc.piId = model.piId;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
