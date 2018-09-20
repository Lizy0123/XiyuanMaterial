//
//  SecondViewController.m
//  地址选择器
//
//  Created by admin on 16/6/15.
//  Copyright © 2016年 sigxui-001. All rights reserved.
//

#import "SecondViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CitiesView.h"
@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *provinces;
    NSDictionary *wholeAera;
}
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation SecondViewController


- (UITableView *)tableView {
    self.title = @"选择地区";
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = 1;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.rowHeight = 40;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    wholeAera = [[NSDictionary alloc]init];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.title = @"填写收货地址";
    //self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor],UITextAttributeFont:[UIFont systemFontOfSize:18]};
    //加载数据
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    //[self.tabBarController.tabBar setHidden:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return provinces.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    // NSLog(@"%@",provinces);
    cell.textLabel.text = provinces[indexPath.row][@"state"];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CitiesView *city = [[CitiesView alloc]init];
    [city getCities:provinces[indexPath.row][@"cities"]];
    
    
    city.blockCity = ^(NSDictionary *area){
        if (area.count == 2) {
            wholeAera = @{
                          @"area":area[@"area"],
                          @"city":area[@"city"],
                          @"province":provinces[indexPath.row][@"state"]
                          };
        }
        else if(area.count == 1){
            wholeAera = @{
                          @"city":area[@"city"],
                          @"province":provinces[indexPath.row][@"state"]
                          };
        }
        
        [NSString stringWithFormat:@"%@ %@",provinces[indexPath.row][@"state"],area];
        NSLog(@"%@",wholeAera);
        self.blockAddress((NSDictionary *)wholeAera);
        [self.navigationController popViewControllerAnimated:NO];
    };
    [self.view addSubview:city];
}
@end
