//
//  AddressListInputView.m
//  Fashion
//
//  Created by TangJR on 7/17/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "AddressListInputView.h"

@implementation AddressListInputView

+ (instancetype)inputView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"AddressListInputView" owner:nil options:nil] firstObject];
}

@end
