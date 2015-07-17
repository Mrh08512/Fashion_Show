//
//  RewardViewController.m
//  Fashion
//
//  Created by TangJR on 7/13/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "RewardViewController.h"
#import "RewardListTableViewCell.h"
#import "OfferRewardControllerViewController.h"

@interface RewardViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation RewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"悬赏";
}

- (void)setupUI {
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = 200;
    [tableView registerNib:[UINib nibWithNibName:@"RewardListTableViewCell" bundle:nil] forCellReuseIdentifier:@"RewardListTableViewCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self configCellWithIndexPath:indexPath];
}

- (RewardListTableViewCell *)configCellWithIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const identifer = @"RewardListTableViewCell";
    
    RewardListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifer];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OfferRewardControllerViewController *vc = [OfferRewardControllerViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end