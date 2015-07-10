//
//  FashionPiazzaCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/8.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "FashionPiazzaCell.h"
#import "CornersImageView.h"
@interface FashionPiazzaCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstaint;
@property (weak, nonatomic) IBOutlet CornersImageView *userImage;


@end

@implementation FashionPiazzaCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}
-(void)layoutSubviews
{
    [super layoutSubviews];
//    _imageConstaint.constant = SCREEN_WIDTH * ImageMultiplier(320, 250);
}

- (IBAction)focusOn:(id)sender {
    NSLog(@"22");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
