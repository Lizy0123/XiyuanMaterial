//
//  CitiesView.h
//  CitySelected
//
//  Created by admin on 16/3/21.
//  Copyright © 2016年 sigxui-001. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cityBlock)(NSDictionary *);

@interface CitiesView : UIView


@property (nonatomic, copy) cityBlock blockCity;


-(void)getCities:(NSArray *)cities;
@end
