//
//  Message_TongzhiViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Message_TongzhiViewController.h"
#import "GongPingGongGaoDetailViewController.h"

@interface Message_TongzhiViewController ()<UITableViewDelegate, UITableViewDataSource>{
    MyPage _page;
}
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)UITableView *myTableView;

@end

@implementation Message_TongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统通知";
    
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
            UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80+kMyPadding*2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    // 设置section背景颜色
    view.tintColor = [UIColor groupTableViewBackgroundColor];
    // 设置section字体颜色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    header.textLabel.textColor = UIColor.grayColor;
    header.textLabel.font = [UIFont systemFontOfSize:13];
    header.textLabel.textAlignment = NSTextAlignmentCenter;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self format:@"2018年9月18日 02时21分30秒"];
    }
    else if (section == 1){
        return [self format:@"2018年9月17日 02时21分30秒"];
    }
    else if (section == 2){
        return [self format:@"2017年5月24日 02时21分30秒"];
    }else{
        return @"2017年5月15日 10：00";
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    //    else{
    //        while ([cell.contentView.subviews lastObject] != nil) {
    //            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    //        }
    //    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"求购名称求购名称求购名称求购名称求购名称";
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    
    cell.detailTextLabel.text = @"您昨天累计收到1张价值10.0元的优惠券赶紧快去看看吧您昨天累计收到1张价值10.0元的优惠券，赶紧快去看看吧！";
    cell.detailTextLabel.numberOfLines = 2;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GongPingGongGaoDetailViewController *vc = [GongPingGongGaoDetailViewController new];
    //ToDo:0123
    vc.tnID = @"8a88888a62bd63730162f0043948000c";
    vc.titleText = @"Lizy";
    
    [self.navigationController pushViewController:vc animated:YES];
}




- (NSString *)format:(NSString *)string{
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
    NSDate*inputDate = [inputFormatter dateFromString:string];
    //NSLog(@"startDate= %@", inputDate);
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //get date str
    NSString *str= [outputFormatter stringFromDate:inputDate];
    //str to nsdate
    NSDate *strDate = [outputFormatter dateFromString:str];
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: strDate];
    NSDate *endDate = [strDate  dateByAddingTimeInterval: interval];
    //NSLog(@"endDate:%@",endDate);
    NSString *lastTime = [self compareDate:endDate];
    NSLog(@"lastTime = %@",lastTime);
    return lastTime;
}

-(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //修正8小时之差
    NSDate *date1 = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    NSDate *localeDate = [date1  dateByAddingTimeInterval: interval];
    
    //NSLog(@"nowdate=%@\nolddate = %@",localeDate,date);
    NSDate *today = localeDate;
    NSDate *yesterday,*beforeOfYesterday;
    //今年
    NSString *toYears;
    
    toYears = [[today description] substringToIndex:4];
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears = [[date description] substringToIndex:4];
    
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        //今 昨 前天的时间
        NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
        //其他时间
        NSString *time2 = [[date description] substringWithRange:(NSRange){5,11}];
        if ([dateString isEqualToString:todayString]){
            dateContent = [NSString stringWithFormat:@"今天 %@",time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            dateContent = [NSString stringWithFormat:@"昨天 %@",time];
            return dateContent;
        }else if ([dateString isEqualToString:beforeOfYesterdayString]){
            dateContent = [NSString stringWithFormat:@"前天 %@",time];
            return dateContent;
        }else{
            return time2;
        }
    }else{
        return dateString;
    }
}








@end
