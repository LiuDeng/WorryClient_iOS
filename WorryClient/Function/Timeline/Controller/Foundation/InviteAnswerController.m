//
//  InviteAnswerController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/8.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "InviteAnswerController.h"

@interface InviteAnswerController ()<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@end

@implementation InviteAnswerController

#pragma mark - Default methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadView
{
    [super loadView];
    [self loadSearchBar];
}

#pragma mark - Private methods

- (void)loadSearchBar
{
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入要邀请用户昵称";
    [self.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchBar;
    
    
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.searchController = self.searchDisplayController;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
//    JDDebug(@"searchController rightBtn %@",self.searchDisplayController.navigationItem.title);
    
//    UIButton *rightBtn = [[UIButton alloc]init];
//    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
//    self.searchController.navigationItem.leftItemsSupplementBackButton = YES;// = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:nil];
    //  放个tableView作为遮挡的view吧？
    //  cancel还得取消呢。
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索Begin");
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索End");
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
     NSLog(@"searchText %@",searchText);
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    // 谓词的包含语法,之前文章介绍过http://www.cnblogs.com/xiaofeixiang/
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
//    if (self.searchList!= nil) {
//        [self.searchList removeAllObjects];
//    }
//    //过滤数据
//    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
//    //刷新表格
    NSLog(@"searchString %@",searchString);
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    UISearchBar *searchBar = controller.searchBar;
    [searchBar showsCancelButton];
    for (UIView *subView in [searchBar subviews]) {
        JDDebug(@"subViewClass %@",subView.class);
//        if ([subView isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton *)subView;
//            [button setTitle:@"取消" forState:UIControlStateNormal];
//        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSearchBarHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 1;
    if (tableView == self.tableView) {
        //  display the data count what you want to display when show this page
    }else{
        //  display the search results count.
    }
    return num;
}

#pragma mark - UITableViewDataSource

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell;
//    if (tableView == self.tableView) {
//        //  display the data what you want to display when show this page
//    }else{
//        //  display the search results.
//    }
//    return cell;
//}

@end
