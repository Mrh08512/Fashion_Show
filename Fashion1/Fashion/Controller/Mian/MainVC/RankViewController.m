//
//  RankViewController.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "RankViewController.h"
#import "RankViewViewCell.h"
#define kRankCell @"RankViewViewCell"

@interface RankViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排名详情";
    [self initData];
    self.navigationItem.leftBarButtonItem = nil;
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.backgroundColor = [UIColor clearColor];
    table.tableFooterView = nil;
    table.delegate = self;
    table.dataSource = self;
    [table registerNib:[UINib nibWithNibName:@"RankViewViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kRankCell];
    self.myTableView = table;
    [self.view addSubview:_myTableView];
    
    // Do any additional setup after loading the view.
}

- (void)initData
{
    NSArray * arry = [[NSArray alloc] initWithObjects:@"排行_16",@"排行_20",@"排行_16",@"排行_20",@"排行_16",@"排行_20",@"排行_16",@"排行_20",@"排行_16",@"排行_20",@"排行_16",@"排行_20",@"排行_16",@"排行_20",@"排行_16",@"排行_20",nil];
    self.dataSource = arry;
}


#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RankViewViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRankCell];
    [cell.testButton setTitle:[NSString stringWithFormat:@"%ld",indexPath.row + 1] forState:UIControlStateNormal];
    [cell setimageTest:_dataSource[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
