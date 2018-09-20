//
//  BiddingView_group.m
//  XYGPWuZi
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BiddingView_group.h"
#define kHeaderContentHeight 90
#define kBiddingContentHeight 90
#define kProductContentHeight (((kScreen_Width - kMyPadding*4)/3)+kMyPadding*2 +60)

@interface BiddingView_group ()
@property(strong, nonatomic)UIImageView *imageView;
@property(strong, nonatomic)UILabel *titleLabel, *descLabel, *biddingTitleLabel, *biddingProductLabel, *bidddingTimeLabel, *productTitleLabel;

@property(strong, nonatomic)UIImageView *imageView_Left, *imageView_Center, *imageView_Right;
@property(strong, nonatomic)UILabel *titleLabel_Left, *titleLabel_Center, *titleLabel_Right;
@property(strong, nonatomic)UIButton *moreBtnTop, *moreBtnBottom;
@end

@implementation BiddingView_group
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.userInteractionEnabled = YES;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;       
    }return _imageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _titleLabel;
}
-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:13];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _descLabel;
}
-(UILabel *)biddingTitleLabel{
    if (!_biddingTitleLabel) {
        _biddingTitleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _biddingTitleLabel;
}
-(UILabel *)biddingProductLabel{
    if (!_biddingProductLabel) {
        _biddingProductLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:13];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _biddingProductLabel;
}
-(UILabel *)bidddingTimeLabel{
    if (!_bidddingTimeLabel) {
        _bidddingTimeLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:13];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _bidddingTimeLabel;
}
-(UILabel *)productTitleLabel{
    if (!_productTitleLabel) {
        _productTitleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _productTitleLabel;
}
-(UIImageView *)imageView_Left{
    if (!_imageView_Left) {
        _imageView_Left = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
    }return _imageView_Left;
}
-(UILabel *)titleLabel_Left{
    if (!_titleLabel_Left) {
        _titleLabel_Left = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor whiteColor];
            label.numberOfLines = 2;
            label;
        });
    }return _titleLabel_Left;
}
-(UIImageView *)imageView_Center{
    if (!_imageView_Center) {
        _imageView_Center = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
    }return _imageView_Center;
}
-(UILabel *)titleLabel_Center{
    if (!_titleLabel_Center) {
        _titleLabel_Center = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor whiteColor];
            label.numberOfLines = 2;
            label;
        });
    }return _titleLabel_Center;
}
-(UIImageView *)imageView_Right{
    if (!_imageView_Right) {
        _imageView_Right = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
    }return _imageView_Right;
}
-(UILabel *)titleLabel_Right{
    if (!_titleLabel_Right) {
        _titleLabel_Right = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor whiteColor];
            label.numberOfLines = 2;
            label;
        });
    }return _titleLabel_Right;
}
-(UIButton *)moreBtnTop{
    if (!_moreBtnTop) {
        _moreBtnTop = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn setTitle:@"更多" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"common_icon_arrow"] forState:UIControlStateNormal];
            [btn setTag:0];
            [btn addTarget:self action:@selector(actionMore:) forControlEvents:UIControlEventTouchUpInside];
            [btn setFrame:(CGRect){kScreen_Width - kMyPadding - 50,0,50,44}];
            [btn layoutButtonWithEdgeInsetsStyle:kBtnEdgeInsetsStyleRight imageTitleSpace:3];
            btn;
        });
    }return _moreBtnTop;
}
-(UIButton *)moreBtnBottom{
    if (!_moreBtnBottom) {
        _moreBtnBottom = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn setTitle:@"更多" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"common_icon_arrow"] forState:UIControlStateNormal];
            [btn setTag:1];
            [btn addTarget:self action:@selector(actionMore:) forControlEvents:UIControlEventTouchUpInside];
            [btn setFrame:(CGRect){kScreen_Width - kMyPadding - 50,0,50,44}];
            [btn layoutButtonWithEdgeInsetsStyle:kBtnEdgeInsetsStyleRight imageTitleSpace:3];
            btn;
        });
    }return _moreBtnBottom;
}
-(void)actionMore:(UIButton *)sesnder{
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        
        
        //topBackView
        UIView *topBackView = [[UIView alloc] initWithFrame:(CGRect){kMyPadding,kMyPadding/2,frame.size.width-kMyPadding*2,kHeaderContentHeight}];
        topBackView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [self addSubview:topBackView];
        
        [topBackView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topBackView).offset(kMyPadding/2);
            make.size.mas_equalTo((CGSize){60,60});
            make.centerY.mas_equalTo(topBackView.mas_centerY);
        }];
        self.imageView.cornerRadius = 30;
        [topBackView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).offset(5);
            make.right.equalTo(topBackView).offset(-kMyPadding/2);
            make.top.equalTo(self.imageView);
            make.bottom.mas_equalTo(topBackView.mas_centerY);
        }];
        [topBackView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).offset(5);
            make.right.equalTo(topBackView).offset(-kMyPadding/2);
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.height.mas_equalTo(30);
        }];
        
        
        //竞价
        [self addSubview:self.biddingTitleLabel];
        [self.biddingTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(topBackView.mas_bottom).offset(kMyPadding/2);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(30);
        }];
        [self addSubview:self.moreBtnTop];
        [self.moreBtnTop mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(topBackView.mas_bottom).offset(kMyPadding/2);
            make.right.equalTo(self).offset(-kMyPadding);
//            make.height.mas_equalTo(30);
            make.size.mas_equalTo((CGSize){50,30});
        }];
        
        [self addSubview:self.biddingProductLabel];
        [self.biddingProductLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(self.biddingTitleLabel.mas_bottom).offset(0);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(20);
        }];
        [self addSubview:self.bidddingTimeLabel];
        [self.bidddingTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(self.biddingProductLabel.mas_bottom).offset(0);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(20);
        }];
        //横线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColor.lightGrayColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(self.bidddingTimeLabel.mas_bottom).offset(2.5);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(0.5);
        }];
        
        //闲置物资
        [self addSubview:self.productTitleLabel];
        [self.productTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(self.bidddingTimeLabel.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(30);
        }];
        [self addSubview:self.moreBtnBottom];
        [self.moreBtnBottom mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(self.bidddingTimeLabel.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-kMyPadding);
//            make.height.mas_equalTo(30);
            make.size.mas_equalTo((CGSize){50,30});
        }];
        
        
        [self addSubview:self.imageView_Left];
        [self.imageView_Left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kHeaderContentHeight+kBiddingContentHeight+30);
            make.left.equalTo(self).offset(kMyPadding);
            make.width.mas_equalTo((self.frame.size.width - kMyPadding*4)/3);
            make.height.mas_equalTo((self.frame.size.width - kMyPadding*4)/3);
        }];
        [self addSubview:self.titleLabel_Left];
        [self.titleLabel_Left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView_Left);
            make.top.mas_equalTo(self.imageView_Left.mas_bottom);
            make.right.equalTo(self.imageView_Left);
            make.height.mas_equalTo(50);
        }];
        
        
        [self addSubview:self.imageView_Center];
        [self.imageView_Center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kHeaderContentHeight+kBiddingContentHeight+30);
            make.left.mas_equalTo(self.imageView_Left.mas_right).offset(kMyPadding);
//            make.bottom.equalTo(self).offset(-60);
            make.width.mas_equalTo((self.frame.size.width - kMyPadding*4)/3);
            make.height.mas_equalTo((self.frame.size.width - kMyPadding*4)/3);
        }];
        [self addSubview:self.titleLabel_Center];
        [self.titleLabel_Center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView_Center);
            make.top.mas_equalTo(self.imageView_Center.mas_bottom);
            make.right.equalTo(self.imageView_Center);
            make.height.mas_equalTo(50);
        }];
        
        
        [self addSubview:self.imageView_Right];
        [self.imageView_Right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kHeaderContentHeight+kBiddingContentHeight+30);
            make.left.mas_equalTo(self.imageView_Center.mas_right).offset(kMyPadding);
//            make.bottom.equalTo(self).offset(-60);
            make.width.mas_equalTo((self.frame.size.width - kMyPadding*4)/3);
            make.height.mas_equalTo((self.frame.size.width - kMyPadding*4)/3);
        }];
        [self addSubview:self.titleLabel_Right];
        [self.titleLabel_Right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView_Right);
            make.top.mas_equalTo(self.imageView_Right.mas_bottom);
            make.right.equalTo(self.imageView_Right);
            make.height.mas_equalTo(50);
        }];
        
    }return self;
}

-(void)setBiddingM:(BiddingModel *)biddingM{
    _biddingM = biddingM;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Light] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    self.titleLabel.text = @"北京华夏建龙矿业有限公司";
    self.descLabel.text = @"所属成员单位共29家";
    self.biddingTitleLabel.text = @"正在进行10场竞价";
    self.biddingProductLabel.text = @"竞价产品：减速机，加速计";
   
    {
        NSString *aheadStr = @"首场开场时间：";
        NSString *moneyStr1 = @"2018-02-01 18：00";
//        NSString *moneyStr2 = [NSString stringWithFormat:@"   数量%@ 吨",@"20"];
        
        NSMutableAttributedString * moneyAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",aheadStr,moneyStr1]];
        [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, moneyAttrStr.length)];
        //    [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
        [moneyAttrStr addAttribute:NSForegroundColorAttributeName value:UIColor.blackColor range:NSMakeRange(aheadStr.length, moneyStr1.length)];
        self.bidddingTimeLabel.attributedText = moneyAttrStr;
    }
    
    
    
    
    
    self.productTitleLabel.text = @"已发布闲置物资1000种";
    [self.imageView_Left sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Light] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    self.titleLabel_Left.text = @"干式磁选机";
    [self.imageView_Center sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Dark] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    self.titleLabel_Center.text = @"干式磁选机";
    [self.imageView_Right sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Light] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    self.titleLabel_Right.text = @"干式磁选机";
}

+(CGFloat)cellHeight:(CGFloat)scale{
    return ((kHeaderContentHeight+kBiddingContentHeight)+kProductContentHeight*scale);
}
@end


@implementation BiddingView_iCarouselGroup
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }return self;
}
- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
    
}
-(void)initView{
//    self.items = [NSMutableArray array];
//    for (int i = 0; i < self.items.count; i++)
//    {
//        [self.items addObject:@(i)];
//    }
    
    iCarousel *carousel = [[iCarousel alloc] initWithFrame:self.frame];
    carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    carousel.type = iCarouselTypeLinear;
    
    carousel.delegate = self;
    carousel.dataSource = self;
    [self addSubview:carousel];
    
    self.carousel = carousel;
    
    
}

#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel{
    return 5;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(BiddingView_group *)view{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil){
        view = [[BiddingView_group alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width-kMyPadding*5, [BiddingView_group cellHeight:((kScreen_Width-kMyPadding*5)/kScreen_Width)])];
        view.backgroundColor = [UIColor whiteColor];
        view.biddingM = [[BiddingModel alloc] init];
        view.contentMode = UIViewContentModeCenter;
        view.tag = 1;
    }
    else{
        //get a reference to the label in the recycled view
        view = (BiddingView_group *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    view.biddingM = self.items[(NSUInteger)index];
    
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}


- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return _wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.03f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}



#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSNumber *item = (self.items)[(NSUInteger)index];
    if (self.selectedBlock) {
        self.selectedBlock(index);
    }
    NSLog(@"Tapped view number: %@", item);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel{
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
}
+(CGFloat)cellHeight{
    return [BiddingView_group cellHeight:((kScreen_Width-kMyPadding*5)/kScreen_Width)];
}
@end

