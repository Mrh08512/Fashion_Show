//
//  BrandDetailModel.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/14.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "BrandDetailModel.h"
#import "NSString+ContentSize.h"
@implementation BrandDetailModel

+(CGFloat )hearHeightWithString:(NSString *)string
{
    // 详情高度
    CGSize size = [string stringContetenSizeWithFount:[UIFont systemFontOfSize:12] andSize:CGSizeMake(SCREEN_WIDTH - 20 - 13, MAXFLOAT)].size;
    
    
    CGFloat starHeight = size.height + 27 + SCREEN_WIDTH * 0.55 + 21 + 58 + 1;
    
    return starHeight;

}

@end
