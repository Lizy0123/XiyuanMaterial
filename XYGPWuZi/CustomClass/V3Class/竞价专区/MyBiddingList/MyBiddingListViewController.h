//
//  MyBiddingListViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageView.h"

typedef NS_ENUM(NSInteger, kListViewType) {
    kListViewType_LandscapeView = 0,
    kListViewType_SingleImg,/*专场*/
    kListViewType_PortraitImg, /*拍品*/
    kListViewType_CollectionImg, /**/
    kListViewType_TwoImg, /*易物*/
    kListViewType_iCarousel /**/
};

@interface MyBiddingListViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>
@property(copy, nonatomic)NSString *titleStr;
@property(assign, nonatomic)kListViewType listViewType;
@property(assign, nonatomic)BOOL isShowFilter;

@end
