//
//  ProductDetailViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/26.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
//#import "X_InfoDetailModel.h"

#import "SendWishViewController.h"


#import "SDCycleScrollView.h"
#import "ProductDetailModel.h"


@interface ProductDetailViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>
//tableView
@property(nonatomic,strong)UITableView *myTableView;
//表头视图
@property(nonatomic,strong)UIView *headerView;
//model数组
@property(nonatomic,strong)NSMutableArray *dataArray;
//信息数量数组
@property(nonatomic,strong)NSMutableArray *countArray;
//轮播图
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;

@property(strong, nonatomic)ProductDetailModel *model;

@end

@implementation ProductDetailViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)countArray{
    if (!_countArray) {
        _countArray = [[NSMutableArray alloc]init];
    }
    return _countArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品详情页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /*
     0.3125*SCREEN_WIDTH
     以320为基础  比例为100:320  就是0.3215倍的屏幕宽 广告位宽度150:320 = 0.46875
     */
    [self configMyTableView];
    [self configBottomView];
    [self serveData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI
-(void)configMyTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    tableView.showsVerticalScrollIndicator = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kViewAtBottomHeight, 0);
    tableView.contentInset = insets;
    tableView.scrollIndicatorInsets = insets;
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
}

-(void)configHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100+0.5*S_W+10)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    self.myTableView.tableHeaderView = self.headerView;
    NSArray *picurlArray = self.model.picUrls;
    
    NSMutableArray *imagesGroup = [NSMutableArray array];
    if (picurlArray.count !=0) {
        for (id str in picurlArray) {
            if ([str isKindOfClass:[NSNull class]]) {
                imagesGroup = nil;
            }
            if ([str isKindOfClass:[NSString class]]) {
                NSString *imageUrl = [picUrlHeader stringByAppendingString:str];
                [imagesGroup addObject:imageUrl];
            }
        }
    }
    // 网络加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,  S_W, 0.5 *S_W) imageURLStringsGroup:imagesGroup];
    cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
    if (imagesGroup.count <= 1) {
        cycleScrollView.showPageControl = NO;
        cycleScrollView.infiniteLoop = NO;
    }
    else{
        cycleScrollView.showPageControl = YES;
        cycleScrollView.infiniteLoop = YES;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        cycleScrollView.autoScrollTimeInterval = 3.0; // 轮播时间间隔，默认1.0秒，可自定义
    }
    cycleScrollView.delegate = self;
    cycleScrollView.backgroundColor=[UIColor lightGrayColor];
    [self.headerView addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;
    
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5 *S_W, S_W, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, S_W-30, 20)];
    titleLabel.text = self.model.piName;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = [UIColor whiteColor];
    [backView addSubview:titleLabel];
    //    {
    //        UILabel *label = [UILabel new];
    //        if ([NSObject isString:self.model.piNumber]) {
    //            if ([NSObject isString:self.model.piUnit]) {
    //                NSString *str = [NSString stringWithFormat:@"x%@%@",self.model.piNumber,self.model.piUnit];
    //                label.attributedText = [MyHelper mutableStr:str color:[UIColor grayColor] length:0];
    //            }else{
    //                NSString *str = [NSString stringWithFormat:@"x%@",self.model.piNumber];
    //                label.attributedText = [MyHelper mutableStr:str color:[UIColor grayColor] length:0];
    //            }
    //        }
    //
    //        label.font = [UIFont boldSystemFontOfSize:12];
    //        [label sizeToFit];
    //        [backView addSubview:label];
    //        [label mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.bottom.equalTo(titleLabel);
    //            make.left.mas_equalTo(titleLabel.mas_right);
    //            make.size.mas_equalTo(CGSizeMake(50, 15));
    //        }];
    //
    //    }
    
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10, S_W-30, 30)];
    priceLabel.text = [NSString stringWithFormat:@"%@元",[MyHelper moneyStyle:self.model.piMinPrice]];
    priceLabel.font = [UIFont systemFontOfSize:16];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.backgroundColor = [UIColor whiteColor];
    [backView addSubview:priceLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+10, S_W-30, 30)];
    timeLabel.text = [NSString stringWithFormat:@"发布日期:%@",self.model.piModtime];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.backgroundColor = [UIColor whiteColor];
    [backView addSubview:timeLabel];
    [self.headerView addSubview:backView];
    //    {
    //        UILabel *brandLabel = [UILabel new];
    //        if ([NSObject isString:self.model.piCpxh]) {
    //            NSString *str = [NSString stringWithFormat:@"x%@",self.model.piCpxh];
    //            brandLabel.attributedText = [MyHelper mutableStr:str color:[UIColor grayColor] length:0];
    //        }
    //
    //        brandLabel.font = [UIFont boldSystemFontOfSize:12];
    //        [brandLabel sizeToFit];
    //        [backView addSubview:brandLabel];
    //        [brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.bottom.equalTo(titleLabel);
    //            make.left.mas_equalTo(titleLabel.mas_right);
    //            make.size.mas_equalTo(CGSizeMake(50, 15));
    //        }];
    //
    //    }
    
}

-(void)configBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"发送购买意愿" andFrame:CGRectMake(16, 0, kScreen_Width-32, 44) target:self action:@selector(jumpToNextVc)];
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kViewAtBottomHeight));
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    
}



#pragma mark - Action
-(void)serveData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    NSString *url = [requestUrlHeader stringByAppendingString:ProductDetailUrl];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.piId forKey:@"piId"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        NSLog(@"-=======%@",responseObject);
        self.model = [[ProductDetailModel alloc] initWithDictionary:responseObject[@"object"] error:nil];
        [self.myTableView reloadData];
        [self configHeaderView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
-(void)jumpToNextVc{
    if ([kStringToken length]) {
        if ([NSObject isString:self.model.piId]&&[NSObject isString:self.model.piName]) {
            SendWishViewController *vc = [[SendWishViewController alloc]init];
            vc.piId = self.model.piId;
            vc.productName = self.model.piName;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        XRLoginViewController *loginVC = [[XRLoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:^{
        }];
    }
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 22;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section{
    if (section == 0) {
        return 50 + (kScreen_Width -kMyPadding *4)/4;
    }else if (section == 1){
        return 50;
    }else{
        return CGFLOAT_MIN;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)] ;
        UILabel *leftLine = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 10, 20)];
        leftLine.backgroundColor = [UIColor orangeColor];
        [headerView addSubview:leftLine];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 120, 30)];
        titleLabel.text = @"购买流程";
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor colorWithRed:190 / 255.0 green:49 / 255.0 blue:32/ 255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:titleLabel];
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"wantToBuyFollow"];
        [headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(headerView).offset(-kMyPadding/2);
            make.top.equalTo(titleLabel.mas_bottom).offset(kMyPadding/2);
            make.right.equalTo(headerView).offset(-kMyPadding *2);
            make.size.mas_equalTo(CGSizeMake(kScreen_Width -kMyPadding *4,(kScreen_Width -kMyPadding *4)/4));
        }];
        
        return headerView;
    }else if (section == 1){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)] ;
        UILabel *leftLine = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 10, 20)];
        leftLine.backgroundColor = [UIColor orangeColor];
        [headerView addSubview:leftLine];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 120, 30)];
        titleLabel.text = @"产品参数";
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor colorWithRed:190 / 255.0 green:49 / 255.0 blue:32/ 255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:titleLabel];
        
        return headerView;
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * iden = @"cellOne";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden ];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"购买流程";
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"wantToBuyFollow"];
        [cell addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(-kMyPadding/2);
            make.top.equalTo(cell).offset(kMyPadding/2);
            
            make.right.equalTo(cell).offset(-kMyPadding);
            make.size.mas_equalTo(CGSizeMake(kScreen_Width - 100 -kMyPadding,(kScreen_Width - 100-kMyPadding)/3));
        }];
        return cell;
    }else{
        switch (indexPath.row) {
            case 0:
                cell.textLabel.attributedText = [NSObject isString:self.model.piCpxh]? [MyHelper mutableStr:[NSString stringWithFormat:@"型号：%@",self.model.piCpxh] color:[UIColor grayColor] length:2]:[MyHelper mutableStr:@"型号：暂无" color:[UIColor grayColor] length:3];
                break;
            case 1:
                cell.textLabel.attributedText = [NSObject isString:self.model.piNumber]? [MyHelper mutableStr:[NSString stringWithFormat:@"数量：%@",self.model.piNumber] color:[UIColor grayColor] length:2]:[MyHelper mutableStr:@"数量：暂无" color:[UIColor grayColor] length:3];
                break;
            case 2:
                cell.textLabel.attributedText = [NSObject isString:self.model.piUnit]? [MyHelper mutableStr:[NSString stringWithFormat:@"数量单位：%@",self.model.piUnit] color:[UIColor grayColor] length:5]:[MyHelper mutableStr:@"数量单位：暂无" color:[UIColor grayColor] length:5];
                break;
            case 3:
                cell.textLabel.attributedText = [NSObject isString:self.model.piCpcd]? [MyHelper mutableStr:[NSString stringWithFormat:@"品牌：%@",self.model.piCpcd] color:[UIColor grayColor] length:3]:[MyHelper mutableStr:@"品牌：暂无" color:[UIColor grayColor] length:3];
                break;
            case 4:
                cell.textLabel.attributedText = [NSObject isString:self.model.piCczl]? [MyHelper mutableStr:[NSString stringWithFormat:@"重量：%@",self.model.piCczl] color:[UIColor grayColor] length:3]:[MyHelper mutableStr:@"重量：暂无" color:[UIColor grayColor] length:3];
                break;
            case 5:
                cell.textLabel.attributedText = [NSObject isString:self.model.piCczlUnit]? [MyHelper mutableStr:[NSString stringWithFormat:@"重量单位：%@",self.model.piCczlUnit] color:[UIColor grayColor] length:5]:[MyHelper mutableStr:@"重量单位：暂无" color:[UIColor grayColor] length:5];
                break;
            case 6:
                cell.textLabel.attributedText = [NSObject isString:self.model.piXjcd]? [MyHelper mutableStr:[NSString stringWithFormat:@"新旧程度：%@",self.model.piXjcd] color:[UIColor grayColor] length:5]:[MyHelper mutableStr:@"新旧程度：暂无" color:[UIColor grayColor] length:5];
                break;
            case 7:
                cell.textLabel.attributedText = [NSObject isString:self.model.piMinPrice]? [MyHelper mutableStr:[NSString stringWithFormat:@"最低出售低价：%@",[MyHelper moneyStyle:self.model.piMinPrice]] color:[UIColor grayColor] length:7]:[MyHelper mutableStr:@"最低出售低价：暂无" color:[UIColor grayColor] length:7];
                break;
            case 8:
                cell.textLabel.attributedText = [NSObject isString:self.model.piNewPrice]? [MyHelper mutableStr:[NSString stringWithFormat:@"原价：%@",self.model.piNewPrice] color:[UIColor grayColor] length:3]:[MyHelper mutableStr:@"原价：暂无" color:[UIColor grayColor] length:3];
                break;
            case 9:
                cell.textLabel.attributedText = [NSObject isString:self.model.piGlh]? [MyHelper mutableStr:[NSString stringWithFormat:@"内部管理号：%@",self.model.piGlh] color:[UIColor grayColor] length:6]:[MyHelper mutableStr:@"内部管理号：暂无" color:[UIColor grayColor] length:6];
                break;
            case 10:
                cell.textLabel.attributedText = [NSObject isString:self.model.piKbh]? [MyHelper mutableStr:[NSString stringWithFormat:@"捆包号：%@",self.model.piKbh] color:[UIColor grayColor] length:4]:[MyHelper mutableStr:@"捆包号：暂无" color:[UIColor grayColor] length:4];
                break;
            case 11:
                cell.textLabel.attributedText = [NSObject isString:self.model.piZyh]? [MyHelper mutableStr:[NSString stringWithFormat:@"资源号：%@",self.model.piZyh] color:[UIColor grayColor] length:4]:[MyHelper mutableStr:@"资源号：暂无" color:[UIColor grayColor] length:4];
                break;
            case 12:
                cell.textLabel.attributedText = [NSObject isString:self.model.piScDate]? [MyHelper mutableStr:[NSString stringWithFormat:@"生产日期：%@",self.model.piScDate] color:[UIColor grayColor] length:5]:[MyHelper mutableStr:@"生产日期：暂无" color:[UIColor grayColor] length:5];
                break;
            case 13:
                cell.textLabel.attributedText = [NSObject isString:self.model.piRkDate]? [MyHelper mutableStr:[NSString stringWithFormat:@"入库日期：%@",self.model.piRkDate] color:[UIColor grayColor] length:5]:[MyHelper mutableStr:@"入库日期：暂无" color:[UIColor grayColor] length:5];
                break;
            case 14:
                if ([NSObject isString:self.model.piDqzt]) {
                    if ([self.model.piDqzt isEqualToString:@"0"]) {
                        cell.textLabel.attributedText = [MyHelper mutableStr:@"当前状态：正常使用" color:[UIColor grayColor] length:5];
                        
                    }else if ([self.model.piDqzt isEqualToString:@"1"]){
                        cell.textLabel.attributedText = [MyHelper mutableStr:@"当前状态：故障" color:[UIColor grayColor] length:5];
                        
                    }else if ([self.model.piDqzt isEqualToString:@"2"]){
                        cell.textLabel.attributedText = [MyHelper mutableStr:@"当前状态：报废" color:[UIColor grayColor] length:5];
                    }else if ([self.model.piDqzt isEqualToString:@"3"]){
                        cell.textLabel.attributedText = [MyHelper mutableStr:@"当前状态：其他" color:[UIColor grayColor] length:5];
                    }
                }else{
                    cell.textLabel.attributedText = [MyHelper mutableStr:@"当前状态：暂无" color:[UIColor grayColor] length:5];
                }
                break;
            case 15:
                cell.textLabel.attributedText = [NSObject isString:self.model.piCcgg]? [MyHelper mutableStr:[NSString stringWithFormat:@"尺寸规格：%@",self.model.piCcgg] color:[UIColor grayColor] length:5]:[MyHelper mutableStr:@"尺寸规格：暂无" color:[UIColor grayColor] length:5];
                break;
            case 16:
                if ([NSObject isString:self.model.piYyhgz]) {
                    if ([self.model.piYyhgz isEqualToString:@"1"]) {
                        cell.textLabel.attributedText = [MyHelper mutableStr:@"有无合格证：有" color:[UIColor grayColor] length:6];
                        
                    }else if ([self.model.piYyhgz isEqualToString:@"0"]){
                        cell.textLabel.attributedText = [MyHelper mutableStr:@"有无合格证：无" color:[UIColor grayColor] length:6];
                    }
                }else{
                    cell.textLabel.attributedText = [MyHelper mutableStr:@"有无合格证：暂无" color:[UIColor grayColor] length:6];
                    
                }
                break;
            case 17:
                cell.textLabel.attributedText = [NSObject isString:self.model.piGzxs]? [MyHelper mutableStr:[NSString stringWithFormat:@"工作小时：%@",self.model.piGzxs] color:[UIColor grayColor] length:5]:[MyHelper mutableStr:@"工作小时：暂无" color:[UIColor grayColor] length:5];
                break;
            case 18:
                if ([NSObject isString:self.model.piYwdx]) {
                    if ([self.model.piYwdx isEqualToString:@"1"]) {
                        cell.textLabel.attributedText = [MyHelper mutableStr:@"有无大修：有" color:[UIColor grayColor] length:5];
                        
                    }else if ([self.model.piYwdx isEqualToString:@"0"]){
                        cell.textLabel.attributedText = [MyHelper mutableStr:@"有无大修：无" color:[UIColor grayColor] length:5];
                    }
                }else{
                    cell.textLabel.attributedText = [MyHelper mutableStr:@"有无大修：暂无" color:[UIColor grayColor] length:5];
                    
                }
                break;
            case 19:
                cell.textLabel.attributedText = [NSObject isString:self.model.piJjfs]? [MyHelper mutableStr:[NSString stringWithFormat:@"废旧资材计价方式：%@",self.model.piJjfs] color:[UIColor grayColor] length:9]:[MyHelper mutableStr:@"废旧资材计价方式：暂无" color:[UIColor grayColor] length:9];
                break;
            case 20:
                if ([NSObject isString:self.model.cateFirst]) {
                    if ([NSObject isString:self.model.cateSecond]) {
                        if ([NSObject isString:self.model.cateThird]) {
                            cell.textLabel.attributedText = [MyHelper mutableStr:[NSString stringWithFormat:@"产品类别：%@>%@>%@",self.model.cateFirst,self.model.cateSecond,self.model.cateThird] color:[UIColor grayColor] length:5];
                        }else{
                            cell.textLabel.attributedText = [MyHelper mutableStr:[NSString stringWithFormat:@"产品类别：%@>%@",self.model.cateFirst,self.model.cateSecond] color:[UIColor grayColor] length:5];
                        }
                    }else{
                        cell.textLabel.attributedText = [MyHelper mutableStr:[NSString stringWithFormat:@"产品类别：%@",self.model.cateFirst] color:[UIColor grayColor] length:5];
                    }
                }else{
                    cell.textLabel.attributedText = [MyHelper mutableStr:@"产品类别：暂无" color:[UIColor grayColor] length:5];
                    
                }
                break;
            case 21:
                cell.textLabel.attributedText = [NSObject isString:self.model.piAddress]? [MyHelper mutableStr:[NSString stringWithFormat:@"所在地：%@",self.model.piAddress] color:[UIColor grayColor] length:4]:[MyHelper mutableStr:@"所在地：暂无" color:[UIColor grayColor] length:4];
                break;
                
            default:
                break;
        }
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}




#pragma mark - Delegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"--=======%ld",(long)index);
}

- (void)indexOnPageControl:(NSInteger)index{
    
}


@end
