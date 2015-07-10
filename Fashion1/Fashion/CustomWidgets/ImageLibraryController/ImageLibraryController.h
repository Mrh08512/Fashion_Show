//
//  ImageLibraryController.h
//  LoveHome
//
//  Created by MRH-MAC on 14/12/4.
//  Copyright (c) 2014年 卡莱博尔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageLibraryController : UIImagePickerController

@property (nonatomic ,copy) void(^imageBlock)(UIImage *image);

- (id)initWithPickerType:(NSInteger )sourceType andScale:(CGFloat )scale;

@end
