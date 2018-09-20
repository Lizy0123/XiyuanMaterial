//
//  JiTuanZhuanChangViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "JiTuanZhuanChangViewController.h"
#import "DOPDropDownMenu.h"
#import "BiddingView_single.h"
#import "BiddingView_group.h"
#import "BiddingView_special.h"
#import "ProductCategoryViewController.h"
#import "SearchViewController.h"
#import "JiTuanZhuanChangDetailViewController.h"


@interface JiTuanZhuanChangViewController ()<UITableViewDelegate, UITableViewDataSource, DOPDropDownMenuDataSource, DOPDropDownMenuDelegate>
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (nonatomic, strong) NSArray *productStatusArr;
@property (nonatomic, strong) NSArray *productCategoryArr;
@property (nonatomic, strong) NSArray *keyWordsArr;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *statusStr;
@property (nonatomic, copy) NSString *categoryStr;
@property (nonatomic, copy) NSString *keyWordStr;

@end

@implementation JiTuanZhuanChangViewController


-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
        _dataSourceArray = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", nil];
    }
    return _dataSourceArray;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self.title isEqualToString:@"集团专场"]) {
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){30,30}] style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemLeft)];
        self.navigationItem.leftBarButtonItem = leftBarButton;
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){30,30}] style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemRight)];
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
    self.title = @"集团专场";
    self.isShowFilter = YES;
    

    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (self.isShowFilter) {
        [self configMenu];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(44, 0, kSafeBottomOffset, 0);
        self.myTableView.contentInset = insets;
        self.myTableView.scrollIndicatorInsets = insets;
    }
    
    [self serveDataWithStatusStr:self.statusStr categoryStr:self.categoryStr keyWordStr:self.keyWordStr];
}
-(void)actionNavigationItemLeft{
    [self.navigationController pushViewController:[ProductCategoryViewController new] animated:YES];

}
-(void)actionNavigationItemRight{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:searchVC];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UI
-(void)configMenu{
    self.productStatusArr = @[@"产品状态",@"正常使用",@"故障",@"报废",@"其他"];
    NSMutableArray *arr = [NSMutableArray arrayWithObject:@"产品类别"];
    //    for (ProductCategoryModel *model in [MyHelper unarchiverWithName:kProductCategoryCache]) {
    //        [arr addObject:model.categoryName];
    //    }
    if (arr.count>4) {//    self.productCategoryArr = @[@"产品类别",@"废旧资材",@"闲置设备",@"闲置备品备件"];
        self.productStatusArr = @[arr[0],arr[1],arr[2],arr[3]];
    }else{
        self.productCategoryArr = arr;
    }
    self.keyWordsArr = @[@"关键字"];
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    menu.hasCustomView = YES;
    menu.customViewColumn = 2;
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 44)];
    customView.backgroundColor = [UIColor whiteColor];
    menu.customView = customView;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"请输入产品关键字";
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.borderColor = [UIColor groupTableViewBackgroundColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    [customView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(customView).offset(kMyPadding);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - kMyPadding *2 - 60 - kMyPadding/2, 44));
        
    }];
    self.textField = textField;
    
    
    UIButton *serchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [serchBtn setTitle:@"确定" forState:UIControlStateNormal];
    [serchBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [serchBtn setTitleColor:kColorMain forState:UIControlStateNormal];
    //    [serchBtn setBorderWidth:1];
    //    [serchBtn setBorderColor:kColorMain];
    //    [serchBtn setCornerRadius:15];
    [serchBtn setClipsToBounds:YES];
    [serchBtn addTarget:self action:@selector(actionSearchKeyWordBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [customView addSubview:serchBtn];
    [serchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textField.mas_right).offset(kMyPadding/2);
        make.top.equalTo(textField).offset(kMyPadding/2);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    
    [self.view addSubview:menu];
    
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, 44));
    }];
    self.menu = menu;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    self.menu.finishedBlock=^(DOPIndexPath *indexPath){
        if (indexPath.item >= 0) {
            NSLog(@"收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
            //            _page = 1;
            
        }else {
            //            _page = 1;
            if (indexPath.column == 0) {
                self.statusStr = [@[@"",@"0",@"1",@"2",@"3",] objectAtIndex:indexPath.row];
                NSLog(@"%@",self.statusStr);
            }else if (indexPath.column == 1){
                NSMutableArray *arr = [NSMutableArray arrayWithObject:@""];
                //                for (ProductCategoryModel *model in [MyHelper unarchiverWithName:kProductCategoryCache]) {
                //                    [arr addObject:model.proCategoryId];
                //                }
                self.categoryStr = [arr objectAtIndex:indexPath.row];
                
            }
            NSLog(@"收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
            //            if (![NSObject isString:self.textField.text]) {
            //                self.keyWordStr = @"";
            //            }
            [self serveDataWithStatusStr:self.statusStr categoryStr:self.categoryStr keyWordStr:self.keyWordStr];
        }
    };
    //     创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    //    [menu selectDefalutIndexPath];
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
}

#pragma mark - Action
-(void)serveDataWithStatusStr:(NSString *)statusStr categoryStr:(NSString *)categoryStr keyWordStr:(NSString *)keyWordStr{
    //pageNum：页码（默认值1） | pageSize：每页显示条数（默认值10）| piDqzt：当前状态(0,正常使用，1故障，2报废，3其它) | piCateThird.proCategoryId：三级类别ID（第三级触发查询）| piName：产品关键字 | piCpcd：品牌关键字 | piCpxh：型号关键字
    NSString *pageSize = @"5";
    //    NSString *pageNum = [NSString stringWithFormat:@"%d",_page];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:pageSize forKey:@"pageSize"];
    //    [dict setObject:pageNum forKey:@"pageNum"];
    
    
    //    if ([NSObject isString:statusStr]) {
    //        [dict setObject:statusStr forKey:@"piDqzt"];
    //    }
    //    if ([NSObject isString:categoryStr]) {
    //        [dict setObject:categoryStr forKey:@"piCateFirst.proCategoryId"];
    //    }
    //    if ([NSObject isString:keyWordStr]) {
    //        [dict setObject:keyWordStr forKey:@"piName"];
    //    }
    NSLog(@"Lzy上传的字典%@",dict);
    __weak typeof(self)weakSlef = self;
    //    [[AFHTTPSessionManager manager] POST:[requestUrlHeader stringByAppendingString:kPath_FindProductList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"-responseObject---%@",responseObject);
    //        int codeStr = [responseObject[@"code"]intValue];
    //        if (codeStr == 200) {
    //            if (weakSlef.page == 1) {
    //                [weakSlef.dataSourceArray removeAllObjects];
    //            }
    //
    //            NSArray *array = (NSArray *)responseObject[@"object"];
    //            if (array.count== 0) {
    //                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
    //            }else{
    //                [self.dataSourceArray addObjectsFromArray:[XianZhiGongYingModel arrayOfModelsFromDictionaries:array error:nil]];
    //            }
    //            [weakSlef.myTableView reloadData];
    //            [weakSlef.myTableView.mj_header endRefreshing];
    //            [weakSlef.myTableView.mj_footer endRefreshing];
    //        }
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        [weakSlef.myTableView.mj_header endRefreshing];
    //        [weakSlef.myTableView.mj_footer endRefreshing];
    //
    //    }];
    
}
-(void)actionSearchKeyWordBtn{
    //    _page = 1;
    
    self.keyWordStr = self.textField.text;
    [self serveDataWithStatusStr:self.statusStr categoryStr:self.categoryStr keyWordStr:self.keyWordStr];
    [self.menu hideMenu];
}

#pragma mark - TableView
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //    tableView.rowHeight = [XianZhiGongYingTCell cellHeight];
            tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            
            if (self.navigationController.viewControllers.count > 1) {
                tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
            }else{
                tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
            }
            
            __weak typeof(self)weakSelf = self;
            //    tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //        weakSelf.page = 1;
            //        [weakSelf serveDataWithStatusStr:self.statusStr categoryStr:self.categoryStr keyWordStr:self.keyWordStr];
            //
            //    }];
            //    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //        weakSelf.page ++;
            //        [weakSelf serveDataWithStatusStr:self.statusStr categoryStr:self.categoryStr keyWordStr:self.keyWordStr];
            //
            //    }];
            tableView;
        });
    }return _myTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [BiddingView_group  cellHeight:1];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [self configureCell:cell forIndexPath:indexPath];
    return  cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    

    BiddingView_group *view = [[BiddingView_group alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [BiddingView_group  cellHeight:1])];
        view.biddingM = [BiddingModel new];
        [cell.contentView addSubview:view];

    
    
    //    if (self.listViewType == kListViewType_LandscapeView) {
    //        BiddingView_single *view = [[BiddingView_single alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    //        view.biddingM = [BiddingModel new];
    //        [cell.contentView addSubview:view];
    //    }
    //    else if (self.listViewType == kListViewType_SingleImg){
    //        BiddingView_single *view = [[BiddingView_single alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    //        view.biddingM = [BiddingModel new];
    //        [cell.contentView addSubview:view];
    //    }
    //    else if (self.listViewType == kListViewType_PortraitImg){
    //        BiddingView_single *view = [[BiddingView_single alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    //        view.biddingM = [BiddingModel new];
    //        [cell.contentView addSubview:view];
    //    }
    //    else if (self.listViewType == kListViewType_CollectionImg){
    //        BiddingView_single *view = [[BiddingView_single alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    //        view.biddingM = [BiddingModel new];
    //        [cell.contentView addSubview:view];
    //    }else if (self.listViewType == kListViewType_TwoImg){
    //        BiddingView_single *view = [[BiddingView_single alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    //        view.biddingM = [BiddingModel new];
    //        [cell.contentView addSubview:view];
    //    }
    
    //    cell.model = self.dataSourceArray[indexPath.row];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JiTuanZhuanChangDetailViewController *vc = [JiTuanZhuanChangDetailViewController new];
    vc.title = @"集团专场名称";
    [self.navigationController pushViewController:vc animated:YES];
    
    //    XianZhiGongYingModel *model = self.dataSourceArray[indexPath.row];
    //    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    //    vc.piId = model.piId;
    //    if ([model.userid isEqualToString:[UserManager readUserInfo].codeId]) {
    //        vc.hidBottomView = YES;
    //    }else{
    //        vc.hidBottomView = NO;
    //    }
    //    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - DOPDropDownMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu{
    return 3;
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    if (column == 0) {
        return self.productStatusArr.count;
    }else if (column == 1){
        return self.productCategoryArr.count;
    }else {
        return self.keyWordsArr.count;
    }
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath{
    if (indexPath.column == 0) {
        return self.productStatusArr[indexPath.row];
    } else if (indexPath.column == 1){
        return self.productCategoryArr[indexPath.row];
    } else {
        return self.keyWordsArr[indexPath.row];
    }
}
// new datasource
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath{
    if (indexPath.column == 0 ) {
        return [NSString stringWithFormat:@"ic_productStatus_%ld",indexPath.row];
    }else if (indexPath.column == 1){
        return [NSString stringWithFormat:@"ic_productCategory_%ld",indexPath.row];
    }
    return nil;
}
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath{
    if (indexPath.column == 0 && indexPath.item >= 0) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.item];
    }
    return nil;
}

// new datasource
//- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath{
//    if (indexPath.column < 2) {
//        return [@(arc4random()%1000) stringValue];
//    }
//    return nil;
//}
//- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath{
//    return [@(arc4random()%1000) stringValue];
//}
//- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column{
//    return 0;
//}
//- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath{
//    if (indexPath.column == 0) {
//        return @"产品状态";
//    }else if (indexPath.column == 1){
//        return @"产品类别";
//    }else if (indexPath.column == 2){
//        return @"关键字";
//    }else{
//        return nil;
//    }
//}

//- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath{
//    if (indexPath.item >= 0) {
//        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
//    }else {
//        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
//    }
//}


@end
