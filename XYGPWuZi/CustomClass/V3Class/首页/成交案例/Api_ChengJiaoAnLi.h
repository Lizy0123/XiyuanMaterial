//
//  Api_ChengJiaoAnLi.h
//  XYGPWuZi
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"

@interface Model_ChengJiaoAnLi :JSONModel
@property(copy, nonatomic)NSString<Optional>
*pageNum/**/,
*pageSize/**/,
*status/**/,
*tnCreTime/**/,
*tnModtime/**/,
*classOne/**/,
*tsSiteType/**/,
*tnUserType/**/,

*tsStartTime/**/,
*tnPic/**/,
*tsEndTime/**/,
*tnId/**/,
*tnNum/**/,
*tnTitle/**/,
*tnDeposit/**/,
*tsStatus/**/,
*tnType/**/,
*tsName/**/,
*tsTradeNo/**/,
*isEntry/**/,
*tsEndPrice/**/,
*tnUnits/**/
;
@end

@interface Api_ChengJiaoAnLi : MyRequest
-(instancetype)initWithSuccessModel:(Model_ChengJiaoAnLi *)successCaseM;
@end
