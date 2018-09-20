//
//  XR_CityView.h
//  hhhhhhh
//
//  Created by 河北熙元科技有限公司 on 2017/10/9.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cityBlock)(NSDictionary*);

@interface XR_CityView : UIView

@property(nonatomic,copy)cityBlock blockCity;

-(void)getCities:(NSArray *)cities;


@end
