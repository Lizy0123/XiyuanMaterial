//
//  SearchDisplayController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define PYSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SearchHistories.plist"] // 搜索历史存储路径

#import "SearchDisplayController.h"
#import "PublicSearchModel.h"

#import "TradeNoticeViewController.h"
#import "TradeNoticeTCell.h"
#import "TradeNoticeModel.h"
#import "JingJiaDetailViewController.h"
#import "X_JingJiaDetailViewController.h"


#import "JiaoYiYuGaoViewController.h"
#import "JiaoYiYuGaoTCell.h"
#import "Api_JiaoYiYuGao.h"
#import "JiaoYiYuGaoDetailViewController.h"

#import "XianZhiQiuGouModel.h"
#import "XianZhiQiuGouCell.h"
#import "XianZhiQIuGouDetailViewController.h"

#import "XianZhiQiuGouViewController.h"
#import "XianZhiGongYingTCell.h"
#import "XianZhiGongYingModel.h"
#import "ProductDetailViewController.h"


@interface SearchDisplayController()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) PublicSearchModel *searchPros;
@property (nonatomic, strong) UIScrollView *searchHistoryView;
@property (nonatomic, assign) double historyHeight;
@property (nonatomic, copy) NSString *searchHistoriesCachePath;/** 搜索历史缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */

@property (nonatomic, strong) NSMutableArray *searchHistories;/** 搜索历史 */
@property (nonatomic, assign) NSUInteger searchHistoriesCount;/** 搜索历史记录缓存数量，默认为20 */


//列表页码
@property(nonatomic,assign)int page;

- (void)initSearchResultsTableView;
- (void)initSearchHistoryView;
- (void)didClickedMoreHotkey:(UIGestureRecognizer *)sender;
- (void)didCLickedCleanSearchHistory:(id)sender;
- (void)didClickedContentView:(UIGestureRecognizer *)sender;
- (void)didClickedHistory:(UIGestureRecognizer *)sender;

@end

@implementation SearchDisplayController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _searchHistoryView.delegate = nil;
}


- (void)setActive:(BOOL)visible animated:(BOOL)animated {

    if(!visible) {
        
        [_myTableView removeFromSuperview];
        //        [_backgroundView removeFromSuperview];
        [_contentView removeFromSuperview];
        
        _myTableView = nil;
        _contentView = nil;
        //        _backgroundView = nil;
        _searchHistoryView = nil;
        
        [super setActive:visible animated:animated];
    }else {
        
        [super setActive:visible animated:animated];
        NSArray *subViews = self.searchContentsController.view.subviews;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            
            for (UIView *view in subViews) {
                
                if ([view isKindOfClass:NSClassFromString(@"UISearchDisplayControllerContainerView")]) {
                    
                    NSArray *sub = view.subviews;
                    ((UIView*)sub[2]).hidden = YES;
                }
            }
        } else {
            
            [[subViews lastObject] removeFromSuperview];
        }
        
        if(!_contentView) {
            
            _contentView = ({
                
                UIView *view = [[UIView alloc] init];
                view.frame = CGRectMake(0.0f, kSafeAreaTopHeight, kScreen_Width, kScreen_Height - kSafeAreaTopHeight);
                view.backgroundColor = [UIColor clearColor];
                view.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedContentView:)];
                [view addGestureRecognizer:tapGestureRecognizer];
                
                view;
            });
            self.contentView.backgroundColor= [UIColor whiteColor];
            [self initSearchHistoryView];
        }
        
        [self.parentVC.view addSubview:_contentView];
        [self.parentVC.view bringSubviewToFront:_contentView];
        self.searchBar.delegate = self;
    }
}
- (void)initSearchResultsTableView {
    self.dataSourceArray = [[NSMutableArray alloc] init];
    if(!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:_contentView.frame style:UITableViewStylePlain];
            tableView.backgroundColor = [UIColor whiteColor];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tableView registerClass:[TradeNoticeTCell class] forCellReuseIdentifier:@"TradeNoticeTCell"];
            [tableView registerClass:[JiaoYiYuGaoTCell class] forCellReuseIdentifier:@"TransactionPreviewTCell"];
            [tableView registerClass:[XianZhiGongYingTCell class] forCellReuseIdentifier:@"IdleProductTCell"];

            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
            tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

            [self.parentVC.view addSubview:tableView];
            tableView;
        });
    }
    [_myTableView.superview bringSubviewToFront:_myTableView];
    
    [_myTableView reloadData];
    self.page = 1;
    [self serveData];
}
-(void)reloadDisplayData{
    [self.dataSourceArray removeAllObjects];
    self.page = 1;
    [self serveData];
}
//搜索历史记录
- (NSMutableArray *)searchHistories{
    if (!_searchHistories) {
        self.searchHistoriesCachePath = PYSEARCH_SEARCH_HISTORY_CACHE_PATH;
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
    }
    return _searchHistories;
}
- (void)setSearchHistoriesCachePath:(NSString *)searchHistoriesCachePath{
    _searchHistoriesCachePath = [searchHistoriesCachePath copy];
    // 刷新
    self.searchHistories = nil;
    [self.myTableView reloadData];
}

- (void)initSearchHistoryView {
    self.searchHistoriesCount = 20;

    if(!_searchHistoryView) {
        
        _searchHistoryView = [[UIScrollView alloc] init];
        _searchHistoryView.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:_searchHistoryView];
        self.searchBar.delegate=self;
        [self registerForKeyboardNotifications];
    }
    
    [[_searchHistoryView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
        view.backgroundColor = kColorHex(0xdddddd);
        [_searchHistoryView addSubview:view];
    }
    NSArray *array = self.searchHistories;//[CSSearchModel getSearchHistory];
    CGFloat imageLeft = 12.0f;
    CGFloat textLeft = 34.0f;
    CGFloat height = 44.0f;
    
//    _historyHeight=height*(array.count+1);
    _historyHeight = kScreen_Height - 150;
    //set history list
    [_searchHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(_historyHeight);
    }];
    _searchHistoryView.contentSize = CGSizeMake(kScreen_Width, _historyHeight);
    
    
    for (int i = 0; i < array.count; i++) {
        UILabel *lblHistory = [[UILabel alloc] initWithFrame:CGRectMake(textLeft, i * height, kScreen_Width - textLeft, height)];
        lblHistory.userInteractionEnabled = YES;
        lblHistory.font = [UIFont systemFontOfSize:14];
        lblHistory.textColor = kColorHex(0x222222);
        lblHistory.text = array[i];
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        leftView.left = 12;
        leftView.centerY = lblHistory.centerY;
        leftView.image = [UIImage imageNamed:@"icon_search_clock"];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
        rightImageView.right = kScreen_Width - 12;
        rightImageView.centerY = lblHistory.centerY;
        rightImageView.image = [UIImage imageNamed:@"icon_arrow_searchHistory"];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(imageLeft, (i + 1) * height, kScreen_Width - imageLeft, 0.5)];
        view.backgroundColor = kColorHex(0xdddddd);
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedHistory:)];
        [lblHistory addGestureRecognizer:tapGestureRecognizer];
        
        [_searchHistoryView addSubview:lblHistory];
        [_searchHistoryView addSubview:leftView];
        [_searchHistoryView addSubview:rightImageView];
        [_searchHistoryView addSubview:view];
    }
    
    if(array.count) {
        UIButton *btnClean = [UIButton buttonWithType:UIButtonTypeCustom];
        btnClean.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnClean setTitle:@"清除搜索历史" forState:UIControlStateNormal];
        [btnClean setTitleColor:kColorHex(0x1bbf75) forState:UIControlStateNormal];
        [btnClean setFrame:CGRectMake(0, array.count * height, kScreen_Width, height)];
        [_searchHistoryView addSubview:btnClean];
        [btnClean addTarget:self action:@selector(didCLickedCleanSearchHistory:) forControlEvents:UIControlEventTouchUpInside];
        {
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(imageLeft, (array.count + 1) * height, kScreen_Width - imageLeft, 0.5)];
//            view.backgroundColor = kColorHex(0xdddddd);
//            [_searchHistoryView addSubview:view];
        }
    }
    
}

#pragma mark - Acton
- (void)didClickedMoreHotkey:(UIGestureRecognizer *)sender {
    [self.searchBar resignFirstResponder];
//    CSHotTopicPagesVC *vc = [CSHotTopicPagesVC new];
//    [self.parentVC.navigationController pushViewController:vc animated:YES];
    
}

- (void)didCLickedCleanSearchHistory:(id)sender {
    
//    [CSSearchModel cleanAllSearchHistory];
    [self.searchHistories removeAllObjects];
    // 移除数据缓存
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];

    [self initSearchHistoryView];
}

- (void)didClickedContentView:(UIGestureRecognizer *)sender {
    [self.searchBar resignFirstResponder];
}

- (void)didClickedHistory:(UIGestureRecognizer *)sender {
    UILabel *label = (UILabel *)sender.view;
    self.searchBar.text = label.text;
    // 缓存数据并且刷新界面
    [self actionSaveSearchCacheAndRefreshView];

//    [CSSearchModel addSearchHistory:self.searchBar.text];
    [self initSearchHistoryView];
    [self.searchBar resignFirstResponder];
    [self initSearchResultsTableView];
}
/** 进入搜索状态调用此方法 */
- (void)actionSaveSearchCacheAndRefreshView{
    UISearchBar *searchBar = self.searchBar;
    // 回收键盘
    [searchBar resignFirstResponder];
    // 先移除再刷新
    [self.searchHistories removeObject:searchBar.text];
    [self.searchHistories insertObject:searchBar.text atIndex:0];
    
    // 移除多余的缓存
    if (self.searchHistories.count > self.searchHistoriesCount) {
        // 移除最后一条缓存
        [self.searchHistories removeLastObject];
    }
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    
    [self.myTableView reloadData];
}
#pragma mark -- goVC
- (void)goToTradeNotice:(TradeNoticeModel *)model{
//    JingJiaDetailViewController *vc = [[JingJiaDetailViewController alloc]init];
//    vc.tnId = model.tnId;
//    [self.parentVC.navigationController pushViewController:vc animated:TRUE];
    X_JingJiaDetailViewController *vc = [[X_JingJiaDetailViewController alloc]init];
    vc.tnId = model.tnId;
    [self.parentVC.navigationController pushViewController:vc animated:YES];
}

-(void)goToTransactionPreviewVC:(JiaoYiYuGaoModel *)transactionPreviewModel{
    JiaoYiYuGaoDetailViewController *vc = [[JiaoYiYuGaoDetailViewController alloc]init];
    vc.tnID = transactionPreviewModel.tnId;
    vc.titleText = transactionPreviewModel.tnTitle;
    [self.parentVC.navigationController pushViewController:vc animated:YES];
}

- (void)goToIdleProductVC:(XianZhiGongYingModel *)idleProductModel{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.piId = idleProductModel.piId;

    [self.parentVC.navigationController pushViewController:vc animated:YES];
}

- (void)goToWantToBuyVC:(XianZhiQiuGouModel *)wantToBuyM{
    XianZhiQIuGouDetailViewController *vc = [[XianZhiQIuGouDetailViewController alloc]init];
    vc.riId = wantToBuyM.riId;
    vc.title = wantToBuyM.riTitle;
    [self.parentVC.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark Search Data Request

- (void)refresh {
    if(_isLoading){
        [_myTableView.mj_header endRefreshing];
        return;
    }
    self.page = 1;
    [self serveData];
}

- (void)loadMore {
    if(_isLoading){
        [_myTableView.mj_footer endRefreshing];
        return;
    }
    self.page ++;
    [self serveData];

}
-(void)serveData{
    self.isLoading = YES;

    if (_curSearchType == kSearchType_TradeNotice){
        NSString *pageNum = [NSString stringWithFormat:@"%d",self.page];
        NSString *pageSize = @"15";
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:pageNum forKey:@"pageNum"];
        [dict setObject:pageSize forKey:@"pageSize"];
        [dict setObject:self.searchBar.text forKey:@"tnTitle"];
        
        __weak typeof(self)weakSelf = self;
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_TradeNoticeList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            weakSelf.isLoading = NO;
            NSLog(@"------%@",responseObject);
            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshing];
            if (weakSelf.page ==1) {
                [weakSelf.dataSourceArray removeAllObjects];
            }
            
            NSArray *array = (NSArray *)responseObject[@"object"];
            if (array.count== 0) {
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.dataSourceArray addObjectsFromArray:[TradeNoticeModel arrayOfModelsFromDictionaries:array error:nil]];
            }
            [weakSelf.myTableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            weakSelf.isLoading = NO;
            
        }];

    }else if (_curSearchType == kSearchType_TransactionPreview){
        __weak typeof(self)weakSelf = self;
        
        //    pageNum：页码（默认1）|pageSize：显示的条数（默认10
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSString *number = [NSString stringWithFormat:@"%d",_page];
        NSString *pageSize = @"15";
        [dict setObject:number forKey:@"pageNum"];
        [dict setObject:pageSize forKey:@"pageSize"];
        [dict setObject:self.searchBar.text forKey:@"tnTitle"];
        
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_AdvanceNoticeList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"----%@",responseObject);
            weakSelf.isLoading = NO;

            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshing];
            if (weakSelf.page == 1) {
                [weakSelf.dataSourceArray removeAllObjects];
            }
            
            int codeStr = [responseObject[@"code"]intValue];
            if (codeStr == 200) {
                NSArray *array = (NSArray *)responseObject[@"object"];
                if (array.count== 0) {
                    [self.myTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.dataSourceArray addObjectsFromArray:[JiaoYiYuGaoModel arrayOfModelsFromDictionaries:responseObject[@"object"] error:nil]];
                }
            }
            [weakSelf.myTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            weakSelf.isLoading = NO;

            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshing];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshing];
        });

    }else if (_curSearchType == kSearchType_IdleProduct){
        //pageNum：页码（默认值1） | pageSize：每页显示条数（默认值10）| piDqzt：当前状态(0,正常使用，1故障，2报废，3其它) | piCateThird.proCategoryId：三级类别ID（第三级触发查询）| piName：产品关键字 | piCpcd：品牌关键字 | piCpxh：型号关键字
        NSString *pageSize = @"5";
        NSString *pageNum = [NSString stringWithFormat:@"%d",_page];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:pageSize forKey:@"pageSize"];
        [dict setObject:pageNum forKey:@"pageNum"];
        [dict setObject:self.searchBar.text forKey:@"piName"];
        NSLog(@"Lzy上传的字典%@",dict);
        __weak typeof(self)weakSelf = self;
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_ProductList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"-responseObject---%@",responseObject);
            weakSelf.isLoading = NO;

            int codeStr = [responseObject[@"code"]intValue];
            if (codeStr == 200) {
                if (weakSelf.page == 1) {
                    [weakSelf.dataSourceArray removeAllObjects];
                }
                
                NSArray *array = (NSArray *)responseObject[@"object"];
                if (array.count== 0) {
                    [self.myTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.dataSourceArray addObjectsFromArray:[XianZhiGongYingModel arrayOfModelsFromDictionaries:array error:nil]];
                }
                [weakSelf.myTableView reloadData];
                [weakSelf.myTableView.mj_header endRefreshing];
                [weakSelf.myTableView.mj_footer endRefreshing];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            weakSelf.isLoading = NO;

            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshing];
            
        }];
    }
    else if (_curSearchType == kSearchType_WantToBuy){
        __weak typeof(self)weakSelf = self;
        //    pageNum：页码（默认1）|pageSize：显示的条数（默认10
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSString *number = [NSString stringWithFormat:@"%d",_page];
        NSString *pageSize = @"15";
        [dict setObject:number forKey:@"pageNum"];
        [dict setObject:pageSize forKey:@"pageSize"];
        [dict setObject:self.searchBar.text forKey:@"riKeyword"];

        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindRequInfoList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"--12222222--%@",responseObject);
            weakSelf.isLoading = NO;

            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshing];
            if (weakSelf.page == 1) {
                
                [weakSelf.dataSourceArray removeAllObjects];
            }
            int codeStr = [responseObject[@"code"]intValue];
            if (codeStr == 200) {
                NSArray *array = (NSArray *)responseObject[@"object"];
                if (array.count == 0) {
                    [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    for (NSDictionary *dic in array) {
                        XianZhiQiuGouModel *model = [XianZhiQiuGouModel analysisWithDic:dic];
                        [weakSelf.dataSourceArray addObject:model];
                    }
                }
            }
            
            [weakSelf.myTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            weakSelf.isLoading = NO;

            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshing];
        }];
    }else{
        self.isLoading = NO;
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }
}



- (void)registerForKeyboardNotifications{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown) name:UIKeyboardDidShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWasShown{
    if (_historyHeight+236>(kScreen_Height-64)) {
        [_searchHistoryView setHeight:kScreen_Height-236-64];
    }
}

-(void)keyboardWillBeHidden{
    if (_historyHeight+236>(kScreen_Height-64)) {
        [_searchHistoryView setHeight:_historyHeight];
    }
}

#pragma mark - UISearchBarDelegate Support

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 缓存数据并且刷新界面
    [self actionSaveSearchCacheAndRefreshView];
//    [CSSearchModel addSearchHistory:searchBar.text];
    [self initSearchHistoryView];
    [self.searchBar resignFirstResponder];
    
    [self initSearchResultsTableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource Support

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_curSearchType==kSearchType_TradeNotice) {
        TradeNoticeTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeNoticeTCell" forIndexPath:indexPath];
        TradeNoticeModel *model = self.dataSourceArray[indexPath.row];
        cell.model = model;
        return cell;
    }else if(_curSearchType==kSearchType_TransactionPreview){
        JiaoYiYuGaoTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionPreviewTCell" forIndexPath:indexPath];
        cell.transactionM = self.dataSourceArray[indexPath.row];
        return cell;
    }else if(_curSearchType==kSearchType_IdleProduct){
        XianZhiGongYingTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdleProductTCell" forIndexPath:indexPath];
        cell.idleModel = self.dataSourceArray[indexPath.row];
        return cell;
    }else if(_curSearchType==kSearchType_WantToBuy){
        XianZhiQiuGouCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WantToBuyCell" forIndexPath:indexPath];
        cell.wantToBuyM = self.dataSourceArray[indexPath.row];
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_curSearchType==kSearchType_TradeNotice) {
        return[TradeNoticeTCell cellHeight];
    }else if(_curSearchType==kSearchType_TransactionPreview){
        return [JiaoYiYuGaoTCell cellHeight];
    }else if(_curSearchType==kSearchType_IdleProduct){
        return [XianZhiGongYingTCell cellHeight];
    }else if(_curSearchType==kSearchType_WantToBuy){
        return [JiaoYiYuGaoTCell cellHeight];
    }else{
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(_curSearchType==kSearchType_WantToBuy) {
        [self goToWantToBuyVC:self.dataSourceArray[indexPath.row]];
    }else if(_curSearchType==kSearchType_TradeNotice){
        [self goToTradeNotice:self.dataSourceArray[indexPath.row]];
    }else if (_curSearchType==kSearchType_TransactionPreview){
        [self goToTransactionPreviewVC:self.dataSourceArray[indexPath.row]];
    }else if (_curSearchType==kSearchType_IdleProduct){
        [self goToIdleProductVC:self.dataSourceArray[indexPath.row]];
    }
}



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self setActive:TRUE];
    return TRUE;
}
@end
