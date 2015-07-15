//
//  ActivityDetailViewController.m
//  Fashion
//
//  Created by TangJR on 7/14/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailHeadView.h"

@interface ActivityDetailViewController ()

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
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 10000);
    scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    scrollView.contentOffset = CGPointMake(0, -64);
    [self.view addSubview:scrollView];
    
    ActivityDetailHeadView *headView = [ActivityDetailHeadView activityDetailHeadView];
    headView.height = 200;
    headView.width = SCREEN_WIDTH;
    [scrollView addSubview:headView];
}

@end