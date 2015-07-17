//
//  TitleBar.h
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleBarDelegate <NSObject>

- (void)titleBarClickButto:(UIButton *)button;

@end

@interface TitleBar : UIView

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) id<TitleBarDelegate>delegate;


@end
