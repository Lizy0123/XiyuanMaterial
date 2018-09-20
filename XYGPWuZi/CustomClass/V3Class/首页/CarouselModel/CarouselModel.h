//
//  CarouselModel.h
//  Taoyi
//
//  Created by Lzy on 2018/2/1.
//  Copyright © 2018年 Lzy. All rights reserved.
//

#import "JSONModel.h"

@interface CarouselModel : JSONModel
@property(nonatomic, assign) NSNumber <Optional>*activityId, *clickType;
@property(nonatomic, copy) NSString <Optional>*title, *imageUrl;

@end
