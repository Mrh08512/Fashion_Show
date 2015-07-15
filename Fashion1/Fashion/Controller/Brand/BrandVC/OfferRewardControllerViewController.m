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
#import "ImageLibraryController.h"
#import "PopContentView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface OfferRewardControllerViewController ()<UIActionSheetDelegate>

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
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheet showInView:self.view];
        
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
    NSMutableArray *photots = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_dataSource count] ; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image = _dataSource[i];
        [photots addObject:photo];
    }


    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photots; // 设置所有的图片
    browser.currentPhotoIndex = indexPath.row ; // 弹出相册时显示的第一张图片是？
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [browser show];
    });

    
}

#pragma mark-  UICollecitonViewDelegateWaterFlowLayout
- (CGFloat)flowLayout:(WaterFlowLayout *)flowView heightForRowAtIndex:(int)index
{
    UIImage *image = _dataSource[index];
    CGFloat proportion = image.size.height / image.size.width;
    
    return (SCREEN_WIDTH/2 - 10) * proportion;
    
}


#pragma mark- UICollectionViewDatasourceFlowLayout
- (NSInteger)numberOfColumnsInFlowLayout:(WaterFlowLayout*)flowlayout
{
    return 2;

}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        switch (buttonIndex) {
            case 0:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
                
            case 2:
                return;
                
        }
    }
    else {
        if (buttonIndex == 0 ) {
            NSLog(@"您的设备不支持照相功能");
            return;
        } else if (buttonIndex == 1)
        {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        } else if (buttonIndex == 2)
        {
            return;
        }
    }
    
    
    __weak OfferRewardControllerViewController *_mySelf = self;
    ImageLibraryController *vc = [[ImageLibraryController alloc] initWithPickerType:sourceType andScale:1.3];
    vc.imageBlock = ^(UIImage *image)
    {
        
        
    };
    [self presentViewController:vc animated:YES completion:nil];
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
