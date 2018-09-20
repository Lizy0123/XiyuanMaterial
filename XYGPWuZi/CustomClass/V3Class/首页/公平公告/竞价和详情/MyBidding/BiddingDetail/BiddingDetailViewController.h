//
//  BiddingDetailViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "BiddingModel.h"

@protocol BiddingListViewControllerBackRefreshDelegate <NSObject>
//pop回来刷新界面
-(void)backRefresh;
@end


@interface BiddingDetailViewController : BaseViewController
@property(nonatomic,assign)id<BiddingListViewControllerBackRefreshDelegate>backDelegate;

@property(strong, nonatomic)BiddingModel *biddingM;
@property(copy, nonatomic)NSString *companyName;
@end
