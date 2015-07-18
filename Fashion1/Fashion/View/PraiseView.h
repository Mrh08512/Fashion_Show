//
//  PraiseView.h
//  Fashion
//
//  Created by MRH-MAC on 15/7/18.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PraiseView : UIView

/*!
 *  @brief  点赞人数
 */
@property (nonatomic,strong) NSArray *praiseUser;

/*!
 *  @brief  添加一个点击按钮
 *
 *  @param title
 *  @param imageName 
 */
- (void)addClickButtonWithTitle:(NSString*)title selectImage:(NSString *)imageName;
@end
