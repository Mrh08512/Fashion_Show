
//
//  CustomImageScrollView.m
//  CustomPhoneImage
//
//  Created by MRH-MAC on 14/12/11.
//  Copyright (c) 2014年 MRH-MAC. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CustomImageScrollView : UIScrollView

@property (nonatomic, strong) UIImageView *zoomView;

- (void)displayImage:(UIImage *)image;

@end
