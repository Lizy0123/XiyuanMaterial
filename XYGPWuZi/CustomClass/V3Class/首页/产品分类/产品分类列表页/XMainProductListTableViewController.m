//
//  XMainProductListTableViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XMainProductListTableViewController.h"
#import "X_MProductTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

//筛选界面
#import "X_ShaiXuanTableViewController.h"
//详情页
#import "ProductDetailViewController.h"


@interface XMainProductListTableViewController ()<shaiXuanDelegate>
//数据数组
@property(nonatomic,strong)NSMutableArray *dataArray;
//列表页码
@property(nonatomic,assign)int page;
//是否回传code
@property(nonatomic,copy)NSString *PostbackCode;

@end

@implementation XMainProductListTableViewController

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"产品列表";
    self.PostbackCode = nil;
    self.page = 1;
    UIBarButtonItem *rightLoginBtn = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(shaixuan)];
    
    self.navigationItem.rightBarButtonItem = rightLoginBtn;
     [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    //加载数据
    [self requestDataWithCocd:self.acode andLevel:self.level];
    
    self.tableView.rowHeight = 90;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.tableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self clearExtraLine:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    X_MProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[X_MProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
      
    }
    ProductDetailModel *modle = self.dataArray[indexPath.row];
    cell.model = modle;

   
    return cell;
}
#pragma mark - tableView点击事件,跳转到产品详情页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductDetailModel *model = self.dataArray[indexPath.row];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    vc.piId = model.piId;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 筛选
-(void)shaixuan{
    
    X_ShaiXuanTableViewController *VC = [[X_ShaiXuanTableViewController alloc]init];
    VC.shaiXuandelegate = self;
    VC.code = self.acode;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark 去掉多余的线
-(void)clearExtraLine:(UITableView *)tableView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
#pragma mark shaiXuanDelegate
-(void)postBackController:(X_ShaiXuanTableViewController *)shaixuanController postBackCode:(NSString *)acode
{
    self.PostbackCode = acode;
    NSLog(@"数据传回来了.....%@",acode);
    [self.dataArray removeAllObjects];
    [self refreshData];
}

#pragma mark 请求数据
-(void)requestDataWithCocd:(NSString *)acode andLevel:(NSString *)level{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.page];
    NSString *pageSize = @"10";
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:level forKey:@"level"];
    [dict setObject:acode forKey:@"code"];
    [dict setObject:pageNum forKey:@"pageNum"];
    [dict setObject:pageSize forKey:@"pageSize"];
    
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_ProductList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [hud hide:YES];
        
        NSLog(@"---respon--%@",responseObject);
        
        
        if (weakSelf.page ==1) {
            
            [weakSelf.dataArray removeAllObjects];
            
        }
        
        
        for (NSDictionary *dict in (NSArray*)responseObject[@"object"]) {
            
            ProductDetailModel *model = [[ProductDetailModel alloc]init];
            model.picUrl = dict[@"picUrl"];
            model.piAddress = dict[@"piAddress"];
            model.piModtime = dict[@"piModtime"];
            model.piName = dict[@"piName"];
            model.piId = dict[@"piId"];
            [weakSelf.dataArray addObject:model];
            
        }
        /*
         *在Main Dispatch Queue中执行Block
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /*
             *只能在主线程中执行的处理
             */
            NSLog(@" 当前线程  %@",[NSThread currentThread]);
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView.mj_header endRefreshing];
        });
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
 
}
#pragma mark 下拉刷新
-(void)refreshData{
    
    self.page = 1;
    
    if (self.PostbackCode == nil) {
        
        [self requestDataWithCocd:self.acode andLevel:self.level];
        
    }
    else{
        [self requestDataWithCocd:self.PostbackCode andLevel:@"3"];
        
    }
    
}
#pragma mark 上拉加载
-(void)loadMoreData{
    
    self.page ++;
    
    NSLog(@"---------%@",self.PostbackCode);
    if (self.PostbackCode == nil) {
        
        [self requestDataWithCocd:self.acode andLevel:self.level];
        
    }
    else{
        [self requestDataWithCocd:self.PostbackCode andLevel:@"3"];
        
    }
    
    
}

@end
