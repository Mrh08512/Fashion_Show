//
//  BSJ_ModelViewController.h
//  BangBang
//
//  Created by Joe Chen on 9/12/13.
//  Copyright (c) 2013 卡莱博尔. All rights reserved.
//
/*
 *  此类是modelViewController
 *
 *  Discussion:
 *
 *  1、自定义navgationBar的leftItem和rightItem
 */

#import <UIKit/UIKit.h>

@interface ModelViewController : UIViewController
{

}


/*navBar left and right item*/
@property (retain, nonatomic) UIButton                  *myLeftButton;
@property (retain, nonatomic) UIButton                  *myRightButton;


/*
 * NavigationBar的leftItem点击事件
 */
- (void)leftButtonAction:(UIButton *)sender;
/*
 * NavigationBar的rightItem点击事件
 */
- (void)rightButtonAction:(UIButton *)sender;

- (void)screenHeihtTabNar;

@end
