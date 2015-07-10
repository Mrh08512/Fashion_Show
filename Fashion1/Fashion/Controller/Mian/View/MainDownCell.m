//
//  MainDownCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/7.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "MainDownCell.h"

@interface MainDownCell ()
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@end

@implementation MainDownCell

- (void)awakeFromNib {
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    // Initialization code
    _priceButton.layer.cornerRadius = _priceButton.bounds.size.width / 2;
    _priceButton.layer.borderColor  = [UIColor whiteColor].CGColor;
    _priceButton.layer.borderWidth  = 2.0f;
    
}

- (void)setDataSource:(id)dataSource
{
    
    
    [_bgImage setImage:[UIImage imageNamed:dataSource]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
