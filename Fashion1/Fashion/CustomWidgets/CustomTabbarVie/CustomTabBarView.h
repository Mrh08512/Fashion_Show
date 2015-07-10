//
//  CustomTabBarView.h
//  Fashion
//
//  Created by MRH-MAC on 15/6/22.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^itemClick)(int from,int to);


@class CustomTabBarItem;

@protocol CustomTabBarViewDelegate <NSObject>

- (void)dock:(CustomTabBarItem *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface CustomTabBarView : UIView

@property (nonatomic, assign)id <CustomTabBarViewDelegate>delegate;


@end
