//
//  ProductCategoryViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/11/2.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "ProductCategoryViewController.h"
#import "XMainProductListTableViewController.h"
@interface ProductCategoryViewController ()

@property(nonatomic,strong)UIScrollView *myScrollView;

@end

@implementation ProductCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"产品分类";
    [self configUI];
}
-(void)configUI{
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    _myScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myScrollView];
    [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    for (int i = 0; i < 15; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((S_W-70*3)/6+(i%3)*(70+2*(S_W-70*3)/6), 20+70*(i/3), 70, 57);
        //button.backgroundColor = [UIColor magentaColor];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_main_btn%d",i+1]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chanPinFenLei:) forControlEvents:UIControlEventTouchUpInside];
        [_myScrollView addSubview:button];
        if (i < 10) {
            button.tag = 11207+i;
        }
        if (i>9 && i< 13) {
            button.tag = 11189+i;
        }
        if (i == 13) {
            button.tag = 11237;
        }
        if (i == 14) {
            button.tag = 11221;
        }
    }
}
/*
 -(void)configUI{
 _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
 _myScrollView.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:_myScrollView];
 [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.edges.equalTo(self.view);
 }];
 
 CGFloat btnWidth = (kScreen_Width-kMyPadding*4)/3;
 CGFloat btnHeight = btnWidth-15;
 
 for (int i = 0; i < 15; i++) {
 UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 button.frame = CGRectMake(kMyPadding+(i%3)*(btnWidth+kMyPadding), kMyPadding+(btnHeight +kMyPadding)*(i/3), btnWidth, btnHeight);
 //button.backgroundColor = [UIColor magentaColor];
 [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_main_btn%d",i+1]] forState:UIControlStateNormal];
 [button addTarget:self action:@selector(chanPinFenLei:) forControlEvents:UIControlEventTouchUpInside];
 [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
 
 [_myScrollView addSubview:button];
 if (i < 10) {
 button.tag = 11207+i;
 }
 if (i>9 && i< 13) {
 button.tag = 11189+i;
 }
 if (i == 13) {
 button.tag = 11237;
 }
 if (i == 14) {
 button.tag = 11221;
 }
 }
 }

 */


#pragma mark 跳转产品列表页
-(void)chanPinFenLei:(UIButton *)btn{
    NSLog(@"-------%ld",(long)btn.tag);
    XMainProductListTableViewController *VC = [[XMainProductListTableViewController alloc]init];
    VC.acode = [NSString stringWithFormat:@"%d",btn.tag];
    if (btn.tag == 11237) {
        
        VC.level = @"3";
    }else{
        VC.level = @"2";
    }
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
