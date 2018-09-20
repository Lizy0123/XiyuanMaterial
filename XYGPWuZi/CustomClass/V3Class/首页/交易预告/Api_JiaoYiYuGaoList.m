//
//  Api_JiaoYiYuGaoList.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_JiaoYiYuGaoList.h"

@implementation Api_JiaoYiYuGaoList{
    MyPage _page;
}
-(instancetype)initWithPage:(MyPage)page{
    if (self = [super init]) {
        _page = page;
    }return self;
}

-(NSString *)requestUrl{
    return @"xy/advanceNotice/getAdvanceNoticeList.json";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{
             @"pageNum":[NSString stringWithFormat:@"%ld",_page.pageIndex],
             @"pageSize":[NSString stringWithFormat:@"%ld",_page.pageSize],
             };
}

@end
