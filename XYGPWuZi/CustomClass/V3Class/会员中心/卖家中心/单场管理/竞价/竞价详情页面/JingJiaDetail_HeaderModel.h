//
//  JingJiaDetail_HeaderModel.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/13.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JingJiaDetail_HeaderModel : NSObject

//标题
@property(nonatomic,copy)NSString *tnTitle;
//场次编号
@property(nonatomic,copy)NSString *tsTradeNo;
@property(nonatomic,assign)NSInteger toBegin;
@property(nonatomic,assign)NSInteger onGoing;
@property(nonatomic,copy)NSString *isEnd;

@end
