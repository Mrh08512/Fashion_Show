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
@property (weak, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation PlazaPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

#pragma mark - setup

- (void)setupUI {
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    self.scrollView = scrollView;
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIImageView *largePhotoImageView = [UIImageView new];
    largePhotoImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:largePhotoImageView];
    self.largePhotoImageView = largePhotoImageView;
    
    [largePhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(64);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
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