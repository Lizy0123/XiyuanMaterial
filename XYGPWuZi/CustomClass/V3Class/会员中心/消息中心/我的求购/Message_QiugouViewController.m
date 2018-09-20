//
//  Message_QiugouViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Message_QiugouViewController.h"
#import "XianZhiQIuGouDetailViewController.h"
#import "FaBuXuQiuViewController.h"

@interface Message_QiugouViewController ()<UITableViewDelegate, UITableViewDataSource>{
    MyPage _page;
}
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)UITableView *myTableView;
@property(strong, nonatomic)UIButton *bottomBtn;
@end

@implementation Message_QiugouViewController
-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        CGFloat btnHeight = 50;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
        _bottomBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setSize:CGSizeMake(btnWidth, btnHeight)];
            [btn setTitle:@"发布求购" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
            [btn setCornerRadius:btnHeight/2];
            [btn setBackgroundColor:kColorMain];
            [btn setBackgroundImage:[UIImage imageWithColor:UIColor.groupTableViewBackgroundColor] forState:UIControlStateDisabled];
            [btn setBackgroundImage:[UIImage imageWithColor:kColorMain] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(actionBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }return _bottomBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的求购";
    
    //右上角按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布求购" style:UIBarButtonItemStyleDone target:self action:@selector(actionBottomBtn:)];
    
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
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-kSafeBottomOffset);
        make.height.mas_equalTo(50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)actionBottomBtn:(UIButton *)sender{
    FaBuXuQiuViewController *vc = [[FaBuXuQiuViewController alloc]init];
    vc.title = @"发布求购";
    [self.navigationController pushViewController:vc animated:YES];
    
//    NewProductViewController *vc = [NewProductViewController new];
//    vc.title = @"新建产品";
//    [self.navigationController pushViewController:vc animated:YES];
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
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.detailTextLabel.textColor = UIColor.grayColor;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    [self configureCell:cell forIndexPath:indexPath];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XianZhiQIuGouDetailViewController *vc = [XianZhiQIuGouDetailViewController new];
    //ToDo:0123
    vc.riId = @"4028809e5561a8c50155623f138c0008";
    vc.title = @"求购标题";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = @"求购名称求购名称求购名称求购名称求购名称";
    cell.detailTextLabel.text = @"2018-09-10 08:00:00";
//    ProductManageView *view = [[ProductManageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [ProductManageView cellHeight])];
//    [cell.contentView addSubview:view];
//
//    view.isAudit = YES;
//    view.btnBlock = ^(NSString *text) {
//        if ([text isEqualToString:@"送拍"]) {
//            Auction_SendInfoViewController *vc = [Auction_SendInfoViewController new];
//            vc.title = @"送拍信息设置";
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            Barter_InfoViewController *vc = [Barter_InfoViewController new];
//            vc.title = @"易物信息设置";
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    };
//    view.productM = [self.dataSourceArray objectAtIndex:indexPath.row];
    
}



-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (self.isMineIn) {
    return UITableViewCellEditingStyleDelete;
    //    }else{
    //        return UITableViewCellEditingStyleNone;
    //    }
}
#pragma mark - 左滑删除
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        ProductModel *productM = [self.dataSourceArray objectAtIndex:indexPath.row];
//        Api_deletePrducts *api = [[Api_deletePrducts alloc] initWithProductId:productM.productid];
//        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//            NSLog(@"succeed");
//            NSLog(@"response:%@",request.response);
//            NSLog(@"requestArgument:%@",request.requestArgument);
//            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
//
//            if ([request.responseJSONObject[@"code"] isEqualToString:code_Success]) {
//                if (self.dataSourceArray.count>0) {
//                    [self.dataSourceArray removeObjectAtIndex:indexPath.row];
//                    [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//                }
//            }
//
//            NSString *str = request.responseJSONObject[@"msg"];
//            if ([NSObject isString:str]) {
//                [NSObject showStr:str];
//            }
//
//        } failure:^(__kindof YTKBaseRequest *request) {
//            [NSObject showStr:@"删除失败！"];
//            NSLog(@"failed");
//            NSLog(@"response:%@",request.response);
//            NSLog(@"requestArgument:%@",request.requestArgument);
//            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
//        }];
    }];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //获取数据
//        ProductModel *productM = self.dataSourceArray[indexPath.row];
//
//        Api_findProductsById *api = [[Api_findProductsById alloc] initWithProductId:productM.productid];
//        api.animatingText = @"正在获取数据...";
//        api.animatingView = self.view;
//        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//            if ([request.responseJSONObject[@"code"] isEqualToString:code_Success]) {
//                //获取product的详情
//                AddProductViewController *vc = [AddProductViewController new];
//                vc.title = @"编辑商品";
//                vc.productM = [[ProductModel alloc] initWithDictionary:request.responseJSONObject[@"data"] error:nil];
//                [self.navigationController pushViewController:vc animated:YES];
//
//                //                self.productM = [[ProductModel alloc] initWithDictionary:request.responseJSONObject[@"data"] error:nil];
//                //                [self.myTableView reloadData];
//            }
//            NSLog(@"succeed");
//            NSLog(@"response:%@",request.response);
//            NSLog(@"requestArgument:%@",request.requestArgument);
//            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
//        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//            [NSObject ToastShowStr:@"获取数据失败..."];
//            NSLog(@"failed");
//            NSLog(@"response:%@",request.response);
//            NSLog(@"requestArgument:%@",request.requestArgument);
//            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
//        }];
    }];
    editAction.backgroundColor = [UIColor grayColor];
    //    return @[deleteAction, editAction];
    //    if (self.isMineIn) {
    return @[deleteAction, editAction];
    //    }else{
    //        return @[];
    //    }
}

@end
