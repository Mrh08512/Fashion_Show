//
//  PlazaPublishViewController.m
//  Fashion
//
//  Created by TangJR on 7/11/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "PlazaPublishViewController.h"

@interface PlazaPublishViewController ()

@property (weak, nonatomic) UIImageView *largePhotoImageView;

@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation PlazaPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - setup

- (void)setupPhotos {
    
    UIImageView *largePhotoImageView = [UIImageView new];
    largePhotoImageView.width = SCREEN_WIDTH;
    largePhotoImageView.height = 200;
    [self.view addSubview:largePhotoImageView];
}

#pragma mark - Private methods

#pragma mark - Lazy Load

- (NSMutableArray *)photos {
    
    if (!_photos) {
        
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

#pragma mark - Public methods

@end