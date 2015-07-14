//
//  BrandDetailControllerViewController.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "OfferRewardControllerViewController.h"
#import "WaterFlowLayout.h"
#import "NormolCollectionCell.h"
#import "TitleBar.h"
#import "BrandHearViewCell.h"
@interface OfferRewardControllerViewController ()

@property (nonatomic , strong) UICollectionView *contentView;

@end

@interface OfferRewardControllerViewController ()<UICollecitonViewDelegateWaterFlowLayout,UICollectionViewDataSourceWaterFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation OfferRewardControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initContentView];
    
    
    // Do any additional setup after loading the view.
}

- (void)initContentView
{
    self.navigationItem.leftBarButtonItem = nil;
    WaterFlowLayout *flowLayout  = [[WaterFlowLayout alloc] init];
    flowLayout.flowdatasource = self;
    flowLayout.flowdelegate    = self;
    flowLayout.startY            = 370;
    _contentView                 = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _contentView.delegate        = self;
    _contentView.dataSource      = self;
    [_contentView registerNib:[UINib nibWithNibName:@"NormolCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"NormolCollectionCell"];
    [self.view addSubview:_contentView];
    
     NSArray *shopInfoCellArray = [[NSBundle mainBundle] loadNibNamed:@"BrandHearViewCell" owner:self options:nil];
    
    
    BrandHearViewCell*hearView             = [shopInfoCellArray lastObject];
    hearView.frame = CGRectMake(0, 0, self.view.bounds.size.width, flowLayout.startY);
    hearView.titleBarView.titles = @[@"首页",@"已提交",@"入选",@"已获奖"];
    
    hearView.backgroundColor    = [UIColor redColor];
    [self.contentView addSubview:hearView];

}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return   10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NormolCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormolCollectionCell" forIndexPath:indexPath];
//
    cell.bkImage.image = [UIImage imageNamed:nil];
//
    return cell;
}





#pragma mark - UICollectionViewDelegate methods
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%d selected", indexPath.item);
}

#pragma mark-  UICollecitonViewDelegateWaterFlowLayout
- (CGFloat)flowLayout:(WaterFlowLayout *)flowView heightForRowAtIndex:(int)index
{
    

    return 10;
    
//    NSNumber *height = _itemFrams[index %7];
//    return [height floatValue];
    
    //    float height = 0;
    //	switch (index  % 5) {
    //		case 0:
    //			height = 127;
    //			break;
    //		case 1:
    //			height = 100;
    //			break;
    //		case 2:
    //			height = 87;
    //			break;
    //		case 3:
    //			height = 114;
    //			break;
    //		case 4:
    //			height = 140;
    //			break;
    //		case 5:
    //			height = 158;
    //			break;
    //		default:
    //			break;
    //	}
    
    //	return height;
}


#pragma mark- UICollectionViewDatasourceFlowLayout
- (NSInteger)numberOfColumnsInFlowLayout:(WaterFlowLayout*)flowlayout
{
    return 2;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
