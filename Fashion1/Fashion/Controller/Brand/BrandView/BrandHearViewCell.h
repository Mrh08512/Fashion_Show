//
//  BrandHearViewCell.h
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleBar.h"
#define kLableWidth SCREEN_WIDTH - 20 - 13


@interface BrandHearViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet TitleBar *titleBarView;
@property (weak, nonatomic) IBOutlet UILabel *detailContent;
@property (nonatomic , strong) id heardData;
@property (nonatomic,copy) void(^lookDetai)(void);
@property (nonatomic,copy) void(^submitPhoto)(void);

@end
