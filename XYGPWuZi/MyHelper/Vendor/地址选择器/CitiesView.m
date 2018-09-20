//
//  CitiesView.m
//  CitySelected
//
//  Created by admin on 16/3/21.
//  Copyright © 2016年 sigxui-001. All rights reserved.
//

#import "CitiesView.h"
#import "AreaView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CitiesView ()<UITableViewDataSource,UITableViewDelegate>
{
    //NSArray *arrayList;
}
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain) NSArray *arrayList;
@end
@implementation CitiesView
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH-100, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(100, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT);
       self.arrayList = [[NSArray alloc]init];
    }
    return self;
}
-(void)getCities:(NSArray *)cities{
    self.arrayList = cities;
    //NSLog(@"%@",self.arrayList);
    [self addSubview:self.tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayList.count ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.arrayList[indexPath.row][@"city"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.arrayList[indexPath.row][@"areas"] count] > 0) {
        
       AreaView *area = [[AreaView alloc]init];
        
        //NSLog(@"%@",self.arrayList[indexPath.row]);
        [area getArea:self.arrayList[indexPath.row][@"areas"]];
        
        
        area.block = ^(NSDictionary *area){
           // NSString *cityArea = area;
            
           // NSString *city = [NSString stringWithFormat:@"%@%@",self.arrayList[indexPath.row][@"city"],cityArea];
            NSDictionary *dic = @{
                                  @"area":area[@"area"],
                                  @"city":self.arrayList[indexPath.row][@"city"]
                                  };
            self.blockCity((NSDictionary *)dic);
        };
        
        
        [self addSubview:area];
    }else{
        NSDictionary *dic = @{
                              @"city":self.arrayList[indexPath.row][@"city"]
                              };
        self.blockCity((NSDictionary *)dic);
    }
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
