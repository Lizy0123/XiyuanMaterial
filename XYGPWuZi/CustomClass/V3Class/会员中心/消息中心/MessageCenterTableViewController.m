//
//  MessageCenterTableViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/19.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "MessageCenterTableViewController.h"
#import "Message_QiugouViewController.h"
#import "Message_LiuyanViewController.h"
#import "Message_TongzhiViewController.h"

@interface MessageCenterTableViewController ()<UITableViewDelegate, UITableViewDataSource>{
    MyPage _page;
}
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation MessageCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息中心";
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - Table view data source
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@" ",@" ",@" ", nil];
    }return _dataArray;
}
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else{
        return self.dataSourceArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageWithColor:UIColor.redColor withFrame:(CGRect){0,0,50,50}];
            cell.textLabel.text = @"我的求购";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.dataArray objectAtIndex:0]];
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageWithColor:UIColor.redColor withFrame:(CGRect){0,0,50,50}];
            cell.textLabel.text = @"我的留言";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.dataArray objectAtIndex:1]];
        }else{
            cell.imageView.image = [UIImage imageWithColor:UIColor.redColor withFrame:(CGRect){0,0,50,50}];
            cell.textLabel.text = @"系统通知";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.dataArray objectAtIndex:2]];
        }
    }else{
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[Message_QiugouViewController new] animated:YES];
        }else if (indexPath.row == 1){
            Message_LiuyanViewController *vc = [Message_LiuyanViewController new];
            vc.isManage = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self.navigationController pushViewController:[Message_TongzhiViewController new] animated:YES];
        }
    }else{
        
    }
}
-(void)requestData{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    
    __weak typeof(self)wealSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_MessageCenterIndexCount] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"---%@",responseObject);
        NSDictionary *dic = (NSDictionary*)responseObject[@"object"];
        NSString *lmCount = dic[@"lmCount"];
        NSString *mnCount = dic[@"mnCount"];
        NSString *riCount = dic[@"riCount"];
        
        [wealSelf.dataArray replaceObjectAtIndex:0 withObject:lmCount];
        [wealSelf.dataArray replaceObjectAtIndex:1 withObject:mnCount];
        [wealSelf.dataArray replaceObjectAtIndex:2 withObject:riCount];
        
        [wealSelf.myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
