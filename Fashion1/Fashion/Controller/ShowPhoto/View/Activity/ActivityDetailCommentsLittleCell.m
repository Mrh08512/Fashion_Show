//
//  ActivityDetailCommentsLittleCell.m
//  Fashion
//
//  Created by TangJR on 7/19/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityDetailCommentsLittleCell.h"

@interface ActivityDetailCommentsLittleCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelWidthConstraint;

@end

@implementation ActivityDetailCommentsLittleCell

- (void)awakeFromNib {
    // Initialization code
    
    self.nameLabel.text = @"NSLayoutConstraint";
    CGSize size = TAutoLabelSize(self.nameLabel.text, CGSizeMake(200, self.nameLabel.height), self.nameLabel.font);
    self.nameLabelWidthConstraint.constant = size.width;
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
