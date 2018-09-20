//
//  AreaView.m
//  CitySelected
//
//  Created by admin on 16/3/21.
//  Copyright © 2016年 sigxui-001. All rights reserved.
//

#import "AreaView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AreaView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic, copy) NSArray *arrayList;
@end

@implementation AreaView

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
-(void)getArea:(NSArray *)areas
{
    self.arrayList = areas;
    [self addSubview:self.tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayList count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.arrayList[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      NSLog(@"%@",self.arrayList[indexPath.row]);
    NSDictionary *dic = @{
                          @"area":self.arrayList[indexPath.row]
                          };
      self.block((NSMutableDictionary *)dic);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
