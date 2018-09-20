//
//  HuiYuanZhongXinViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/5.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "HuiYuanZhongXinViewController.h"
#import "UIImageView+WebCache.h"

#import "LoginViewController.h"
#import "MyLoginViewController.h"

#import "XRRegistViewController.h"
#import "MessageCenterTableViewController.h"
#import "MyProductViewController.h"
#import "DanChangGuanLiViewController.h"
#import "AddProductViewController.h"

//#import "XRJingJialistViewController.h"
#import "YongHuXinXiViewController.h"
#import "SettingsViewController.h"
#import "DanChangJingJiaViewController.h"

#import "OpenAccountViewController.h"
#import "MoneyManageViewController.h"

#define kBtnSelectColor  [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255/255.0 alpha:1]
#define kIconHeight (kDevice_iPhoneX ? 70 : 20)
#define kIconSpace (kDevice_iPhoneX ? 40 : 80)
#define kIconSizeHeight (kDevice_iPhoneX||kDevice_iPhone6Plus ? 100:kDevice_iPhone6 ? 90:88)

#define kBtnHeight 60

#import "JiTuanZhuanChangDetailViewController.h"
#import "PayForProductViewController.h"
#import "ConfirmAgreementViewController.h"
#import "MessageCenterTableViewController.h"

@interface HuiYuanZhongXinViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate, UIScrollViewDelegate>
@property(strong, nonatomic)UIButton *leftBtn,/*买家中心按钮*/ *rightBtn/*卖家中心按钮*/;
//@property(strong, nonatomic)UIScrollView *scrollView;//横滚scroll
@property(strong, nonatomic)UILabel *scrollLabel,/*滚动指示条label*/ *titleLabel;//名字
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)UIImageView *headIcon,/*头像*/ *rightImg/*头像右侧箭头*/;
@property(strong, nonatomic)UIView *myTableHeaderView;//头部视
@property(strong, nonatomic)UIImageView *scaleImgView;//可以缩放的背景图
@property(nonatomic,assign)float scaleImgHeight;
@property(nonatomic,assign)float scaleImgWidth;
@property(nonatomic,assign)float scaleImgOrgy;

@end

@implementation HuiYuanZhongXinViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"会员中心";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:UIColor.clearColor forKey:NSForegroundColorAttributeName];
    
    
    /*设置导航栏背景图片为一个空的image，这样就透明了*/
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.view addSubview:self.scaleImgView];
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        }else{
            make.edges.mas_equalTo(self.view);
        }
    }];
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.myTableView.tableHeaderView = self.myTableHeaderView;
    [self configSellerCenter];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"sheZhi"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionBarBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundColor:UIColor.clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    self.navigationController.navigationBar.tintColor = UIColor.clearColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColor.clearColor}];
    
    if ([kStringToken length]) {
        [self.rightImg setHidden:NO];
        self.titleLabel.text = [UserManager readUserInfo].caseName;
        if ([UserManager readUserInfo].facHeadPic!=nil) {
            [self.headIcon sd_setImageWithURL:[NSURL URLWithString:[myCDNUrl stringByAppendingString:[UserManager readUserInfo].facHeadPic]] placeholderImage:[UIImage imageNamed:@"icon_Portrait"]];
        }else{
            [self.headIcon setImage:[UIImage imageNamed:@"icon_Portrait"]];
        }
    }else{
        [self.rightImg setHidden:YES];
        _titleLabel.text = @"欢迎来到工平物资!";
        _headIcon.image = [UIImage imageNamed:@"icon_Portrait"];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.tintColor = UIColor.clearColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColor.clearColor}];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorNav] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 设置导航栏标题和返回按钮颜色
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColor.whiteColor}];
}

#pragma mark - 背后会缩放的图片
-(UIImageView *)scaleImgView{
    if (!_scaleImgView) {
        _scaleImgView=[[UIImageView alloc]init];
        _scaleImgView.frame=CGRectMake(0, _scaleImgOrgy = -100, _scaleImgWidth = kScreen_Width, _scaleImgHeight = 300);
        _scaleImgView.backgroundColor=[UIColor clearColor];
        _scaleImgView.image = [UIImage imageNamed:@"MyImage"];
        _scaleImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_scaleImgView setImage:[UIImage imageNamed:@"backgroundImage"]];

    }return _scaleImgView;
}
//delegate_scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
#define oriHeight 200
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat imgH = oriHeight - offset;
    if (imgH < 64) {
        imgH = 64;
    }
//Image根据透明度来生成图片
    CGFloat alpha = offset * 1 / 136.0; /*找最大值// (200 - 64) / 136.0f*/
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    /*拿到标题 标题文字的随着移动高度的变化而变化*/
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:alpha]}];
    
    /*把颜色生成图片*/
    UIColor *alphaColor = [UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:alpha];
    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
    /*修改导航条背景图片*/
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    
//TitleView
    if (offset<0) {
        self.navigationItem.title = @"会员中心";
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:UIColor.clearColor}];
        self.navigationItem.rightBarButtonItem.tintColor = UIColor.clearColor;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];/*状态栏字体黑色*/
    }
    else if (offset<=oriHeight) {
        self.navigationItem.title = @"会员中心";
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:UIColor.clearColor}];
        self.navigationItem.rightBarButtonItem.tintColor = UIColor.clearColor;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];/*状态栏字体黑色*/
    }else{
        self.navigationItem.title = @"欢迎来到工平物资";
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:UIColor.whiteColor}];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];/*隐藏黑线*/
        self.navigationItem.rightBarButtonItem.tintColor = UIColor.blackColor;
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;/*状态栏字体白色*/
    }
//ScalImg
    if (offset<0) {
        CGFloat aaa = (_scaleImgHeight-offset)/_scaleImgHeight<1?1:(_scaleImgHeight-offset)/_scaleImgHeight;
        CGRect rect = self.scaleImgView.frame;
        rect.size.height = _scaleImgHeight-offset;
        rect.size.width = _scaleImgWidth* aaa;
        rect.origin.x =  -(rect.size.width-_scaleImgWidth)/2;
        rect.origin.y = _scaleImgOrgy;
        self.scaleImgView.frame = rect;
    }else{
        CGFloat aaa = (_scaleImgHeight-offset)/_scaleImgHeight<1?1:(_scaleImgHeight-offset)/_scaleImgHeight;
        CGRect rect = self.scaleImgView.frame;
        rect.size.height = _scaleImgHeight-offset;
        rect.size.width = _scaleImgWidth* aaa;
        rect.origin.x =  -(rect.size.width-_scaleImgWidth)/2;
        rect.origin.y = _scaleImgOrgy;
        self.scaleImgView.frame = rect;
    }
}
#pragma mark - UI
-(void)configSellerCenter{
    UIView *btnBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kIconSpace + kIconSizeHeight + kIconHeight -10, kScreen_Width, 10+kBtnHeight*2)];
    btnBackView.backgroundColor = [UIColor whiteColor];
    //头像和买买家中心背景分割灰色条
    UIView *grayBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    grayBottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [btnBackView addSubview:grayBottomView];
    //买卖家中心分割线
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 10+kBtnHeight, kScreen_Width, 1)];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [btnBackView addSubview:line2];
    
#pragma mark 卖家中心
    UIButton *squareFirstBtnTop = [UIButton buttonWithType:UIButtonTypeCustom];
    squareFirstBtnTop.frame = CGRectMake(0, 10, kScreen_Width/4, kBtnHeight);
    squareFirstBtnTop.backgroundColor = [UIColor whiteColor];
    [squareFirstBtnTop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [squareFirstBtnTop.titleLabel setFont:[UIFont systemFontOfSize:kTitleFontSize]];
    [squareFirstBtnTop setImage:[UIImage imageNamed:@"ic_my_product"] forState:UIControlStateNormal];
    [squareFirstBtnTop setTitle:@"卖家中心" forState:UIControlStateNormal];
//    [squareFirstBtnTop addTarget:self action:@selector(goToMyProduct) forControlEvents:UIControlEventTouchUpInside];
    [squareFirstBtnTop layoutButtonWithEdgeInsetsStyle:kbtnEdgeInsetsStyleTop imageTitleSpace:kMyPadding];
    [btnBackView addSubview:squareFirstBtnTop];
    
    UIImageView *seprateImgTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"memberCenter_seprateImg"]];
    [btnBackView addSubview:seprateImgTop];
    [seprateImgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(squareFirstBtnTop);
        make.top.equalTo(squareFirstBtnTop).offset(5);
        make.bottom.equalTo(squareFirstBtnTop).offset(-5);
        make.width.mas_equalTo(10);
    }];

    for (int i = 0; i<3; i++) {
        UIButton *scrollRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        scrollRightBtn.frame = CGRectMake(kScreen_Width/4+i*kScreen_Width/4, 10, kScreen_Width/4, kBtnHeight);
        [scrollRightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [scrollRightBtn.titleLabel setFont:[UIFont systemFontOfSize:kTitleFontSize]];
        [scrollRightBtn addTarget:self action:@selector(goToMyProduct:) forControlEvents:UIControlEventTouchUpInside];
        scrollRightBtn.tag = i;
        [btnBackView addSubview:scrollRightBtn];
        switch (scrollRightBtn.tag) {
            case 0:{
                [scrollRightBtn setImage:[UIImage imageNamed:@"ic_add_product"] forState:UIControlStateNormal];
                [scrollRightBtn setTitle:@"产品管理" forState:UIControlStateNormal];
            }
                break;
            case 1:{
                [scrollRightBtn setImage:[UIImage imageNamed:@"ic_wait_audit"] forState:UIControlStateNormal];
                [scrollRightBtn setTitle:@"单场管理" forState:UIControlStateNormal];
            }
                break;
            case 2:{
                [scrollRightBtn setImage:[UIImage imageNamed:@"ic_audit_success"] forState:UIControlStateNormal];
                [scrollRightBtn setTitle:@"专场管理" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
        [scrollRightBtn layoutButtonWithEdgeInsetsStyle:kbtnEdgeInsetsStyleTop imageTitleSpace:kMyPadding];
    }

#pragma mark 买家中心
    UIButton *squareFirstBtnBottom = [UIButton buttonWithType:UIButtonTypeCustom];
    squareFirstBtnBottom.frame = CGRectMake(0, 10+kBtnHeight, kScreen_Width/4, kBtnHeight);
    [squareFirstBtnBottom setImage:[UIImage imageNamed:@"ic_my_trade_site"] forState:UIControlStateNormal];
    [squareFirstBtnBottom setTitle:@"买家中心" forState:UIControlStateNormal];
    [squareFirstBtnBottom setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [squareFirstBtnBottom.titleLabel setFont:[UIFont systemFontOfSize:kTitleFontSize]];
    [squareFirstBtnBottom layoutButtonWithEdgeInsetsStyle:kbtnEdgeInsetsStyleTop imageTitleSpace:kMyPadding];
//    [squareFirstBtnBottom addTarget:self action:@selector(goToMyTradeSite) forControlEvents:UIControlEventTouchUpInside];
    [btnBackView addSubview:squareFirstBtnBottom];
    UIImageView *seprateImgBottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"memberCenter_seprateImg"]];
    [btnBackView addSubview:seprateImgBottom];
    [seprateImgBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(squareFirstBtnBottom);
        make.top.equalTo(squareFirstBtnBottom).offset(5);
        make.bottom.equalTo(squareFirstBtnBottom).offset(-5);
        make.width.mas_equalTo(10);
    }];
    
    for (int i = 0; i<2; i++) {
        UIButton *scrollRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        scrollRightBtn.frame = CGRectMake(kScreen_Width/4+i*kScreen_Width/4, 10+kBtnHeight, kScreen_Width/4, kBtnHeight);
        [scrollRightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [scrollRightBtn.titleLabel setFont:[UIFont systemFontOfSize:kTitleFontSize]];
        [scrollRightBtn addTarget:self action:@selector(goToMyTradeSite:) forControlEvents:UIControlEventTouchUpInside];
        scrollRightBtn.tag = i;
        [btnBackView addSubview:scrollRightBtn];
        switch (scrollRightBtn.tag) {
            case 0:{
                [scrollRightBtn setImage:[UIImage imageNamed:@"ic_have_public"] forState:UIControlStateNormal];
                [scrollRightBtn setTitle:@"单场竞价" forState:UIControlStateNormal];
            }
                break;
            case 1:{
                [scrollRightBtn setImage:[UIImage imageNamed:@"ic_bidding_now"] forState:UIControlStateNormal];
                [scrollRightBtn setTitle:@"专场竞价" forState:UIControlStateNormal];
            }
                break;
            case 2:{
                [scrollRightBtn setImage:[UIImage imageNamed:@"ic_wait_recivemoney"] forState:UIControlStateNormal];
                [scrollRightBtn setTitle:@"待收款" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
        [scrollRightBtn layoutButtonWithEdgeInsetsStyle:kbtnEdgeInsetsStyleTop imageTitleSpace:kMyPadding];
    }
    [self.myTableHeaderView addSubview:btnBackView];
}


#pragma mark - Action
-(void)actionBarBtn{
    [self actionGoToSetting];
}
-(void)actionChangePortairt:(UITapGestureRecognizer *)gesture{
    if ([kStringToken length]) {
        UserModel *entityMember = [UserManager readUserInfo];
        YongHuXinXiViewController *vc = [[YongHuXinXiViewController alloc]init];
        if ([entityMember.facUserType isEqualToString:@"0"]) {
            vc.zhangHaoTypeStr = @"企业账号";
        }else{
            vc.zhangHaoTypeStr = @"个人账号";
        }
        vc.zhangHaoStr = entityMember.loginName;
        vc.compunyStr = @"";
        vc.shouQuanRenStr = entityMember.caseName;
        vc.phoneStr = entityMember.mobil;
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *picurl = [userDefault objectForKey:KEY_USER_picurl];
        [userDefault synchronize];
        if (picurl) {
            NSLog(@"本地有图片");
            vc.pictureUrl = picurl;
        }else{
            NSLog(@"本地没有图片");
            if (entityMember.facHeadPic == nil) {
                NSLog(@"用户没有头像");
                vc.pictureUrl = nil;
            }else{
                NSLog(@"用户有头像");
                NSString *picurl2 = [myCDNUrl stringByAppendingString:entityMember.facHeadPic];
                vc.pictureUrl = picurl2;
            }
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        [self actionGoToLogin];
    }
}
//卖家中心右边三个按钮
-(void)goToMyProduct:(UIButton *)btn{
    if ([kStringToken length]) {
        if (btn.tag == 0) {
            MyProductViewController *vc = [MyProductViewController new];
            vc.selectedPage = 0;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (btn.tag == 1){
            DanChangGuanLiViewController *vc = [DanChangGuanLiViewController new];
            [vc.scrollPageView setSelectedIndex:0 animated:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (btn.tag == 2){
            NSLog(@"专场管理");
        }
    }
    else{
        [self actionGoToLogin];
    }
}
//买家中心右边三个按钮
-(void)goToMyTradeSite:(UIButton *)btn{
    if ([kStringToken length]) {
        if (btn.tag == 0) {
            DanChangJingJiaViewController *vc = [[DanChangJingJiaViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (btn.tag == 1){
            NSLog(@"专场竞价");
        }
        else if (btn.tag == 2){
            DanChangGuanLiViewController *vc = [DanChangGuanLiViewController new];
            vc.selectedPage = 3;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else{
        [self actionGoToLogin];
    }
}
-(void)actionGoToSetting{
    if ([kStringToken length]) {
        SettingsViewController *vc = [[SettingsViewController alloc]init];
        vc.phoneNumber = [UserManager readUserInfo].mobil;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self actionGoToLogin];
    }
}
-(void)actionGoToLogin{
    //#pragma mark  登录
    [self presentViewController:[[BaseMyNavigationController alloc] initWithRootViewController:[[MyLoginViewController alloc]init]] animated:YES completion:^{}];
}
-(void)actionGoToRegist{
//#pragma mark 注册
    [self.navigationController pushViewController:[[XRRegistViewController alloc]init] animated:YES];
}

#pragma mark - TableView
-(UIImageView *)headIcon{
    if (!_headIcon) {
        _headIcon = ({
            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(kMyPadding*2, kIconSpace/2 +kIconHeight, kIconSizeHeight, kIconSizeHeight)];
            icon.clipsToBounds = YES;
            icon.layer.cornerRadius = kIconSizeHeight/2;
            icon.userInteractionEnabled = YES;
            [icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionChangePortairt:)]];
            icon.image = [UIImage imageNamed:@"icon_Portrait"];

            icon;
        });
    }return _headIcon;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headIcon.frame)+kMyPadding, CGRectGetMinY(self.headIcon.frame)+kIconSizeHeight/2-40, S_W-150, 40)];
            titleLabel.text = @"欢迎来到工平物资！";
            titleLabel.font = [UIFont boldSystemFontOfSize:kTitleFontSizeLarger];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel;
        });
    }return _titleLabel;
}
-(UIView *)myTableHeaderView{
    if (!_myTableHeaderView) {
        _myTableHeaderView = ({
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kBtnHeight *2/*两行按钮*/ + kIconSpace + kIconSizeHeight + kIconHeight)];;
            headView.backgroundColor = UIColor.clearColor;
            //触摸进入用户信息页面
            UIView *touchView = [[UIView alloc] initWithFrame:(CGRect){0,kIconSpace/2 +kIconHeight,kScreen_Width,kIconSizeHeight}];
            touchView.backgroundColor = UIColor.clearColor;
            [touchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionChangePortairt:)]];
            touchView.userInteractionEnabled = YES;
            [headView addSubview:touchView];
            
            //头像[UserManager readUserInfo].facHeadPic
            [headView addSubview:self.headIcon];
            UserModel *memberInfo = [UserManager readUserInfo];
            if (memberInfo.facHeadPic != nil) {
                [self.headIcon sd_setImageWithURL:[NSURL URLWithString:[myCDNUrl stringByAppendingString:memberInfo.facHeadPic]] placeholderImage:[UIImage imageNamed:@"icon_Portrait"]];
            }
            UIImageView *righImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_right"]];
            [headView addSubview:righImg];
            [righImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(headView.mas_right).offset(-kMyPadding);
                make.centerY.mas_equalTo(self.headIcon.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(10, 20));
            }];
            self.rightImg = righImg;
            

            //名字
            [headView addSubview:self.titleLabel];
            if ([kStringToken length]) {
                self.titleLabel.text = memberInfo.caseName;
            }
            
            headView;
        });
    }
    return _myTableHeaderView;
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    else{
        return 3;
    }
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"开户申请";
            cell.detailTextLabel.text = @"会员升级";
            cell.detailTextLabel.textColor = UIColor.lightGrayColor;
            cell.imageView.image = [UIImage imageNamed:@"kaihushenqing"];
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"资金管理";
            cell.imageView.image = [UIImage imageNamed:@"zijinguanli"];
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"客服热线";
            cell.imageView.image = [UIImage imageNamed:@"kefuCenter"];
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"消息中心";
            cell.imageView.image = [UIImage imageNamed:@"sheZhi"];
        }else{
            cell.textLabel.text = @"系统设置";
            cell.imageView.image = [UIImage imageNamed:@"sheZhi"];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([kStringToken length]) {
                OpenAccountViewController *vc = [[OpenAccountViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self actionGoToLogin];
            }
        }else if (indexPath.row == 1){
            if ([kStringToken length]) {
                MoneyManageViewController *vc = [[MoneyManageViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self actionGoToLogin];
            }
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"03153859900"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
        else if (indexPath.row == 1){
            if ([kStringToken length]) {
                MessageCenterTableViewController *vc = [[MessageCenterTableViewController alloc]init];
//                vc.phoneNumber = [UserManager readUserInfo].mobil;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self actionGoToLogin];
            }
        }
        else if (indexPath.row == 2){
            [self actionGoToSetting];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
