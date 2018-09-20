//
//  MyCT_PriceHistoryTCell.h
//  XYGPWuZi
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryModel.h"

@interface MyCT_PriceHistoryTCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *tableViewIndexPath;
@property (strong, nonatomic) HistoryModel *entity;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *showAllButton;
@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithEntity:(HistoryModel *)entity reuseIdentifier:(NSString *)identifier;

@end
