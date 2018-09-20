//
//  SearchDisplayController.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

typedef NS_ENUM(NSUInteger, kSearchType) {
    kSearchType_TradeNotice=0,
    kSearchType_TransactionPreview,
    kSearchType_IdleProduct,
    kSearchType_WantToBuy
    
};




#import <UIKit/UIKit.h>

@interface SearchDisplayController : UISearchDisplayController
@property (nonatomic,weak)UIViewController *parentVC;
@property (nonatomic,assign)kSearchType curSearchType;
-(void)reloadDisplayData;

@end
