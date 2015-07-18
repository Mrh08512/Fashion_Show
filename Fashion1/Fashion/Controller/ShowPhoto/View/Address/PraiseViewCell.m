//
//  PraiseViewCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/18.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "PraiseViewCell.h"
#import "PraiseView.h"

@interface PraiseViewCell ()
@property (weak, nonatomic) IBOutlet UIView *contView;
@property (nonatomic,strong) PraiseView *prasiView;
@end
@implementation PraiseViewCell

- (void)awakeFromNib {

    
    _prasiView= [[PraiseView alloc] init];
    _prasiView.backgroundColor = [UIColor clearColor];
    [self.contView addSubview:_prasiView];
    [_prasiView addClickButtonWithTitle:@"想去" selectImage:@"评论"];
    [_prasiView addClickButtonWithTitle:@"评论" selectImage:@"举报"];
    [_prasiView addClickButtonWithTitle:@"关注" selectImage:@"评论"];
    [_prasiView addClickButtonWithTitle:@"举报" selectImage:@"举报"];

    
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _prasiView.frame = _contView.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
