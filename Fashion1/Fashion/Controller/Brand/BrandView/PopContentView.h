//
//  PopContentView.h
//  Fashion
//
//  Created by MRH-MAC on 15/7/14.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopContentView : UIView

@property (nonatomic,strong) id detailSource;

@property (nonatomic,copy) void(^closeBlock)(void);
@end
