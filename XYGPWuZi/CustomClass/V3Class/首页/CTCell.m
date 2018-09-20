//
//  CTCell.m
//  XYGPWuZi
//
//  Created by apple on 2018/8/18.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "CTCell.h"

@interface CCell ()
@property(strong, nonatomic)UIImageView *imageView;
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *descLabel;
@end

@implementation CCell
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = ({
            CGFloat width = kScreen_Width/3;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,width,width}];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView;
        });
    }return _imageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        CGFloat width = kScreen_Width/3;
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,0,width,20}];
            label.font = [UIFont boldSystemFontOfSize:13];
            label.numberOfLines = 2;
            label.textColor = UIColor.blackColor;
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }return _titleLabel;
}
-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = ({
            CGFloat width = kScreen_Width/3;
            UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,0,width,20}];
            label.font = [UIFont boldSystemFontOfSize:13];
            label.numberOfLines = 1;
            label.textColor = UIColor.grayColor;
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }return _descLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(frame.size.height - 50);
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(3);
        }];
        
        [self.contentView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
            make.height.mas_equalTo(13);
            make.left.right.equalTo(self);
        }];
        
        self.imageView.backgroundColor = UIColor.redColor;
        self.titleLabel.backgroundColor = UIColor.yellowColor;
        self.descLabel.backgroundColor = UIColor.blueColor;
        
    }return self;
}
-(void)setBiddingM:(BiddingModel *)biddingM{
    _biddingM = biddingM;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Light] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.titleLabel.text = @"干式磁选机";
    self.descLabel.text = @"品牌：xx型号：xxx 数量：20";
}
@end
@interface CTCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(strong, nonatomic) UICollectionView *myCollectionView;
@end



@implementation CTCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.myCollectionView];
        [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return self;
}
#pragma mark - UICollectionView
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        _myCollectionView = ({
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            flowLayout.itemSize = CGSizeMake([CTCell cellHeight], [CTCell cellHeight]);
            flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            flowLayout.minimumLineSpacing = 10;
            
            /* Init and Set CollectionView */
            UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
            collectView.delegate = self;
            collectView.dataSource = self;
            collectView.showsHorizontalScrollIndicator = NO;
            collectView.backgroundColor = [UIColor clearColor];
            collectView.clipsToBounds = YES;
            
            [collectView registerClass:[CCell class] forCellWithReuseIdentifier:@"CCell"];
            collectView;
        });
    }return _myCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if ([self.specialM.surplusNum integerValue] >0) {
//        return [self.specialM.subjects count] +1;
//    }else{
//        return [self.specialM.subjects count];
//    }
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CCell *cell = (CCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CCell" forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    if(row < self.dataSourceArray.count){
        cell.biddingM =[self.dataSourceArray objectAtIndex:[indexPath row]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self.delegate collectionView:self didSelectImageItemAtIndexPath:(NSIndexPath*)indexPath];
}

+(CGFloat)cellHeight{
    return 190;
}
@end
