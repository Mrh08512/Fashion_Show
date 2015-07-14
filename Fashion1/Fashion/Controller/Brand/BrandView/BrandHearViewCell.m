//
//  BrandHearViewCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "BrandHearViewCell.h"
#import "NSString+ContentSize.h"



@interface BrandHearViewCell ()
@property (weak, nonatomic) IBOutlet UIView *secondContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conteViewHeightConstraint;


@end

@implementation BrandHearViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHeardData:(id)heardData
{
    _heardData = heardData;
    
    
    CGSize size = [_detailContent.text stringContetenSizeWithFount:[UIFont systemFontOfSize:12] andSize:CGSizeMake(kLableWidth , MAXFLOAT)].size;
    _conteViewHeightConstraint.constant = size.height + 27 +5;
    [self setNeedsLayout];
    
}
- (IBAction)lookDetail:(id)sender
{
    if (_lookDetai) {
        _lookDetai();
    }
}

- (IBAction)submitPhoto:(id)sender
{
    if (_submitPhoto) {
        _submitPhoto();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
