//
//  X_ShaiXuanTableViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "X_ShaiXuanTableViewController.h"
#import "X_ShaiXuanTableViewCell.h"
#import "X_ShaiXuanModel.h"
#import "AFNetworking.h"



@interface X_ShaiXuanTableViewController ()
//数据数组
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation X_ShaiXuanTableViewController

-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"筛选";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle =NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self requestData];
    [self clearExtraLine:self.tableView];
    
    NSLog(@"-----------%@",self.code);


}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    X_ShaiXuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (!cell) {
        cell = [[X_ShaiXuanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        X_ShaiXuanModel *model = self.dataArray[indexPath.row];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    NSLog(@"----shaixuan----%ld",indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.shaiXuandelegate respondsToSelector:@selector(postBackController:postBackCode:)]) {
        X_ShaiXuanModel *model = self.dataArray[indexPath.row];
        
        [self.shaiXuandelegate postBackController:self postBackCode:model.code];
        
        
        
    }
    
    
}

#pragma mark 去掉多余的线
-(void)clearExtraLine:(UITableView *)tableView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

#pragma mark 请求数据
-(void)requestData{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.code forKey:@"code"];

    
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_ShaixuanList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"------%@",responseObject);
        
        for (NSDictionary *dict in (NSArray*)responseObject[@"object"]) {
            
            X_ShaiXuanModel *model = [[X_ShaiXuanModel alloc]init];
            model.code = dict[@"code"];
            model.name = dict[@"name"];
          
            [weakSelf.dataArray addObject:model];
            
        }
        /*
         *在Main Dispatch Queue中执行Block
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /*
             *只能在主线程中执行的处理
             */
            NSLog(@" 当前线程  %@",[NSThread currentThread]);
            [weakSelf.tableView reloadData];
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
