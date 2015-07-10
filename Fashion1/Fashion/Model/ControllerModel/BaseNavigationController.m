//
//  BaseNavigationController.m
//  Love_Home
//
//  Created by MRH-MAC on 14-11-3.
//  Copyright (c) 2014年 MRH-MAC. All rights reserved.
//

#import "BaseNavigationController.h"
#import "MJRefresh.h"
@implementation BaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self)
    {
        self.navigationBar.translucent = YES;

    }
    return self;
}


#pragma mark - 初始化
+ (void)initialize
{
//    // 1.取出设置主题的对象
   UINavigationBar *navBar = [UINavigationBar appearance];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    navBar.tintColor = [UIColor whiteColor];
//
//    
//    // 3.设置导航栏标题颜色为白色
// 
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor blackColor]
                                     }];
//    [navBar setBarTintColor:[UIColor lightGrayColor]];
//    
//    // 4.设置导航栏按钮文字颜色为白色
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                      NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
                                      } forState:UIControlStateNormal];
//    navBar.translucent = YES;
//
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // 白色样式
    return UIStatusBarStyleLightContent;
}

@end
