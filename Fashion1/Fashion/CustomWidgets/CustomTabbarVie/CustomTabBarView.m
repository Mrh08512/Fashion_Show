//
//  CustomTabBarView.m
//  Fashion
//
//  Created by MRH-MAC on 15/6/22.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "CustomTabBarView.h"
#import "CustomTabBarItem.h"
@interface CustomTabBarView ()
@property (nonatomic,strong) CustomTabBarItem *selectedItem;

@end

@implementation CustomTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}


- (void)initView
{

    self.backgroundColor = [UIColor clearColor];
    UIView *bkView         = [[UIView alloc] initWithFrame:self.bounds];
    bkView.backgroundColor = [UIColor blackColor];
    bkView.alpha           = 0.3;
    [self addSubview:bkView];

    // 写死布局

    NSArray *titles     = @[@"12",@"2",@"3",@"4",@"5"];
    NSArray *tabIcon    = @[@"icon_tabbar_main_nomal",@"icon_tabbar_me_nomal",@"icon_tabbar_message_nomal",
                            @"icon_tabbar_urgent_nomal",@"tab-gd-up"];
    
    NSArray *seletIcon  = @[@"icon_tabbar_main_down",@"icon_tabbar_me_down",@"icon_tabbar_message_down",
                              @"icon_tabbar_urgent_down"
                            ,@"tab-gd-down"];
    CGFloat kTabWidth = SCREEN_WIDTH / titles.count;
    for (int i = 0; i<titles.count; i++) {
        
        CustomTabBarItem *button = [[CustomTabBarItem alloc] init];
        button.frame = CGRectMake(i *kTabWidth,0,kTabWidth, self.bounds.size.height);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:tabIcon[i]]    forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:seletIcon[i]]  forState:UIControlStateSelected];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag   = i;
        [self addSubview:button];
        
        // 初始选择控制器
        if (i == 0) {
            [self itemClick:button];
        }
    }
    
}

- (void)itemClick:(CustomTabBarItem *)item
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)])
    {
        [_delegate dock:item itemSelectedFrom:_selectedItem.tag to:item.tag];
    }
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
