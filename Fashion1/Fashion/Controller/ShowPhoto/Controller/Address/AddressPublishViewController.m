//
//  AddressPublishViewController.m
//  Fashion
//
//  Created by TangJR on 7/17/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "AddressPublishViewController.h"
#import "PublishPhotoCollectionViewCell.h"
#import "AddressListInputView.h"

@interface AddressPublishViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UIImageView *largePhotoImageView;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UICollectionView *subPhotosCollectionView;

@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation AddressPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *bkView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bkView.image = [UIImage imageNamed:@"广场背景"];
    [self.view addSubview:bkView];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.width = SCREEN_WIDTH;
    scrollView.height = SCREEN_HIGHT;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    scrollView.contentOffset = CGPointMake(0, -64);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIImageView *largePhotoImageView = [UIImageView new];
    largePhotoImageView.width = _scrollView.width;
    largePhotoImageView.height = 200 * TProportion();
    [_scrollView addSubview:largePhotoImageView];
    self.largePhotoImageView = largePhotoImageView;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 7;
    layout.minimumInteritemSpacing = 7;
    layout.itemSize = CGSizeMake(102, 80);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *subPhotosCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(largePhotoImageView.frame), SCREEN_WIDTH, 90) collectionViewLayout:layout];
    [subPhotosCollectionView registerNib:[UINib nibWithNibName:@"PublishPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PublishPhotoCollectionViewCell"];
    subPhotosCollectionView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 80);
    subPhotosCollectionView.backgroundColor = [UIColor clearColor];
    subPhotosCollectionView.delegate = self;
    subPhotosCollectionView.dataSource = self;
    [_scrollView addSubview:subPhotosCollectionView];
    self.subPhotosCollectionView = subPhotosCollectionView;
    
    AddressListInputView *inputView = [AddressListInputView inputView];
    inputView.y = CGRectGetMaxY(subPhotosCollectionView.frame);
    inputView.width = SCREEN_WIDTH;
    inputView.height = 190;
    [_scrollView addSubview:inputView];
    
    NSLog(@"%lf, %lf", inputView.height + inputView.y, CGRectGetMaxY(inputView.frame));
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(inputView.frame) + kDockHeight);
    NSLog(@"%@", _scrollView);
}

#pragma mark - UICollecitonViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PublishPhotoCollectionViewCell *cell = [self configCellWithIndexPath:indexPath];
    
    return cell;
}

- (PublishPhotoCollectionViewCell *)configCellWithIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const identifier = @"PublishPhotoCollectionViewCell";
    
    PublishPhotoCollectionViewCell *cell = [self.subPhotosCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    
    // 如果是最后一个cell，就显示+号
    if (indexPath.row == [self.photos count] - 1) {
        
        cell.imageView.image = [UIImage imageNamed:@"add_image"];
    } else {
        
        self.largePhotoImageView.image = self.photos[0];
        cell.imageView.image = self.photos[indexPath.row + 1];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - Lazy Load

- (NSMutableArray *)photos {
    
    if (!_photos) {
        
        _photos = [@[[UIImage imageNamed:@"ranking"], [UIImage imageNamed:@"ranking"], [UIImage imageNamed:@"ranking"]] mutableCopy];
    }
    return _photos;
}

@end