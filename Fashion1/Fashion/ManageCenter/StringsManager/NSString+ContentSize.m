//
//  NSString+ContentSize.m
//  ScrollerViewPage
//
//  Created by MRH-MAC on 15/1/7.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "NSString+ContentSize.h"

@implementation NSString (ContentSize)

- (CGRect)stringContetenSizeWithFount:(UIFont *)font andSize:(CGSize)size
{
    CGRect rect;
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    rect  =  [self boundingRectWithSize:size options:options attributes:attributes context:nil];
    return rect;
}

@end
