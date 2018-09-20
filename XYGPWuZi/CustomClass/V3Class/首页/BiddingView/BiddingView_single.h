//
//  BiddingView_single.h
//  XYGPWuZi
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiddingModel.h"

@interface BiddingView_single : UIView
@property(strong, nonatomic)BiddingModel *biddingM;
+(CGFloat)cellHeight;
@end
