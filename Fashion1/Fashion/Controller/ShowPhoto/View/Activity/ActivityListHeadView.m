//
//  ActivityListHeadView.m
//  Fashion
//
//  Created by TangJR on 7/14/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityListHeadView.h"

@implementation ActivityListHeadView

+ (instancetype)activityListHeadView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ActivityListHeadView" owner:nil options:nil] firstObject];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    UIView *view = [UIView new];
    view.height = 200 * TProportion();
    view.width = SCREEN_WIDTH;
    view.backgroundColor = [UIColor redColor];
    [self addSubview:view];
    
    UILabel *label = [UILabel new];
    label.y = view.height;
    label.width = 90;
    label.height = 50;
    label.text = @"  最热活动排行榜";
    label.font = TFontWithSize(11);
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    
    UIImage *image = [UIImage imageNamed:@"hot"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(label.width, view.height + 10, 24, 9);
    [self addSubview:imageView];
    
    UILabel *line = [UILabel new];
    line.width = self.width;
    line.height = 1;
    line.y = CGRectGetMaxY(label.frame);
    line.backgroundColor = [UIColor orangeColor];
    [self addSubview:line];
}

@end