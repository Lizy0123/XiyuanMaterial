//
//  GongPingGongGaoViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "GongPingGongGaoViewController.h"
#import "GongPingGongGaoTCell.h"
#import "GongPingGongGaoDetailViewController.h"

@interface GongPingGongGaoViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@end

@implementation GongPingGongGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.dataSourceArray addObjectsFromArray:MyArray];
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray new];
    }return _dataSourceArray;
}
static NSString *CellIdentifier = @"GongPingGongGaoTCell";
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
            [tableView registerClass:[GongPingGongGaoTCell class] forCellReuseIdentifier:CellIdentifier];
            
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight+60, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
            tableView;
        });
    }return _myTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [GongPingGongGaoTCell cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 3||indexPath.section == 4||indexPath.section == 5) {
    GongPingGongGaoTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[GongPingGongGaoTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.titleLabel.text = @"显示公告文章标题";
    cell.descLabel.text = @"尊敬的用户，为了给您带来更好的体验，秒杀专区业务将于2017年4月26日22：00-2017年4月27日09:00期间进行尊敬的用户，为了给您带来更好的体验，秒杀专区业务将于2017年4月26日22：00-2017年4月27日09:00期间进行...尊敬的用户，为了给您带来更好的体验，秒杀专区业务将于2017年4月26日22：00-2017年4月27日09:00期间进行...";
    cell.timeLabel.text = @"2016-10-22 12:00:00";
    return cell;
//    }else{
//        static NSString * CellIdentifier = @"Cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
//        {
//            while ([cell.contentView.subviews lastObject] != nil) {
//                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//            }
//        }
//        [self configureCell:cell forIndexPath:indexPath];
//        return cell;
//    }
}
#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GongPingGongGaoDetailViewController *vc = [GongPingGongGaoDetailViewController new];
    //ToDo:0123
    vc.tnID = @"8a88888a62bd63730162f0043948000c";
    vc.titleText = @"Lizy";

    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
