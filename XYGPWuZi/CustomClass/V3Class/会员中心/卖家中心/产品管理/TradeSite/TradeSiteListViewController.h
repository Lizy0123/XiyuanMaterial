//
//  TradeSiteListViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/21.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProductListViewController.h"

@interface TradeSiteListViewController : UIViewController

@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)MyProductListViewController *parentVC;

typedef void(^callBack)(NSMutableArray *goodsArr);
@property(copy, nonatomic)callBack block;
@end
