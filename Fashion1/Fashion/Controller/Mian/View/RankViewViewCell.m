//
//  RankViewViewCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "RankViewViewCell.h"

@interface RankViewViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *testImage;

@end

@implementation RankViewViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setimageTest:(NSString *)imageName
{
    self.testImage.image = [UIImage imageNamed:imageName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
