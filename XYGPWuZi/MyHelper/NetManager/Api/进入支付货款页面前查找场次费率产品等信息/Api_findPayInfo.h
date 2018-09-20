//
//  Api_findPayInfo.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/15.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"
#import "MyProductModel.h"

@interface Model_Product:JSONModel
@property(copy, nonatomic)NSString<Optional>
*piName/*品名*/,
*piCpcd/*品牌*/,
*piCpxh/*产品型号*/,
*piUnit/*产品单位*/,
*pic/*产品图片*/,
*piNum/*产品数量*/,
*minPrice/*起拍价*/
;
@end



@interface Model_PayForProduct:JSONModel
@property(copy, nonatomic)NSString<Optional>
*cpCreateTime/**/,
*tsTradeNo/**/,
*tsName,
*payNo,
*payName,
*payMoble,
*needPay,
*tsSiteType,
*lastPay,
*saleUserName,
*balance,
*jgzh
;
@property(strong, nonatomic) NSArray<MyProductModel> *productList/**/;

@end


@interface Api_findPayInfo : MyRequest
-(instancetype)initWithtsId:(NSString *)cpId;
@end
