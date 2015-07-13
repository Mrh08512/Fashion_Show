//
//  BrandViewCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "BrandViewCell.h"

@interface BrandViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bkImageView;


@end

@implementation BrandViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setDataSource:(id)data
{
    _bkImageView.image = [UIImage imageNamed:data];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
