//
//  XRMyProductViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MyProductViewController : BaseViewController
@property(strong, nonatomic)ZJScrollPageView *scrollPageView;
@property(assign, nonatomic)NSInteger selectedPage;
@end
