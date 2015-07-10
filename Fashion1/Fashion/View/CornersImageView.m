//
//  CornersImageView.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/9.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "CornersImageView.h"

@implementation CornersImageView


- (void)awakeFromNib
{
    self.layer.cornerRadius = self.bounds.size.width /2;
    self.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
