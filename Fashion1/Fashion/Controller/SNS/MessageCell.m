//
//  MessageCell.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/15.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "MessageCell.h"
#import "CornersImageView.h"
@interface MessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *messageCount;
@property (weak, nonatomic) IBOutlet CornersImageView *userImage;

@end

@implementation MessageCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    _messageCount.layer.cornerRadius = _messageCount.bounds.size.width / 2;
    _messageCount.clipsToBounds = YES;
    // Initialization code
}

- (void)setDataSource:(id)dataSource
{
    _userImage.image = [UIImage imageNamed:dataSource];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
