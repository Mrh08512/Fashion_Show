//
//  PlazaPublishViewController.m
//  Fashion
//
//  Created by TangJR on 7/11/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "PlazaPublishViewController.h"
#import "PublishPhotoCollectionViewCell.h"

@interface PlazaPublishViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UIImageView *largePhotoImageView;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UICollectionView *subPhotosCollectionView;

@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation PlazaPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

#pragma mark - setup

- (void)setupUI {
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.width = SCREEN_WIDTH;
    scrollView.height = SCREEN_HIGHT;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    scrollView.contentOffset = CGPointMake(0, -64);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIImageView *largePhotoImageView = [UIImageView new];
    largePhotoImageView.width = _scrollView.width;
    largePhotoImageView.height = 200 * TProportion();
    largePhotoImageView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:largePhotoImageView];
    self.largePhotoImageView = largePhotoImageView;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(60, 50);
    
    UICollectionView *subPhotosCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(largePhotoImageView.frame), SCREEN_WIDTH, 60) collectionViewLayout:layout];
    [subPhotosCollectionView registerClass:[PublishPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PublishPhotoCollectionViewCell"];
    subPhotosCollectionView.backgroundColor = [UIColor blueColor];
    subPhotosCollectionView.delegate = self;
    subPhotosCollectionView.dataSource = self;
    [_scrollView addSubview:subPhotosCollectionView];
    self.subPhotosCollectionView = subPhotosCollectionView;
}

#pragma mark - Private methods

#pragma mark - UICollecitonViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PublishPhotoCollectionViewCell *cell = [self configCellWithIndexPath:indexPath];
    
    return cell;
}

- (PublishPhotoCollectionViewCell *)configCellWithIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const identifier = @"PublishPhotoCollectionViewCell";
    
    PublishPhotoCollectionViewCell *cell = [self.subPhotosCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // 如果是最后一个cell，就显示+号
    if (indexPath.row == [self.photos count] - 1) {
        
        cell.imageView.image = [UIImage imageNamed:@"ranking"];
    } else {
        
        cell.imageView.image = [UIImage imageNamed:@"ranking"];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - Lazy Load

- (NSMutableArray *)photos {
    
    if (!_photos) {
        
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

#pragma mark - Public methods

@end