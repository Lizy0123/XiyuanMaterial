//
//  HistoryModel.h
//  XYGPWuZi
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 河北熙元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject

@property (nonatomic, assign) NSInteger cellType; // 1: item  2: topic  3:default
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *itemsArray;

@end

@interface ContentModel : NSObject

@property (nonatomic, copy) NSString *photoUrlString;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) NSString *typeString;
@property (nonatomic, copy) NSString *priceString;

@end
