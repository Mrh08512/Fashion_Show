//
//  ActivityViewController.m
//  Fashion
//
//  Created by TangJR on 7/13/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityListHeadView.h"
#import "ActivityListTableViewCell.h"
#import "ActivityDetailViewController.h"

@interface ActivityViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"活动";
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupUI {
    
    UIImageView *bkView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bkView.image = [UIImage imageNamed:@"广场背景"];
    [self.view addSubview:bkView];
    
    ActivityListHeadView *headView = [[ActivityListHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200 * TProportion() + 50)];
    headView.backgroundColor = [UIColor clearColor];
    
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = headView;
    [tableView registerNib:[UINib nibWithNibName:@"ActivityListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ActivityListTableViewCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kDockHeight);
    }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListTableViewCell *cell = [self configCellWithIndexPath:indexPath];
    return cell;
}

- (ActivityListTableViewCell *)configCellWithIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const identifier = @"ActivityListTableViewCell";
    ActivityListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ActivityDetailViewController *activityDetailViewController = [ActivityDetailViewController new];
    activityDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:activityDetailViewController animated:YES];
}

@end