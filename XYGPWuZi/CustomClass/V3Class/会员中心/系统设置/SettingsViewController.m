//
//  SettingsViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/8/10.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "SettingsViewController.h"
#import "XRChangeMiMaViewController.h"
#import "XRChangePhoneFirstViewController.h"
#import "AboutUsViewController.h"
#import "JoinUsViewController.h"


@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(strong, nonatomic)UIButton *bottomBtn;
@property(nonatomic,strong)UIView *bottomView;


@end

@implementation SettingsViewController
-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = ({
            CGFloat btnHeight = 44;
            CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];;
            [btn setSize:CGSizeMake(btnWidth, btnHeight)];
            [btn setTitle:@"退出登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
            [btn setCornerRadius:btnHeight/2];
            [btn setBackgroundColor:kColorMain];
            [btn setBackgroundImage:[UIImage imageWithColor:UIColor.groupTableViewBackgroundColor] forState:UIControlStateDisabled];
            [btn setBackgroundImage:[UIImage imageWithColor:kColorMain] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(actionBottomBtn) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }return _bottomBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSLog(@"---%@",self.phoneNumber);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        }else{
            make.edges.mas_equalTo(self.view);
        }
    }];
    
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
    self.myTableView.tableFooterView = footerV;
    [footerV addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 32, 44));
        make.top.equalTo(footerV.mas_top).offset(30);
        make.centerX.equalTo(footerV);
    }];
}
-(void)actionBottomBtn{
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    [parm setObject:[UserManager readUserInfo].token forKey:@"token"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindLoginOut] parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"----注销返回的数据--%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            [UserManager clearUserInfo];
            hud.labelText = @"注销成功";
            [hud hide:YES afterDelay:0.7];
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault removeObjectForKey:KEY_USER_picurl];
            [userDefault synchronize];
            [NSObject archiverWithSomeThing:[NSMutableArray new] someName:kTradeSiteCache];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [hud hide:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
    }];
    
    /*200：退出成功！ | 500：退出异常！ | 1315：退出异常！
     数据说明:    {"code":200,"message":"","params":"","url":"","success":true}
     code：200 退出成功*/
}
#pragma mark - TableView
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([[UserManager readUserInfo].facUserType isEqualToString:@"0"]) {
            return 3;
        }else{
            return 2;
        }
    }else{
        return 3;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"修改密码";
            cell.detailTextLabel.text = @"";
            cell.detailTextLabel.textColor = UIColor.grayColor;

        }else if (indexPath.row == 1){
            if ([[UserManager readUserInfo].facUserType isEqualToString:@"0"]) {
                cell.textLabel.text = @"业务操作认证手机";
                cell.detailTextLabel.text = @"ToDo:0123";
                cell.detailTextLabel.textColor = UIColor.grayColor;
            }else{
                cell.textLabel.text = @"修改手机号";
                cell.detailTextLabel.text = @"ToDo:0123";
                cell.detailTextLabel.textColor = UIColor.grayColor;
            }
        }else{
            cell.textLabel.text = @"财务操作认证手机";
            cell.detailTextLabel.text = @"ToDo:0123";
            cell.detailTextLabel.textColor = UIColor.grayColor;
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"关于我们";
            cell.detailTextLabel.text = @"";
            cell.detailTextLabel.textColor = UIColor.grayColor;
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"好评";
            cell.detailTextLabel.text = @"";
            cell.detailTextLabel.textColor = UIColor.grayColor;
        }else{
            cell.textLabel.text = @"加入我们";
            cell.detailTextLabel.text = @"";
            cell.detailTextLabel.textColor = UIColor.grayColor;
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"修改密码");
            XRChangeMiMaViewController *vc = [[XRChangeMiMaViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            if ([[UserManager readUserInfo].facUserType isEqualToString:@"0"]) {
                
            }else{
                NSLog(@"修改手机号");
                XRChangePhoneFirstViewController *vc = [[XRChangePhoneFirstViewController alloc]init];
                vc.oldPhoneNumber = self.phoneNumber;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            
        }
    }else{
        if (indexPath.row == 0) {
            NSLog(@"关于app");
            AboutUsViewController *vc = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            //获取app名字
            NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"去给'%@'打分！",appName]message:@"您的评价对我们很重要"preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *url =
                @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1276467928";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"稍后"style:UIAlertActionStyleCancel handler:^(UIAlertAction* _Nonnull action) {
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            JoinUsViewController *vc = [[JoinUsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
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
