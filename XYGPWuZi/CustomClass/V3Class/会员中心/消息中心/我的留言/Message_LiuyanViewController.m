//
//  Message_LiuyanViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Message_LiuyanViewController.h"
#import "Message_LiuyanTCell.h"
#import "ProductDetailViewController.h"

@interface Message_LiuyanViewController ()<UITableViewDelegate, UITableViewDataSource>{
    MyPage _page;
}
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)UITableView *myTableView;

@property(strong, nonatomic)Message_LiuyanViewController *myInfoVC;
@property(strong, nonatomic)Message_LiuyanViewController *myAddressVC;

@end

@implementation Message_LiuyanViewController
-(void)segmentChangePage :(UISegmentedControl *)sec;{
    NSInteger index = sec.selectedSegmentIndex;
    if (index == 0) {
        //第一个界面
        [self.view addSubview:_myInfoVC.view];
        [_myAddressVC.view removeFromSuperview];
    }else{
        [self.view addSubview:_myAddressVC.view];
        [_myInfoVC.view removeFromSuperview];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的留言";
    if (self.isManage) {
        //分段控制器
        UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"产品留言",@"求购留言"]];
        segment.frame = CGRectMake(0, 0, 60, 30);
        segment.tintColor = UIColor.whiteColor;
        segment.selectedSegmentIndex = 0;
        [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,UIColor.whiteColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
        [segment addTarget:self action:@selector(segmentChangePage:) forControlEvents:UIControlEventValueChanged];
        //    self.navigationController.navigationBar.translucent = NO;
        self.navigationItem.titleView = segment;
        
        
        //创建控制器的对象
        _myInfoVC = [[Message_LiuyanViewController alloc] init];
        _myInfoVC.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _myAddressVC = [[Message_LiuyanViewController alloc] init];
        _myAddressVC.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [self.view addSubview:_myInfoVC.view];
    }else{
        [self.view addSubview:self.myTableView];
        [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        //刷新功能
        _page.pageIndex = 1;
        _page.pageSize = 10;
        self.myTableView.mj_header  = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            _page.pageIndex = 1;
            [self serveData];
        }];
        self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (self.dataSourceArray.count == 0) {
                _page.pageIndex = 1;
            }else{
                _page.pageIndex ++;
            }
            [self serveData];
        }];
    }
}
-(void)serveData{
    [self.dataSourceArray addObjectsFromArray:@[@"",@"",@"",@"",@"",@""]];
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
    [self.myTableView reloadData];
    //    Api_findProductByUserId *api = [[Api_findProductByUserId alloc] initWithUserId:@"" page:_page];
    //    api.animatingText = @"正在加载商品";
    //    api.animatingView = self.view;
    //    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
    //        if ([request.responseJSONObject[@"code"] isEqualToString:code_Success]) {
    //            NSMutableArray *arr = [ProductModel arrayOfModelsFromDictionaries:request.responseJSONObject[@"data"] error:nil];
    //            if (_page.pageIndex == 1) {
    //                self.dataSourceArray = arr;
    //            }else{
    //                [self.dataSourceArray addObjectsFromArray:arr];
    //            }
    //            [self.myTableView reloadData];
    //        }
    //        NSLog(@"succeed");
    //        NSLog(@"response:%@",request.response);
    //        NSLog(@"requestArgument:%@",request.requestArgument);
    //        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    //
    //        [self.myTableView.mj_header endRefreshing];
    //        [self.myTableView.mj_footer endRefreshing];
    //    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    //        NSLog(@"failed");
    //        NSLog(@"response:%@",request.response);
    //        NSLog(@"requestArgument:%@",request.requestArgument);
    //        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    //        if (!(_page.pageIndex == 1)) {
    //            _page.pageIndex--;
    //        }
    //
    //        [self.myTableView.mj_header endRefreshing];
    //        [self.myTableView.mj_footer endRefreshing];
    //    }];
}
#pragma mark - TableView
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc] init];
    }return _dataSourceArray;
}
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
            tableView.showsVerticalScrollIndicator = NO;
            tableView.allowsMultipleSelectionDuringEditing = YES;
            
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
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message_LiuyanTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[Message_LiuyanTCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
//    else{
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = @"求购名称求购名称求购名称求购名称求购名称";
    cell.timeLabel.text = @"2017-12-26";
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"2017-12-26";
//    [cell.contentView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(cell.textLabel);
//        make.right.equalTo(cell.contentView);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(80);
//    }];
    cell.detailLabel.text = @"您昨天累计收到1张价值10.0元的优惠券赶紧快去看看吧您昨天累计收到1张价值10.0元的优惠券，赶紧快去看看吧！";
    cell.detailLabel.numberOfLines = 2;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailViewController *vc = [ProductDetailViewController new];
    vc.hidBottomView = YES;
    [[BaseViewController presentingVC].navigationController pushViewController:vc animated:YES];
    
}

@end
