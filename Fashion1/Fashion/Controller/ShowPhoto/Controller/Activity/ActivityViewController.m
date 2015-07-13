//
//  ActivityViewController.m
//  Fashion
//
//  Created by TangJR on 7/13/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"活动";
}

@end