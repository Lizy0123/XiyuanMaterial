//
//  MyTradeSiteListViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface MyTradeSiteListViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>
@property(nonatomic, assign)kMyTradeSiteStatus myTradeSiteStatus;
@property(strong, nonatomic)UIView *bottomView;
@property(strong, nonatomic)NSMutableArray *tradeSiteListArray;

//-(void)hidBottomView;
@end
