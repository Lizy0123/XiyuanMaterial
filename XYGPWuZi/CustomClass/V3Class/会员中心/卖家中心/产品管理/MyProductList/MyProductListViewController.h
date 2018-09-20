//
//  MyProductListViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface MyProductListViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>
@property(nonatomic, assign)kMyProductAuditStatus myProductAuditStatus;
@property(strong, nonatomic)UIView *bottomView;
@property(strong, nonatomic)NSMutableArray *tradeSiteListArray;

-(void)hidBottomView;
@end
