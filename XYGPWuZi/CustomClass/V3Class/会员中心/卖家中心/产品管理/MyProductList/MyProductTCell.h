//
//  AuditTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProductModel.h"
typedef void (^AnimationBtnClicked)(UIImageView *goodImage, CGPoint point);

@class MyProductTCell;
@protocol MyProductTCellDelegate<NSObject>
-(void)btnOnCell:(MyProductTCell *)cell tag:(NSInteger)tag;

@end

@interface MyProductTCell : UITableViewCell
@property(assign, nonatomic)kMyProductAuditStatus myProductAuditStatus;
@property(strong, nonatomic)MyProductModel *productM;
@property(weak, nonatomic)id <MyProductTCellDelegate>delegate;

@property (strong , nonatomic)AnimationBtnClicked animationBtnClicked;

+(CGFloat)cellHeight;
@end
