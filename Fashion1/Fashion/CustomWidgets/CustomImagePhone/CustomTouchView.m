//
//  CustomTouchView
//  CustomPhoneImage
//
//  Created by MRH-MAC on 14/12/11.
//  Copyright (c) 2014年 MRH-MAC. All rights reserved.
//

#import "CustomTouchView.h"

@implementation CustomTouchView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	if ([self pointInside:point withEvent:event]) {
		return self.receiver;
	}
	return nil;
}

@end
