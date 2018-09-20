//
//  XRProductStatusTableViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/30.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRProductStatusTableViewController.h"

@interface XRProductStatusTableViewController ()

@property(nonatomic,strong)NSArray *statusArray;

@end

@implementation XRProductStatusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"当前状态";
    self.statusArray = @[@"正常使用",@"故障",@"报废",@"其他"];
    
    self.tableView.rowHeight = 40;
    [self clearExtraLine:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = _statusArray[indexPath.row];
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_statusBlock) {
        NSString *str = self.statusArray[indexPath.row];
        self.statusBlock(str,indexPath.row);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}
#pragma mark 去掉多余的线
-(void)clearExtraLine:(UITableView *)tableView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

@end
