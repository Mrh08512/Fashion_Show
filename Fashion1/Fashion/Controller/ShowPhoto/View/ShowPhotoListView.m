//
//  ShowPhotoListView.m
//  Fashion
//
//  Created by TangJR on 7/13/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ShowPhotoListView.h"
#import "ActivityViewController.h"
#import "AddressViewController.h"
#import "MomentViewController.h"
#import "RewardViewController.h"

@interface ShowPhotoListView ()

- (IBAction)activityButtonTapped:(UIButton *)sender;
- (IBAction)addressButtonTapped:(id)sender;
- (IBAction)momentButtonTapped:(id)sender;
- (IBAction)rewardButtonTapped:(id)sender;

@end

@implementation ShowPhotoListView

+ (instancetype)showPhotoList {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ShowPhotoListView" owner:nil options:nil] firstObject];
}

- (IBAction)activityButtonTapped:(UIButton *)sender {
    
    UIViewController *currentViewController = [self currentViewController];
    ActivityViewController *activityViewController = [ActivityViewController new];
    [currentViewController.navigationController pushViewController:activityViewController animated:YES];
}

- (IBAction)addressButtonTapped:(id)sender {
    
    UIViewController *currentViewController = [self currentViewController];
    AddressViewController *addressViewController = [AddressViewController new];
    [currentViewController.navigationController pushViewController:addressViewController animated:YES];
}

- (IBAction)momentButtonTapped:(id)sender {
    
    UIViewController *currentViewController = [self currentViewController];
    MomentViewController *momentViewController = [MomentViewController new];
    [currentViewController.navigationController pushViewController:momentViewController animated:YES];
}

- (IBAction)rewardButtonTapped:(id)sender {
    
    UIViewController *currentViewController = [self currentViewController];
    RewardViewController *rewardViewController = [RewardViewController new];
    [currentViewController.navigationController pushViewController:rewardViewController animated:YES];
}

@end