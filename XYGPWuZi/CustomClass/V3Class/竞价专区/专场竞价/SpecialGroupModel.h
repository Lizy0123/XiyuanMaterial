//
//  SpecialGroupModel.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/3/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "JSONModel.h"

@interface SpecialGroupModel : JSONModel
@property(nonatomic, copy)NSString<Optional> *title, *spicialName, *highMoney, *lowMoney, *imgUrl;
//@property(nonatomic,strong)NSArray<Optional> *picUrls;
@end
