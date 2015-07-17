//
//  AddressViewController.m
//  Fashion
//
//  Created by TangJR on 7/13/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressListTableViewCell.h"
#import "AddressPublishViewController.h"
#import "UIBarButtonItem+InitFunctions.h"

@interface AddressViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"地点";
    
    
}

- (void)setupUI {
    
    UIView *headView = [UIView new];
    headView.height = 200;
    headView.width = SCREEN_WIDTH;
    headView.backgroundColor = [UIColor redColor];
    
    UITableView *tableView = [UITableView new];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    tableView.tableHeaderView = headView;
    tableView.showsVerticalScrollIndicator = NO;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"AddressListTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressListTableViewCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - Navigation Button Tapped

- (void)rightButtonAction:(UIButton *)sender {
    
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self configCellWithIndexPath:indexPath];
}

- (AddressListTableViewCell *)configCellWithIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const identifier = @"AddressListTableViewCell";
    
    AddressListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AddressPublishViewController *publishViewController = [AddressPublishViewController new];
    [self.navigationController pushViewController:publishViewController animated:YES];
}

@end