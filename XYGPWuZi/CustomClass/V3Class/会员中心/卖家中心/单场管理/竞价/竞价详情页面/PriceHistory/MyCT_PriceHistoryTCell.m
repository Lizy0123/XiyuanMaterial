//
//  MyCT_PriceHistoryTCell.m
//  XYGPWuZi
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 河北熙元科技有限公司. All rights reserved.
//

#import "MyCT_PriceHistoryTCell.h"
#import "MyCT_PriceHistoryCCell.h"

#import "Masonry.h"

static const CGFloat kLeftRightMargin = 15.0;

@interface MyCT_PriceHistoryTCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation MyCT_PriceHistoryTCell

- (instancetype)initWithEntity:(HistoryModel *)entity reuseIdentifier:(NSString *)identifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        _entity = entity;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:20.0];
        [self.contentView addSubview:_titleLabel];
        
        _showAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showAllButton setTitle:@"显示全部 >" forState:UIControlStateNormal];
        [_showAllButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _showAllButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        _showAllButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:_showAllButton];
        
        UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        horizontalCellLayout.minimumInteritemSpacing = 10;
        horizontalCellLayout.minimumLineSpacing = 10;
        horizontalCellLayout.itemSize = CGSizeMake(80, 152);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 24, 152)
                                             collectionViewLayout:horizontalCellLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_collectionView];
        
        [_collectionView registerClass:NSClassFromString(@"MyCT_PriceHistoryCCell")
            forCellWithReuseIdentifier:@"MyCT_PriceHistoryCCell"];
        
        //        // frame style
        //        CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
        //        _titleLabel.frame = CGRectMake(12, 10, 200, 30);
        //        _showAllButton.frame = CGRectMake(kScreenWidth - 80 - 12, 10, 80, 30);
        //        _collectionView.frame = CGRectMake(0, 10 + 30 + 10, kScreenWidth, 152);
        
        // add constraint
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(10.0);
            make.left.mas_equalTo(self.contentView.mas_left).offset(12.0);
            make.height.mas_equalTo(30);
        }];
        
        [_showAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(10.0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12.0);
            make.left.mas_equalTo(_titleLabel.mas_right).offset(10.0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10.0);
            make.left.mas_equalTo(self.contentView.mas_left).offset(0);
            //            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(18.0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(152);
        }];
        
        //
        _titleLabel.text = entity.title;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.entity.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContentModel *contentModel = self.entity.itemsArray[indexPath.row];
    
    MyCT_PriceHistoryCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCT_PriceHistoryCCell"
                                                                                forIndexPath:indexPath];
    cell.desLabel.text = [NSString stringWithFormat:@"%@ \n %@ \n %@", contentModel.itemTitle, contentModel.typeString, contentModel.priceString];
    
    return cell;
}

//- (CGSize)horizontalCellContentsView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize itemSize = CGSizeMake(80, 152);
//    return itemSize;
//}

- (void)setEntity:(HistoryModel *)entity {
    _entity = entity;
    
    [self.collectionView reloadData];
}

@end
