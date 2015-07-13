//
//  ShowPhotoViewController.m
//  Fashion
//
//  Created by TangJR on 7/13/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ShowPhotoViewController.h"

@interface ShowPhotoViewController ()

@end

@implementation ShowPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"影秀";
}

@end