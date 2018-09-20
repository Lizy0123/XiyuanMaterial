//
//  CTCell.h
//  XYGPWuZi
//
//  Created by apple on 2018/8/18.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiddingModel.h"

@interface CCell : UICollectionViewCell
@property(strong, nonatomic)BiddingModel *biddingM;
@end


@class CTCell;
@protocol CTCellDelegate<NSObject>
-(void)CTCell:(CTCell *)cell indexPath:(NSIndexPath *)indexPath;
@end
@interface CTCell : UITableViewCell
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
+(CGFloat)cellHeight;
@end
