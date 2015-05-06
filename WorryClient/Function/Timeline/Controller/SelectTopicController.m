//
//  SelectTopicController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "SelectTopicController.h"
#import "Topic.pb.h"
#import "TopicManager.h"
#import "TopicService.h"
#import "SelectTopicCell.h"
#import "MJRefresh.h"

#define kTopicCollectionViewCell    @"kTopicCollectionViewCell"

@interface SelectTopicController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *pbTopicArray;

@end

@implementation SelectTopicController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    [self loadCollectionView];
    [self addRightButtonWithImageName:@"create_feed_save" target:self action:@selector(clickRightButton)];
}

- (void)loadData
{
    [super loadData];
    self.selectedPBTopicArray = [[NSMutableArray alloc]init];
}

#pragma mark - Private methods

- (void)loadCollectionView
{
    CGFloat edge = 10.0f;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(edge, edge, edge, edge);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 3.0f;
    flowLayout.itemSize = CGSizeMake(48, 24);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SelectTopicCell class] forCellWithReuseIdentifier:kTopicCollectionViewCell];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    __weak typeof(self) weakSelf = self;
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{
        [[TopicService sharedInstance]requireNewTopicsWithBlock:^(NSError *error) {
            if (error == nil) {
                [weakSelf afterRefresh];
            }
        }];
    }];
    
    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        [[TopicService sharedInstance]requireMoreTopicsWithBlock:^(NSError *error) {
            if (error == nil) {
                [weakSelf afterRefresh];
            }
        }];
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(0.25);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pbTopicArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectTopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTopicCollectionViewCell forIndexPath:indexPath];
    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
    for (PBTopic *pbTopic in self.pbTopicArray) {
        [titleArray addObject:pbTopic.title];
    }
    cell.titleLabel.text = titleArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectTopicCell *cell = (SelectTopicCell *)[collectionView cellForItemAtIndexPath:indexPath];
    PBTopic *pbTopic = self.pbTopicArray[indexPath.row];
    if ([self.selectedPBTopicArray containsObject:pbTopic]) {
        [self.selectedPBTopicArray removeObject:pbTopic];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }else{
        [self.selectedPBTopicArray addObject:pbTopic];
        cell.contentView.backgroundColor = [UIColor greenColor];
    }
}


#pragma mark - Utils

- (void)afterRefresh
{
    self.pbTopicArray = [[TopicManager sharedInstance]pbTopicArray];
    [self.collectionView reloadData];
    if (self.collectionView.header.state != MJRefreshHeaderStateIdle) {
        [self.collectionView.header endRefreshing];
    }else if (self.collectionView.footer.state != MJRefreshHeaderStateIdle){
        [self.collectionView.footer endRefreshing];
    }
}

- (void)clickRightButton
{
    if (self.selectedPBTopicArray.count>0) {
        EXECUTE_BLOCK(self.selectTopicBlock,self.selectedPBTopicArray);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        POST_ERROR_MSG(@"请至少选择一个话题");
    }
}
@end
