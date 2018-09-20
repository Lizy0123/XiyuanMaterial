//
//  X_JJDetailOneTableViewCell.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/14.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol oneCellBtnClickDelegate <NSObject>

-(void)pushVcWithBtnTag:(NSInteger)tag;


@end
//cell的类型,第一个是公告详情样式,第二个是成交案例样式
typedef NS_ENUM(NSUInteger, detailOneCellType) {
    detailOneCellTypeDefault,
    detailOneCellTypeChengJiaoAnLiCell,
};
@class X_JJDetailOneCellModel;
@interface X_JJDetailOneTableViewCell : UITableViewCell

@property (nonatomic, strong)X_JJDetailOneCellModel *model;


//设置代理属性
@property(nonatomic,weak)id<oneCellBtnClickDelegate>delegatee;

@property(nonatomic,assign)detailOneCellType cellType;

@end
