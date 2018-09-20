//
//  SearchViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/27.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "SearchViewController.h"
#import "CategorySearchBar.h"
#import "KxMenu.h"
#import "SearchDisplayController.h"

@interface SearchViewController ()<UISearchDisplayDelegate>//UITableViewDataSource,UITableViewDelegate,
@property (nonatomic,strong)UIView *searchView;
@property (strong, nonatomic) NSMutableArray *statusList;
@property (strong, nonatomic) CategorySearchBar *mySearchBar;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,assign) BOOL firstLoad;
@property (strong, nonatomic) SearchDisplayController *searchDisplayVC;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"搜索";
    _selectIndex=0;
    _statusList = @[@"公告",
                    @"预告",
                    @"产品",
                    @"需求"].mutableCopy;
    _firstLoad=TRUE;
    [self buildUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    [self.navigationController.navigationBar addSubview:_mySearchBar];
    if (_firstLoad) {
        [_mySearchBar becomeFirstResponder];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mySearchBar resignFirstResponder];
    [_mySearchBar removeFromSuperview];
    _firstLoad=FALSE;
}

//基础化UI布局
-(void)buildUI{
    self.view.backgroundColor=kColorHex(0xeeeeee);
    
    //添加搜索框
    _mySearchBar = ({
        CategorySearchBar *searchBar = [[CategorySearchBar alloc] initWithFrame:CGRectMake(20,7, kScreen_Width-75, 31)];
        searchBar.layer.cornerRadius=15;
        searchBar.layer.masksToBounds=TRUE;
        [searchBar.layer setBorderWidth:8];
        searchBar.backgroundColor = [UIColor clearColor];
        [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];//设置边框为白色
        [searchBar sizeToFit];
        [searchBar setTintColor:[UIColor whiteColor]];
        [searchBar insertBGColor:kColorHex(0xffffff)];
//                [searchBar setImage:nil forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//                [searchBar setPositionAdjustment:UIOffsetMake(10,0) forSearchBarIcon:UISearchBarIconClear];
//                searchBar.searchTextPositionAdjustment=UIOffsetMake(10,0);
        [searchBar setHeight:30];
        searchBar;
    });
    
    
    //初始化选项
    NSMutableArray *menuItems = @[].mutableCopy;
    [_statusList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KxMenuItem *menuItem = [KxMenuItem menuItem:obj image:nil target:self action:@selector(menuItemClicked:)];
        menuItem.alignment=NSTextAlignmentLeft;
        //                menuItem.foreColor = [UIColor colorWithHexString:idx == _selectedStatusIndex? @"0x3bbd79": @"0x222222"];
        menuItem.foreColor = kColorHex(0xffffff);
        [menuItems addObject:menuItem];
    }];
    
    
    __weak typeof(self) weakSelf = self;
    [_mySearchBar patchWithCategoryWithSelectBlock:^{
        if ([KxMenu isShowingInView:[UIApplication sharedApplication].keyWindow]) {
            [KxMenu dismissMenu:YES];
            [weakSelf.mySearchBar becomeFirstResponder];
        }else{
            [weakSelf.mySearchBar resignFirstResponder];
            [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
            //            [KxMenu setTintColor:[UIColor colorWithHexString:@"0x28303B" andAlpha:0.9]];
            [KxMenu setTintColor:kColorHex(0x28303B)];
            [KxMenu setOverlayColor:[UIColor clearColor]];

            CGRect senderFrame = CGRectMake(weakSelf.searchView.frame.origin.x+50, 64, 0, 0);
            [KxMenu showMenuInView:[UIApplication sharedApplication].keyWindow fromRect:senderFrame menuItems:menuItems];
        }
    }];
    [_mySearchBar setSearchCategory:[_statusList objectAtIndex:_selectIndex]];
    
    
    if (!_searchDisplayVC) {
        _searchDisplayVC = ({
            SearchDisplayController *searchVC = [[SearchDisplayController alloc] initWithSearchBar:_mySearchBar contentsController:self];
            //自定义uisearchbar 要在这里重新申明
            //需要重新调整下大小
            searchVC.searchBar.frame=CGRectMake(20,7, kScreen_Width-75, 31);
            searchVC.searchBar.layer.cornerRadius=15;
            searchVC.searchBar.layer.masksToBounds=TRUE;
            [searchVC.searchBar.layer setBorderWidth:6];
            [searchVC.searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];//设置边框为白色
            UITextField *textfield = [searchVC.searchBar valueForKey:@"_searchField"];
            [textfield setValue:kColorHex(0x999999)forKeyPath:@"_placeholderLabel.textColor"];
            [textfield setValue:[UIFont boldSystemFontOfSize:12]forKeyPath:@"_placeholderLabel.font"];
            textfield.font=[UIFont systemFontOfSize:13];
            //placeholder 要在此处设置，不然报错
            [searchVC.searchBar setPlaceholder:@"公告/预告/产品/需求"];
            
            searchVC.displaysSearchBarInNavigationBar=NO;
            searchVC.parentVC = self;
            searchVC.delegate=self;
            searchVC;
        });
    }
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(popToMainVCAction)];
    
    
    //    //表格内容
    //    _tableview=({
    //        UITableView *tableview=[UITableView new];
    //        tableview.tableFooterView=[UIView new];
    //        tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    //        //解决左侧分割线偏短问题
    //        if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
    //            [tableview setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    //        }
    //        tableview.backgroundColor=[UIColor whiteColor];
    //        tableview.delegate=self;
    //        tableview.dataSource=self;
    //        tableview.rowHeight=45;
    //        //注册cell
    //        [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    //        tableview;
    //    });
    //    [self.view addSubview:_tableview];
    //
    //    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view);
    //    }];
    
    
    
}


#pragma mark - loadData
-(void)loadData{
    [_tableview reloadData];
}


//#pragma mark - Table view data source
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//    cell.textLabel.text=@"搜索记录";
//    return cell;
//}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}


#pragma mark - event
//弹出到首页
-(void)popToMainVCAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)menuItemClicked:(KxMenuItem *)item{

    NSInteger nowSelectIndex = [_statusList indexOfObject:item.title];
    if (nowSelectIndex == NSNotFound || nowSelectIndex == _selectIndex) {
        return;
    }
    _selectIndex = nowSelectIndex;
    
    _searchDisplayVC.curSearchType=_selectIndex;
    NSString *showStr=([[_statusList objectAtIndex:_selectIndex] length]>2)?[[_statusList objectAtIndex:_selectIndex] substringToIndex:[[_statusList objectAtIndex:_selectIndex] length]-2]:[_statusList objectAtIndex:_selectIndex];
    [_mySearchBar setSearchCategory:showStr];
    
    if (_searchDisplayVC.active&&(_mySearchBar.text.length>0)) {
        NSLog(@"active And can search");
        [_searchDisplayVC reloadDisplayData];
    }else{
        [_mySearchBar becomeFirstResponder];
    }
}
@end
