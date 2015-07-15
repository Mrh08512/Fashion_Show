//
//  ActivityDetailHeadView.m
//  Fashion
//
//  Created by TangJR on 7/14/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityDetailHeadView.h"

@implementation ActivityDetailHeadView

+ (instancetype)activityDetailHeadView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ActivityDetailHeadView" owner:nil options:nil] firstObject];
}

@end
