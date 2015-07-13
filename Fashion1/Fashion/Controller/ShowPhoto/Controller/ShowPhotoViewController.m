//
//  ShowPhotoViewController.m
//  Fashion
//
//  Created by TangJR on 7/13/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ShowPhotoViewController.h"
#import "ShowPhotoListView.h"

@interface ShowPhotoViewController ()

@end

@implementation ShowPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"影秀";
}

- (void)setupUI {
    
    ShowPhotoListView *listView = [ShowPhotoListView showPhotoList];
    listView.bounds = self.view.bounds;
    listView.x = 0;
    [self.view addSubview:listView];
}

@end