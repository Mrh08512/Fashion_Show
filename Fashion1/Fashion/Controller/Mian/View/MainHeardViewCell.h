//
//  MainHeardViewCell.h
//  Fashion
//
//  Created by MRH-MAC on 15/7/7.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHeardViewCell : UITableViewCell

@property (nonatomic , copy) void(^fashionPiaBlock)(void);
@property (nonatomic , copy) void(^pullzeBlock)(void);
@property (nonatomic , copy) void(^rankingBlock)(void);

@end
