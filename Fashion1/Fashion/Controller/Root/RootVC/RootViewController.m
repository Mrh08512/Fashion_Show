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
@interface RootViewController ()<UITabBarControllerDelegate,CustomTabBarViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewControllersArray = [[NSMutableArray alloc] initWithCapacity:3];

    MainViewController *vc1 = [[MainViewController alloc] init];
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
     UIViewController *vc2 = [[UIViewController alloc] init];
    BrandViewController *vc5 = [[BrandViewController alloc] init];
     BaseNavigationController *nav5 = [[BaseNavigationController alloc] initWithRootViewController:vc5];
   
    
   
    
    [viewControllersArray addObject:nav1];
    [viewControllersArray addObject:vc2];
    [viewControllersArray addObject:nav5];
    
    self.viewControllers = viewControllersArray;
    
    UITabBarItem *mainItem  = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *orderItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *cartItem  = [self.tabBar.items objectAtIndex:2];
    
    [mainItem setImage:[[UIImage imageNamed:@"icon_tabbar_main_nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mainItem setSelectedImage:[[UIImage imageNamed:@"icon_tabbar_main_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    [orderItem setImage:[[UIImage imageNamed:@"icon_tabbar_urgent_nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [orderItem setSelectedImage:[[UIImage imageNamed:@"icon_tabbar_urgent_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    [cartItem setImage:[[UIImage imageNamed:@"icon_tabbar_urgent_nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [cartItem setSelectedImage:[[UIImage imageNamed:@"icon_tabbar_urgent_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];


    //
//    [self configCustomTar];
    

    

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
