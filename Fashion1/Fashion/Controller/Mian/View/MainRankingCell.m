//
//  MainRankingCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/7.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "MainRankingCell.h"

@interface MainRankingCell ()

@property (weak, nonatomic) IBOutlet UIButton *rightOneUser;
@property (weak, nonatomic) IBOutlet UIButton *rightTwoUser;
@property (weak, nonatomic) IBOutlet UIButton *firstUser;
@property (weak, nonatomic) IBOutlet UIButton *leftOneUser;
@property (weak, nonatomic) IBOutlet UIButton *leftTwoUser;


@end

@implementation MainRankingCell

- (void)awakeFromNib {
   
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    [self cornerRadius];
    // Initialization code
}

- (void)cornerRadius
{
    _rightOneUser.layer.cornerRadius = _rightOneUser.bounds.size.width /2;
    _rightTwoUser.layer.cornerRadius = _rightTwoUser.bounds.size.width /2;
    _firstUser.layer.cornerRadius = _firstUser.bounds.size.width /2;
    _leftOneUser.layer.cornerRadius = _leftOneUser.bounds.size.width /2;
    _leftTwoUser.layer.cornerRadius = _leftTwoUser.bounds.size.width /2;
    _rightOneUser.clipsToBounds = YES;
    _rightTwoUser.clipsToBounds = YES;
    _firstUser.clipsToBounds = YES;
    _leftOneUser.clipsToBounds = YES;
    _leftTwoUser.clipsToBounds = YES;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
