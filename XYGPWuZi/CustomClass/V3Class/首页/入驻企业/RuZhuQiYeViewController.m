//
//  RuZhuQiYeViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "RuZhuQiYeViewController.h"

@interface RuZhuQiYeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
@property(strong, nonatomic) UICollectionView *myCollectionView;
@end

@implementation RuZhuQiYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myCollectionView];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
NSString *identifier = @"cell";
NSString *headerIdentifier = @"header";
NSString *footerIdentifier = @"footer";
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        _myCollectionView = ({
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            // 设置最小行间距
            flowLayout.minimumLineSpacing = kMyPadding;
            // 最小列间距
            flowLayout.minimumInteritemSpacing = 0;
            float itemWidth = (kScreen_Width-kMyPadding*4)/2;
            flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
            /**
             *  设置自动滚动的方向 垂直或者横向
             */
            flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            /**
             *  设置集合视图内边距的大小
             *
             *  @param 20 上
             *  @param 20 左
             *  @param 20 下
             *  @param 20 右
             *
             *  @return  UIEdgeInsetsMake  与下面的方法相同  -(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
             */
            flowLayout.sectionInset = UIEdgeInsetsMake(kMyPadding/2, kMyPadding/2, kMyPadding/2, kMyPadding/2);
            /**
             *  设置header区域大小
             *
             *  @param 414 414
             *  @param 70  无用
             *
             *  @return
             */
//            flowLayout.headerReferenceSize = CGSizeMake(414, 70);
            /**
             *  设置footer区域的大小
             *
             *  @param 414 无用
             *  @param 70  自己设置
             *
             *  @return  如果写了这里必须设置注册
             */
            //    flowLayout.footerReferenceSize = CGSizeMake(414, 70);
            
            /**
             创建UICollectionView前必须先创建布局对象UICollectionViewFlowLayout
             
             - returns: UICollectionViewFlowLayout(布局对象)
             */
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
            //设置属性
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            
            // 是否显示垂直方向指示标, 继承于UIScrollView, 他的方法可以调用
            collectionView.showsVerticalScrollIndicator = NO;
            
            // 注册
            [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
            
            /**
             *  注册增补视图
             */
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
            
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
            // 添加到视图上
            collectionView;
            
        });
    }return _myCollectionView;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"placeholderImg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView).offset(-30);
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"这里显示企业名称";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [cell.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(cell.contentView);
        make.height.mas_equalTo(30);
    }];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
    return cell;
}

// 设置每个分区返回多少item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}

// 设置集合视图有多少个分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    // 如果是头视图
//    if (kind == UICollectionElementKindSectionHeader) {
//        // 从重用池里面取
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
//        headerView.backgroundColor =[UIColor orangeColor];
////        headerView.titleLabel.text = @"测试";
//        return headerView;
//    }else{
//        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
//        //        footerView.backgroundColor = [UIColor brownColor];
//        //        return footerView;
//        return nil;
//    }
//
//}


// 点击item触发的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    /**
     推出的页面的布局一般在这里写 最小行间距.列间距等
     - returns:
     */
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
//    DetailCollectionViewController *detailVC = [[DetailCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
//
//    [self.navigationController pushViewController:detailVC animated:YES ];
//    NSLog(@"%ld-%ld",indexPath.section,indexPath.row);
    
}

/**
 *  指定那些路径可以被点击
 *
 *  @param collectionView
 *  @param indexPath
 *
 *  @return
 // */
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.section == 0) {
//        return NO;
//    }
//    return YES;
//}



-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kMyPadding, kMyPadding, kMyPadding, kMyPadding);
}



















@end
