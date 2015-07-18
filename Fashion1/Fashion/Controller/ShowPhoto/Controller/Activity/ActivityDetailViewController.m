//
//  ActivityDetailViewController.m
//  Fashion
//
//  Created by TangJR on 7/14/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailHeaderCell.h"
#import "ActivityDetailRegisterCell.h"
#import "ActivityDetailContentCell.h"

static NSString * const headerIdentifer = @"ActivityDetailHeaderCell";
static NSString * const registerIdentifer = @"ActivityDetailRegisterCell";
static NSString * const contentIdentifer = @"ActivityDetailContentCell";

@interface ActivityDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"活动详情";
}

- (void)setupUI {
    
    UIImageView *bkView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bkView.image = [UIImage imageNamed:@"广场背景"];
    [self.view addSubview:bkView];
    
    UITableView *tableView = [UITableView new];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [tableView registerNib:[UINib nibWithNibName:@"ActivityDetailHeaderCell" bundle:nil] forCellReuseIdentifier:headerIdentifer];
    [tableView registerNib:[UINib nibWithNibName:@"ActivityDetailRegisterCell" bundle:nil] forCellReuseIdentifier:registerIdentifer];
    [tableView registerNib:[UINib nibWithNibName:@"ActivityDetailContentCell" bundle:nil] forCellReuseIdentifier:contentIdentifer];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self configCellWithIndexPath:indexPath];
}

- (UITableViewCell *)configCellWithIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:headerIdentifer];
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    if (indexPath.section == 1) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:registerIdentifer];
    }
    if (indexPath.section == 2) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:contentIdentifer];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 200;
    }
    if (indexPath.section == 1) {
        
        return 110;
    }
    return 200;
}

@end