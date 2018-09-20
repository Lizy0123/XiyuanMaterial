//
//  AboutUsViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/18.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UITableView *myTableView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    {
        UIView *headerView = [[UIView alloc] initWithFrame:(CGRect){0,0,kScreen_Width,250}];
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"aboutUs"];
        image.clipsToBounds = YES;
        image.layer.cornerRadius =  15;
        [headerView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width/5,kScreen_Width/5});
            make.centerX.equalTo(headerView);
            make.top.equalTo(headerView).offset(50);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = @"工平闲置物资App\n一站式解决\n矿山闲置物资管理及处理问题";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:15];
        label1.textColor = [UIColor blackColor];
        label1.numberOfLines = 0;
        [headerView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width,80});
            make.centerX.equalTo(headerView);
            make.top.mas_equalTo(image.mas_bottom).offset(10);
        }];
        self.myTableView.tableHeaderView = headerView;
    }

    {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"CopyRight @ 工平物资 2013 - 2018";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = UIColor.grayColor;
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width,30});
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kSafeBottomOffset);
        }];
    }
}

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
            //设置cell下划线从最左边开始
            //            if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            //                [tableView setSeparatorInset:UIEdgeInsetsZero];
            //            }
            //            if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            //                [tableView setLayoutMargins:UIEdgeInsetsZero];
            //            }
            
            //            tableView.tableHeaderView = [self tableHeader];
            //            tableView.tableFooterView = [self tableFooterView];
            //        [tableView registerClass:[CountryCodeCell class] forCellReuseIdentifier:kCellIdentifier_CountryCodeCell];
            
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight+60, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
            tableView;
        });
    }return _myTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:kValueFontSize];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"客服热线";
        cell.detailTextLabel.text = @"0315-3859900";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if (indexPath.row == 1){
        cell.textLabel.text = @"客服邮箱";
        cell.detailTextLabel.text = @"m18703151008@163.com";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if (indexPath.row == 2){
        cell.textLabel.text = @"当前版本";
        cell.detailTextLabel.text = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"0315-3859900"]]];
    }
    else if (indexPath.row == 1){
        [NSObject ToastShowStr:@"复制成功!"];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"m18703151008@163.com";
    }
    else if (indexPath.row == 2){
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    // 设置section背景颜色
    view.tintColor = [UIColor groupTableViewBackgroundColor];
    
    // 设置section字体颜色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = UIColor.grayColor;
    header.textLabel.font = [UIFont systemFontOfSize:13];
}

@end
