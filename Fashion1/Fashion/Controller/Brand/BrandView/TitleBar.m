//
//  TitleBar.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "TitleBar.h"

@interface TitleBar ()

@property (nonatomic , strong) UIButton *currentBUtton;

@end

@implementation TitleBar

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if (!JudgeContainerCountIsNull(_titles)) {
        CGFloat width = (SCREEN_WIDTH - 16) / _titles.count;
        CGFloat height = self.bounds.size.height;
        for (int i = 0; i < _titles.count; i++ ) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.frame = CGRectMake(i * width,0, width,height);
            [button setTitle:_titles[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonpress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            // 默认选中
            if (i == 0)
            {
                [self buttonpress:button];
            }
        }
        for (int i = 1; i < _titles.count; i++ ) {
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0, 1, height)];
            lable.backgroundColor = [UIColor whiteColor];
            [self addSubview:lable];
            
        }
        // downLine
        UILabel *downLine = [[UILabel alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH , 1)];
        downLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:downLine];
        
    }

    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}


- (void)buttonpress:(UIButton *)sender
{
    _currentBUtton.selected = NO;
    sender.selected = YES;
    _currentBUtton = sender;
    
    if (_delegate && [_delegate respondsToSelector:@selector(titleBarClickButto:)] )
    {
        [_delegate titleBarClickButto:sender];
    }
}

- (void)setDelegate:(id<TitleBarDelegate>)delegate
{
    _delegate = delegate;
    [self buttonpress:_currentBUtton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
