//
//  PlazaPublishViewController.m
//  Fashion
//
//  Created by TangJR on 7/11/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "PlazaPublishViewController.h"
#import "PublishPhotoCollectionViewCell.h"
#import "DrawViewController.h"
#import "PlazaPublishInputView.h"
#import "UIBarButtonItem+InitFunctions.h"

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
    
    [self setupNavigation];
    [self setupUI];
}

#pragma mark - setup

- (void)setupNavigation {
    
    self.title = @"活动发布";
    self.navigationItem.leftBarButtonItem = nil;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightItemTapped:) imageName:@"check2" highlightedImageName:@"check2"];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupUI {
    
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
    
    PlazaPublishInputView *inputView = [PlazaPublishInputView inputView];
    inputView.y = CGRectGetMaxY(subPhotosCollectionView.frame);
    inputView.width = SCREEN_WIDTH;
    inputView.height = 370;
    [_scrollView addSubview:inputView];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(inputView.frame) + 10);
}

#pragma mark - Private methods

#pragma mark - Navigation Item Tapped

- (void)rightItemTapped:(UIButton *)sender {
    
    
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
    
    if (indexPath.row == [self.photos count] - 1) {
        
        DrawViewController *drawViewController = [DrawViewController new];
        [self.navigationController pushViewController:drawViewController animated:YES];
    }
}

#pragma mark - Lazy Load

- (NSMutableArray *)photos {
    
    if (!_photos) {
        
        _photos = [@[[UIImage imageNamed:@"ranking"], [UIImage imageNamed:@"ranking"], [UIImage imageNamed:@"ranking"]] mutableCopy];
    }
    return _photos;
}

#pragma mark - Public methods

@end