//
//  ActivityDetailRegisterCell.m
//  Fashion
//
//  Created by TangJR on 7/18/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityDetailRegisterCell.h"
#import "PublishPhotoCollectionViewCell.h"

@interface ActivityDetailRegisterCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *girlCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *boyCollection;

@end

@implementation ActivityDetailRegisterCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.girlCollection registerNib:[UINib nibWithNibName:@"PublishPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PublishPhotoCollectionViewCell"];
    [self.boyCollection registerNib:[UINib nibWithNibName:@"PublishPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PublishPhotoCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
