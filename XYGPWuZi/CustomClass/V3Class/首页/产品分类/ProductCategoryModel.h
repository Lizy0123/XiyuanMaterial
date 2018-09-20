//
//  ProductCategoryModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/26.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ProductCategoryModel
@end

@interface ProductCategoryModel : JSONModel
@property (nonatomic,copy)NSString <Optional>
*level,
*categoryName,
*proCategoryId,
*parentId;
@property (strong, nonatomic) NSArray<ProductCategoryModel, Optional>* childs;

@end
