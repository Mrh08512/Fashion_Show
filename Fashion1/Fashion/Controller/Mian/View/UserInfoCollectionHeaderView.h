//
//  UserInfoCollectionHeaderView.h
//  Huanxin
//
//  Created by 张亚东 on 15/7/13.
//  Copyright (c) 2015年 blurrys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoCollectionHeaderViewDelegate <NSObject>

- (void)userInfoCollectionHeaderViewDidMessageButtonPressed:(UIButton *)sender;
- (void)userInfoCollectionHeaderViewDidInterestButtonPressed:(UIButton *)sender;
- (void)userInfoCollectionHeaderViewDidFashionButtonPressed:(UIButton *)sender;
- (void)userInfoCollectionHeaderViewDidPuzzleButtonPressed:(UIButton *)sender;
- (void)userInfoCollectionHeaderViewDidPartyButtonPressed:(UIButton *)sender;
- (void)userInfoCollectionHeaderViewDidPopularButtonPressed:(UIButton *)sender;
- (void)userInfoCollectionHeaderViewDidLatestButtonPressed:(UIButton *)sender;

@end

@interface UserInfoCollectionHeaderView : UICollectionReusableView

@property (nonatomic , assign) id<UserInfoCollectionHeaderViewDelegate> delegate;

@end
