//
//  JoinUsViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/19.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "JoinUsViewController.h"

@interface JoinUsViewController ()

@end

@implementation JoinUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请加入";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((S_W-240)/2, 40, 240, 312)];
    image.image = [UIImage imageNamed:@"welcomeToJoinUs"];
//    image.clipsToBounds = YES;
//    image.layer.cornerRadius =  15;
    [self.view addSubview:image];

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
