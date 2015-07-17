//
//  ActivityDetailBodyView.m
//  Fashion
//
//  Created by TangJR on 7/16/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityDetailBodyView.h"
#import "PublishPhotoCollectionViewCell.h"

@interface ActivityDetailBodyView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *grilCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *boyCollection;

@end

@implementation ActivityDetailBodyView

+ (instancetype)activityDetailBodyView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ActivityDetailBodyView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.grilCollection registerNib:[UINib nibWithNibName:@"PublishPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PublishPhotoCollectionViewCell"];
    [self.boyCollection registerNib:[UINib nibWithNibName:@"PublishPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PublishPhotoCollectionViewCell"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const identifier = @"PublishPhotoCollectionViewCell";
    
    PublishPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    cell.imageView.image = [UIImage imageNamed:@"add_image"];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate



@end