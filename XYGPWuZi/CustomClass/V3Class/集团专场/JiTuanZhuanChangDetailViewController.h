//
//  JiTuanZhuanChangDetailViewController.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/3/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageView.h"

@interface JiTuanZhuanChangDetailViewController : BaseViewController
@property(strong, nonatomic)ZJScrollPageView *scrollPageView;
@property(assign, nonatomic)NSInteger selectedPage;
@end
