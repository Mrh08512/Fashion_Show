//
//  UserInfoViewController.m
//  Huanxin
//
//  Created by 张亚东 on 15/7/13.
//  Copyright (c) 2015年 blurrys. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCollectionHeaderView.h"
#import "UserInfoCollectionCell.h"


#define kUserInfoCollectionCell @"UserInfoCollectionCell"
#define kUserInfoCollectionHeaderView @"UserInfoCollectionHeaderView"
@interface UserInfoViewController () <UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UserInfoCollectionHeaderViewDelegate>

@property (nonatomic , strong) UserInfoCollectionHeaderView *userInfoCollectionHeaderView;

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *imageData;

- (void)initializeAppearance;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"详细资料";
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initDataSource];
    [self initializeAppearance];
    
}


- (void)initDataSource
{
    self.imageData = [[NSMutableArray alloc] init];
    


    
    for (int i = 1; i < 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"m%d.jpg",i]];
        [_imageData addObject:image];
    }
}


- (void)initializeAppearance {
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_imageData count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UserInfoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUserInfoCollectionCell forIndexPath:indexPath];
    cell.bkImage.image = _imageData[indexPath.row];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.userInfoCollectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserInfoCollectionHeaderView forIndexPath:indexPath];
        self.userInfoCollectionHeaderView.delegate = self;
        
        return self.userInfoCollectionHeaderView;
    }
    else {
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.bounds.size.width, 300);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(174, 174 / 3 * 4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UserInfoCollectionHeaderViewDelegate
#warning warning
- (void)userInfoCollectionHeaderViewDidMessageButtonPressed:(UIButton *)sender {
    
}
- (void)userInfoCollectionHeaderViewDidInterestButtonPressed:(UIButton *)sender {
    
}
- (void)userInfoCollectionHeaderViewDidFashionButtonPressed:(UIButton *)sender {
    
}
- (void)userInfoCollectionHeaderViewDidPuzzleButtonPressed:(UIButton *)sender {
    
}
- (void)userInfoCollectionHeaderViewDidPartyButtonPressed:(UIButton *)sender {
    
}
- (void)userInfoCollectionHeaderViewDidPopularButtonPressed:(UIButton *)sender {
    
}
- (void)userInfoCollectionHeaderViewDidLatestButtonPressed:(UIButton *)sender {
    
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:kUserInfoCollectionCell bundle:nil] forCellWithReuseIdentifier:kUserInfoCollectionCell];
        [_collectionView registerNib:[UINib nibWithNibName:kUserInfoCollectionHeaderView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserInfoCollectionHeaderView];
    }
    return _collectionView;
}
@end
