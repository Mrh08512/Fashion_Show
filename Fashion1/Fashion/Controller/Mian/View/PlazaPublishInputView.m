//
//  PlazaPublishInputView.m
//  Fashion
//
//  Created by TangJR on 7/12/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "PlazaPublishInputView.h"

@implementation PlazaPublishInputView

+ (instancetype)inputView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"PlazaPublishInputView" owner:nil options:nil] firstObject];
}

@end