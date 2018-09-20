//
//  XianZhiQiuGouViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/20.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XianZhiQiuGouViewController.h"
#import "XianZhiQiuGouModel.h"
#import "XianZhiQiuGouCell.h"
#import "XianZhiQIuGouDetailViewController.h"

@interface XianZhiQiuGouViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)UITableView *myTableView;

@end

static NSString * const cellIdentifier = @"cellIdentifier";
@implementation XianZhiQiuGouViewController
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"求购信息"];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
   
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        }else{
            make.edges.mas_equalTo(self.view);
        }
    }];
    
    [self serveData];
  
    __weak typeof(self)weakSelf = self;
    self.page = 1;
    self.myTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf serveData];
    }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf serveData];
    }];
    
}

-(void)serveData{
    __weak typeof(self)weakself = self;
    
    //	pageNum：页码（默认1）|pageSize：显示的条数（默认10
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSString *number = [NSString stringWithFormat:@"%d",_page];
    NSString *pageSize = @"15";
    [dict setObject:number forKey:@"pageNum"];
    [dict setObject:pageSize forKey:@"pageSize"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindRequInfoList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--12222222--%@",responseObject);
        [hud hide:YES];
        [weakself.myTableView.mj_header endRefreshing];
        [weakself.myTableView.mj_footer endRefreshing];
        if (weakself.page == 1) {
            
            [weakself.dataSourceArray removeAllObjects];
        }
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
            NSArray *array = (NSArray *)responseObject[@"object"];
            if (array.count == 0) {
                [weakself.myTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                for (NSDictionary *dic in array) {
                    XianZhiQiuGouModel *model = [XianZhiQiuGouModel analysisWithDic:dic];
                    [weakself.dataSourceArray addObject:model];
                }
            }
        }
        
        [weakself.myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        [weakself.myTableView.mj_header endRefreshing];
        [weakself.myTableView.mj_footer endRefreshing];
    }];
}






#pragma mark - Table view data source
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XianZhiQiuGouCell cellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XianZhiQiuGouCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[XianZhiQiuGouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.wantToBuyM = self.dataSourceArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XianZhiQiuGouModel *model = self.dataSourceArray[indexPath.row];
    XianZhiQIuGouDetailViewController *vc = [[XianZhiQIuGouDetailViewController alloc]init];
    vc.riId = model.riId;
    vc.title = model.riTitle;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
