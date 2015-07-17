//
//  RootViewController.m
//  Fashion
//
//  Created by MRH-MAC on 15/6/22.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "RootViewController.h"
#import "CustomTabBarView.h"
#import "MainViewController.h"
#import "BrandViewController.h"
#import "BaseNavigationController.h"
#import "ShowPhotoViewController.h"
#import "SnsViewController.h"
#import "UserCenterViewController.h"

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
@interface RootViewController () <UITabBarControllerDelegate, CustomTabBarViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BrandViewController *discover = [[BrandViewController alloc] init];
    [self addChildVc:discover title:@"品牌" image:@"品牌2" selectedImage:@"品牌1"];
    
    ShowPhotoViewController *messageCenter = [[ShowPhotoViewController alloc] init];
    [self addChildVc:messageCenter title:@"影秀" image:@"影缘2" selectedImage:@"影缘1"];
    
    MainViewController *home = [[MainViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"个人2" selectedImage:@"个人1"];

    SnsViewController *profile = [[SnsViewController alloc] init];
    [self addChildVc:profile title:@"社交" image:@"社交2" selectedImage:@"社交1"];
    
    UserCenterViewController *userCenter = [UserCenterViewController new];
    [self addChildVc:userCenter title:@"个人中心" image:@"个人2" selectedImage:@"个人1"];

///    [self configCustomTar];
    

    

}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = COLOR_CUSTOM(123, 123, 123, 1);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    BaseNavigationController  *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}



- (void)configCustomTar
{
    CustomTabBarView *tabBar = [[CustomTabBarView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-kDockHeight, SCREEN_WIDTH, kDockHeight)];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
    
}

- (void)dock:(CustomTabBarItem *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
