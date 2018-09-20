//
//  BiddingView_group.h
//  XYGPWuZi
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "BiddingModel.h"

@interface BiddingView_group : UIView
@property(strong, nonatomic)BiddingModel *biddingM;
+(CGFloat)cellHeight:(CGFloat)scale;
@end

@interface BiddingView_iCarouselGroup : UIView<iCarouselDataSource, iCarouselDelegate>
@property(strong, nonatomic)BiddingView_group *groupView;
@property(strong, nonatomic)iCarousel *carousel;
@property(strong, nonatomic)NSMutableArray *items;
@property(assign, nonatomic)BOOL wrap;
@property(copy, nonatomic) void(^selectedBlock)(NSInteger index);

@property(strong, nonatomic)BiddingModel *biddingM;
+(CGFloat)cellHeight;
@end
