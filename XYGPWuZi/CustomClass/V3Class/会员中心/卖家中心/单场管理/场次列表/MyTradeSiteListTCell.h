//
//  MyTradeSiteListTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/8.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProductModel.h"
#import "AddBiddingModel.h"

@class MyTradeSiteListTCell;
@protocol MyTradeSiteListTCellDelegate<NSObject>
-(void)btnOnCell:(MyTradeSiteListTCell *)cell tag:(NSInteger)tag;

@end


@interface MyTradeSiteListTCell : UITableViewCell
@property(assign, nonatomic)kMyTradeSiteStatus myTradeSiteStatus;
@property(strong, nonatomic)AddBiddingModel *biddingProductM;

@property(weak, nonatomic)id <MyTradeSiteListTCellDelegate>delegate;

+(CGFloat)cellHeight;
@end
