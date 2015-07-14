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
#import "NSString+ContentSize.h"
#import "BrandDetailModel.h"
#import "PopContentView.h"
@interface OfferRewardControllerViewController ()

@property (nonatomic , strong) UICollectionView *contentView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@interface OfferRewardControllerViewController ()<UICollecitonViewDelegateWaterFlowLayout,UICollectionViewDataSourceWaterFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation OfferRewardControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self  initData];
    [self initContentView];
    
    
    // Do any additional setup after loading the view.
}

- (void)initData
{
    self.dataSource  =[NSMutableArray array];
    for (int i = 1; i<8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"p%d",i]];
        [self.dataSource addObject:image];
    }
    
}

- (void)initContentView
{
    self.navigationItem.leftBarButtonItem = nil;
    
    // 获取内容高度
    
    
    NSArray *shopInfoCellArray   = [[NSBundle mainBundle] loadNibNamed:@"BrandHearViewCell" owner:self options:nil];
    BrandHearViewCell*hearView   = [shopInfoCellArray lastObject];
    hearView.heardData           = @"测试";
    CGFloat starHeight           = [BrandDetailModel hearHeightWithString:hearView.detailTextLabel.text];
    hearView.frame               = CGRectMake(0, 0, self.view.bounds.size.width, starHeight);
    hearView.titleBarView.titles = @[@"首页",@"已提交",@"入选",@"已获奖"];
    
    //
    hearView.lookDetai = ^
    {
        PopContentView *pop = [[PopContentView alloc]initWithFrame:CGRectMake(10, 80, self.view.width - 20, self.view.height - 120)];
        pop.backgroundColor = [UIColor redColor];
        pop.detailSource = @"";
        pop.alpha = 0;
        [pop setTransform:CGAffineTransformMakeScale(0, 0)];
        __weak PopContentView *blockpop = pop;
        pop.closeBlock = ^{
          
            [blockpop removeFromSuperview];
        };
        [self.view addSubview:pop];
        
        [UIView animateWithDuration:0.4 animations:^{
            blockpop.alpha = 1;
            blockpop.transform = CGAffineTransformIdentity;
        }];

    };
    hearView.submitPhoto = ^
    {
        
    };
    
    WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] init];
    flowLayout.flowdatasource   = self;
    flowLayout.flowdelegate     = self;
    flowLayout.startY           = starHeight;
    _contentView                = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _contentView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"悬赏详情背景"]];
    _contentView.delegate       = self;
    _contentView.dataSource     = self;
    [_contentView registerNib:[UINib nibWithNibName:@"NormolCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"NormolCollectionCell"];
    [self.view addSubview:_contentView];
    
    [self.contentView addSubview:hearView];

    }

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return   [_dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NormolCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormolCollectionCell" forIndexPath:indexPath];
//
    cell.bkImage.image = _dataSource[indexPath.row];
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
    UIImage *image = _dataSource[index];
    CGFloat proportion = image.size.height / image.size.width;
    
    return (SCREEN_WIDTH/2 - 10) * proportion;
    
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
