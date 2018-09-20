//
//  MyBottomBoxView.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/12.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "MyBottomBoxView.h"
#define MyColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ScreenH [[UIScreen mainScreen] bounds].size.height
#define ScreenW  [[UIScreen mainScreen] bounds].size.width
#define MyColor(r, g, b) MyColorA((r), (g), (b), 255)


@interface MyBottomBoxView()
/// 遮盖
@property(strong, nonatomic)UIView *coverView;
/// 列表数据
@property(strong, nonatomic)NSArray *titleArray;
@property(strong, nonatomic)NSArray *detailArray;

/// 图片数据
@property(strong, nonatomic)NSArray *imageArray;
@property(strong, nonatomic)UIButton *closeBtn;
@property(strong, nonatomic)UIButton *infoBtn;

@end

@implementation MyBottomBoxView
- (void)initWithTitle:(NSString *)titleStr{
    [self configTitle:titleStr];
}


// 初始化数据
- (void)initWithTitle:(NSString *)titleStr titleArray:(NSArray *)titleArray detailArray:(NSArray *)detailArray imageArray:(NSArray *)imageArray{
    [self configTitle:titleStr];

    self.titleArray = titleArray;
    self.detailArray = detailArray;
    self.imageArray = imageArray;
    
    self.scrollView.contentSize = CGSizeMake(ScreenW, 44*titleArray.count+100);
    for (int i = 0; i < titleArray.count; i++) {
        BoxItemView *itemView = [[BoxItemView alloc] init];
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.tag = i + 100;
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionItemView:)];
        [itemView addGestureRecognizer:tap];
//        // 取消
//        if (i == titleArray.count+1) {
//            itemView.frame = CGRectMake(0, self.frame.size.height-44, ScreenW, 44);
//            [self addSubview:itemView];
//            itemView.imageView.hidden = YES;
//            itemView.titleLabel.textAlignment = NSTextAlignmentCenter;
//            itemView.titleLabel.text = self.titleArray[1];
//            continue;
//        }
//        if (i != 0 & i != titleArray.count+1) {
            itemView.frame = CGRectMake(0, (i) * 44, ScreenW, 44);
            [self.scrollView addSubview:itemView];
        if (self.imageArray.count>0) {
            itemView.imageView.image = [UIImage imageNamed:self.imageArray[i]];
        }
        itemView.titleLabel.text = self.titleArray[i];
        itemView.detailLabel.text = self.detailArray[i];
//        }
    }
}
#pragma mark - ConfigTitle
-(void)configTitle:(NSString *)titleStr{
    // 创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 50, ScreenW, self.frame.size.height - 50);
    scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    //标题
    CGFloat btnWidth = 60;
    CGFloat padding = 16;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(padding+btnWidth, 0, ScreenW - (btnWidth*2), 50)];
    title.backgroundColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:15];
    title.text = titleStr;
    [titleView addSubview:title];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, ScreenW, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [titleView addSubview:lineView];
    
    [self addSubview:titleView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(ScreenW - btnWidth, 0, btnWidth, 50)];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [rightBtn addTarget:self action:@selector(closeBottomBoxView) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightBtn];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"InfoBtn"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"InfoBtn"] forState:UIControlStateHighlighted];
    [leftBtn setImage:[UIImage imageNamed:@"InfoBtn"] forState:UIControlStateSelected];
    [leftBtn setFrame:CGRectMake(10, 5, 44, 44)];
    leftBtn.hidden = YES;
    leftBtn.tintColor = UIColor.blackColor;
    [leftBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [leftBtn addTarget:self action:@selector(actionShowInfo:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:leftBtn];
    self.infoBtn = leftBtn;
}
/// 显示弹框
- (void)showBottomBoxView{
    // 弹出view前加遮盖
    UIView *coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = MyColorA(120, 120, 122, 0.8);
    [self.superview addSubview:coverView];
    self.coverView = coverView;
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionCover)];
    [coverView addGestureRecognizer:tap];
    
    // 动画弹出选择支付view
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.superview bringSubviewToFront:weakSelf];
        weakSelf.frame = CGRectMake(0, ScreenH -self.frame.size.height, ScreenW, self.frame.size.height);
    }];
    if (self.showInfoBtn) {
        self.infoBtn.hidden = NO;
    }else{
        self.infoBtn.hidden = YES;
    }
}
-(void)actionShowInfo:(UIButton *)sender{
    if (self.clickBlock) {
        self.clickBlock(sender);
    }
}
/// 销毁弹框
- (void)closeBottomBoxView{
    // 动画退出选择支付view
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(0, ScreenH , ScreenW, self.frame.size.height);
        
    }];
    // 移除弹框
    [self removeFromSuperview];
    // 移除遮盖
    [self.coverView removeFromSuperview];
}

/// 遮盖点击事件
- (void)actionCover{
    if (self.clickBlock) {
        [self closeBottomBoxView];
    }
}

// 点击事件
- (void)actionItemView:(UITapGestureRecognizer *)tap{
    NSLog(@"clickView:(UITapGestureRecognizer *)tap");
    if (self.clickBlock) {
        self.clickBlock(tap.view);
    }
}
@end


#pragma  mark - Item
@implementation BoxItemView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        // 3.分割线
        UIView *line = [[UIView alloc]init];
        line.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (_imageView) {
        CGFloat imageViewWidth = 30;
        self.imageView.frame = CGRectMake(16, 7, imageViewWidth, imageViewWidth);
        self.titleLabel.frame = CGRectMake(16+imageViewWidth+3, 0, self.frame.size.width - 32 - imageViewWidth -3, self.frame.size.height);
        self.detailLabel.frame = CGRectMake(100, 0, self.frame.size.width-100-16, self.frame.size.height);
    }else{
        self.titleLabel.frame = CGRectMake(16, 0, self.frame.size.width - 32, self.frame.size.height);
        self.detailLabel.frame = CGRectMake(100, 0, self.frame.size.width-100-16, self.frame.size.height);
    }
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(15, 7, 30, 30);
        [self addSubview:_imageView];
        
    }return _imageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_detailLabel];
    }return _detailLabel;
}
@end

