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
#import "ActivityDetailImagesCell.h"
#import "ActivityDetailCommentsBigCell.h"

static NSString * const headerIdentifier = @"ActivityDetailHeaderCell";
static NSString * const registerIdentifier = @"ActivityDetailRegisterCell";
static NSString * const contentIdentifier = @"ActivityDetailContentCell";
static NSString * const imagesIdentifier = @"ActivityDetailImagesCell";
static NSString * const commetnIdentifier = @"ActivityDetailCommentsBigCell";

@interface ActivityDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ActivityDetailContentCell *contentCell;

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
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerNib:[UINib nibWithNibName:@"ActivityDetailHeaderCell" bundle:nil] forCellReuseIdentifier:headerIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"ActivityDetailRegisterCell" bundle:nil] forCellReuseIdentifier:registerIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"ActivityDetailContentCell" bundle:nil] forCellReuseIdentifier:contentIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"ActivityDetailImagesCell" bundle:nil] forCellReuseIdentifier:imagesIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"ActivityDetailCommentsBigCell" bundle:nil] forCellReuseIdentifier:commetnIdentifier];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.contentCell = [tableView dequeueReusableCellWithIdentifier:contentIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self configCellWithIndexPath:indexPath];
}

- (UITableViewCell *)configCellWithIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    if (indexPath.section == 1) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:registerIdentifier];
    }
    if (indexPath.section == 2) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:contentIdentifier];
    }
    if (indexPath.section == 3) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:imagesIdentifier];
    }
    if (indexPath.section == 4) {
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:commetnIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 200;
    }
    if (indexPath.section == 1) {
        
        return 110;
    }
    if (indexPath.section == 2) {
        
        ActivityDetailContentCell *cell = self.contentCell;
        cell.translatesAutoresizingMaskIntoConstraints = NO;
        CGFloat defaultHeight = CGRectGetHeight(cell.frame);
        CGSize  size = [cell.contentLabel.text stringContetenSizeWithFount:cell.contentLabel.font andSize:CGSizeMake(cell.contentLabel.width, 10000)].size;
        CGFloat height =    (size.height - 16) > 0 ? size.height - 16  + defaultHeight : defaultHeight;
        return 1 + height;
    }
    if (indexPath.section == 3) {
        
        return 120;
    }
    return 400;
}

@end