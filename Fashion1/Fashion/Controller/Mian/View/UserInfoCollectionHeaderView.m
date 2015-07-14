//
//  UserInfoCollectionHeaderView.m
//  Huanxin
//
//  Created by 张亚东 on 15/7/13.
//  Copyright (c) 2015年 blurrys. All rights reserved.
//

#import "UserInfoCollectionHeaderView.h"

@interface UserInfoCollectionHeaderView ()

@property (strong , nonatomic) UIButton *currentButton;

//最大的背景模糊图
@property (weak, nonatomic) IBOutlet UIImageView *userBgImgView;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;

@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDescribeLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchLabel;

@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *fashionButton;
@property (weak, nonatomic) IBOutlet UIButton *puzzleButton;
@property (weak, nonatomic) IBOutlet UIButton *partyButton;

@property (weak, nonatomic) IBOutlet UIButton *popularButton;

@property (weak, nonatomic) IBOutlet UIButton *latestButton;

- (IBAction)handleMessageButton:(UIButton *)sender;
- (IBAction)handleInterestButton:(UIButton *)sender;

- (IBAction)handleFashionButton:(UIButton *)sender;

- (IBAction)handlePuzzleButton:(UIButton *)sender;

- (IBAction)handlePartyButton:(UIButton *)sender;

- (IBAction)handlePopularButton:(UIButton *)sender;

- (IBAction)handleLatestButton:(UIButton *)sender;

@end

@implementation UserInfoCollectionHeaderView

- (void)awakeFromNib {
    // Initialization code
    
    _userImgView.layer.cornerRadius = _userImgView.width/2;
    _userImgView.clipsToBounds = YES;
}

- (IBAction)handleMessageButton:(UIButton *)sender {
    [self.delegate userInfoCollectionHeaderViewDidMessageButtonPressed:sender];
}

- (IBAction)handleInterestButton:(UIButton *)sender {
    [self.delegate userInfoCollectionHeaderViewDidInterestButtonPressed:sender];
}

- (IBAction)handleFashionButton:(UIButton *)sender {
    
    [self selectButtonStatus:sender];
    if (_delegate && [_delegate respondsToSelector:@selector(userInfoCollectionHeaderViewDidFashionButtonPressed:)])
    {
        [self.delegate userInfoCollectionHeaderViewDidFashionButtonPressed:sender];
    }

    
}

- (IBAction)handlePuzzleButton:(UIButton *)sender {
    
    [self selectButtonStatus:sender];
    if (_delegate && [_delegate respondsToSelector:@selector(userInfoCollectionHeaderViewDidPuzzleButtonPressed:)])
    {
        [self.delegate userInfoCollectionHeaderViewDidPuzzleButtonPressed:sender];
    }

}

- (IBAction)handlePartyButton:(UIButton *)sender {
    
    [self selectButtonStatus:sender];
    if (_delegate && [_delegate respondsToSelector:@selector(userInfoCollectionHeaderViewDidPartyButtonPressed:)])
    {
        [self.delegate userInfoCollectionHeaderViewDidPartyButtonPressed:sender];
    }

}

- (IBAction)handlePopularButton:(UIButton *)sender {
    [self.delegate userInfoCollectionHeaderViewDidPopularButtonPressed:sender];
}

- (IBAction)handleLatestButton:(UIButton *)sender {
    [self.delegate userInfoCollectionHeaderViewDidPuzzleButtonPressed:sender];
}


// 改变button状态
- (void)selectButtonStatus:(UIButton *)sender
{
    _currentButton.enabled = YES;
    sender.enabled         = NO;
    _currentButton         = sender;
}

@end
