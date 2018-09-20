//
//  ChuJiaJiLuModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol RecordDetailModel
@end
@interface RecordDetailModel : JSONModel
@property (nonatomic,copy)NSString <Optional>
*tspMoney/**/,
*tspBuyTime/**/,
*bidNo/**/;
@end




@interface ChuJiaJiLuModel : JSONModel
@property (nonatomic,copy)NSString <Optional>
*tsMinPrice/**/,
*tsTradeNo/**/;
@property (strong, nonatomic) NSArray<RecordDetailModel, Optional>* processList;

@end

@interface RecordJiaoyiModel : JSONModel
@property (nonatomic,copy)NSString <Optional>
*tspMoney/**/,
*tspBuyTime/**/,
*bidNo/**/;
@end
