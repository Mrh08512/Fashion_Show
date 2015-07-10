//
//  MainHeardViewCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/7.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "MainHeardViewCell.h"

@interface MainHeardViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *fashionPia;
@property (weak, nonatomic) IBOutlet UIButton *pullze;
@property (weak, nonatomic) IBOutlet UIButton *ranking;

@end

@implementation MainHeardViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
     [_fashionPia   addTarget:self action:@selector(fashionPia:)
             forControlEvents:UIControlEventTouchUpInside];
     [_pullze       addTarget:self action:@selector(pullze:)
             forControlEvents:UIControlEventTouchUpInside];
     [_ranking      addTarget:self action:@selector(ranking:)
             forControlEvents:UIControlEventTouchUpInside];
}


- (void)fashionPia:(UIButton *)sender
{
    if (_fashionPiaBlock ) {
        _fashionPiaBlock();
    }
}

- (void)pullze:(UIButton *)sender
{
    if (_pullzeBlock) {
        _pullzeBlock();
    }
}

- (void)ranking:(UIButton *)sender
{
    if (_rankingBlock) {
        _rankingBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
