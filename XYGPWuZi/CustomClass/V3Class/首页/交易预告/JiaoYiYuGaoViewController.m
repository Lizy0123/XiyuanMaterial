//
//  JiaoYiYuGaoViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/12.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "JiaoYiYuGaoViewController.h"
#import "JiaoYiYuGaoTCell.h"
#import "Api_JiaoYiYuGao.h"
#import "JiaoYiYuGaoDetailViewController.h"
#import "Api_JiaoYiYuGaoList.h"

@interface JiaoYiYuGaoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    MyPage _myPage;
}
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataSourceArray;
@property (nonatomic,assign)__block int page;
@end

@implementation JiaoYiYuGaoViewController
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        }else{
            make.edges.mas_equalTo(self.view);
        }
    }];
    
    __weak typeof(self)weakSelf = self;
    _myPage.pageIndex = 1;
    _myPage.pageSize = 15;
    
    self.page = 1;
    self.myTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _myPage.pageIndex = 1;
        [weakSelf serveData];
        
//        weakSelf.page = 1;
//        [weakSelf serveData];
    }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.dataSourceArray.count == 0) {
            _myPage.pageIndex = 1;
        }else{
            _myPage.pageIndex ++;
        }
        [weakSelf serveData];
        
//        weakSelf.page ++;
//        [weakSelf serveData];
    }];
    
    [self serveData];
}

#pragma mark - Action
-(void)serveData{
    
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
    Api_JiaoYiYuGaoList *api = [[Api_JiaoYiYuGaoList alloc] initWithPage:_myPage];
    api.animatingText = @"正在加载...";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        if (_myPage.pageIndex == 1) {
            [self.dataSourceArray removeAllObjects];
        }
        int codeStr = [request.responseJSONObject[@"code"] intValue];
        if (codeStr == 200) {
            NSArray *array = (NSArray *)request.responseObject[@"object"];
            if (array.count== 0) {
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.dataSourceArray addObjectsFromArray:[JiaoYiYuGaoModel arrayOfModelsFromDictionaries:request.responseObject[@"object"] error:nil]];
            }
        }
        [self.myTableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (!(_myPage.pageIndex == 1)) {
            _myPage.pageIndex--;
        }
        [NSObject ToastShowStr:@"加载失败！"];
    }];
    
    
    
//    __weak typeof(self)weakself = self;
//
//    //    pageNum：页码（默认1）|pageSize：显示的条数（默认10
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    NSString *number = [NSString stringWithFormat:@"%d",_page];
//    NSString *pageSize = @"15";
//    [dict setObject:number forKey:@"pageNum"];
//    [dict setObject:pageSize forKey:@"pageSize"];
//
//    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_AdvanceNoticeList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [weakself.myTableView.mj_header endRefreshing];
//        [weakself.myTableView.mj_footer endRefreshing];
//        if (weakself.page == 1) {
//
//            [weakself.dataSourceArray removeAllObjects];
//        }
//
//        int codeStr = [responseObject[@"code"]intValue];
//        if (codeStr == 200) {
//            NSArray *array = (NSArray *)responseObject[@"object"];
//            if (array.count== 0) {
//                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
//            }else{
//                [self.dataSourceArray addObjectsFromArray:[TransactionPreviewModel arrayOfModelsFromDictionaries:responseObject[@"object"] error:nil]];
//            }
//        }
//        [weakself.myTableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [weakself.myTableView.mj_header endRefreshing];
//        [weakself.myTableView.mj_footer endRefreshing];
//    }];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakself.myTableView.mj_header endRefreshing];
//        [weakself.myTableView.mj_footer endRefreshing];
//    });
}
#pragma mark - Delegate/DataSource
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.sectionIndexBackgroundColor = [UIColor clearColor];
            tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
            tableView.sectionIndexColor = [UIColor groupTableViewBackgroundColor];
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableView.showsVerticalScrollIndicator = NO;
            tableView.allowsMultipleSelectionDuringEditing = YES;
            
//            tableView.tableHeaderView = [self tableHeader];
            //            tableView.tableFooterView = [self tableFooterView];
            //        [tableView registerClass:[CountryCodeCell class] forCellReuseIdentifier:kCellIdentifier_CountryCodeCell];
            
            if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
                [tableView setSeparatorInset:UIEdgeInsetsZero];
            }
            if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
                [tableView setLayoutMargins:UIEdgeInsetsZero];
            }
            
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
            tableView;
        });
    }return _myTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JiaoYiYuGaoTCell cellHeight];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JiaoYiYuGaoTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[JiaoYiYuGaoTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.transactionM = self.dataSourceArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JiaoYiYuGaoModel *model = self.dataSourceArray[indexPath.row];
    JiaoYiYuGaoDetailViewController *vc = [[JiaoYiYuGaoDetailViewController alloc]init];
    vc.tnID = model.tnId;
    vc.titleText = model.tnTitle;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
