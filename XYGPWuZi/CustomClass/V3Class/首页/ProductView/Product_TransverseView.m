//
//  Product_TransverseView.m
//  XYGPWuZi
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Product_TransverseView.h"

@implementation Product_TransverseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.purpleColor;
    }return self;
}
+(CGFloat)cellHeight{
    return 44;
}
@end
