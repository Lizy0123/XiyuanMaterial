//
//  MyImgPickerModel.m
//  MyImgPickerView
//
//  Created by Lzy on 2018/1/15.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyImgPickerModel.h"

@implementation MyImgPickerModel

- (NSString *)description{
    return [NSString stringWithFormat:@"%@---%@",_name,_image];
}
@end
