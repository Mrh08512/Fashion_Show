//
//  PraiseView.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/18.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "PraiseView.h"
#define kButtonWitdh 60
#define kSpace (self.width -  20 - (kButtonWitdh * _clickButtonList.count)) / (_clickButtonList.count - 1)
@interface PraiseView ()

@property (nonatomic, strong) UIImageView  *showPraiseImageView;
@property (nonatomic, strong) UIView  *showUserView;
@property (nonatomic, strong) NSMutableArray *clickButtonList;
@end

@implementation PraiseView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 点赞图片
        UIImageView *showPraise = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"想去"]];
        showPraise.backgroundColor = [UIColor blackColor];
        self.showPraiseImageView = showPraise;
        [self addSubview:_showPraiseImageView];
        
        // 点赞用户
        _showUserView  = [[UIView alloc] init];
        _showUserView.backgroundColor = [UIColor redColor];
        [self addSubview:_showUserView];
        
        _clickButtonList = [[NSMutableArray alloc] init];
    }
    return self;
    
}

- (void)addClickButtonWithTitle:(NSString*)title selectImage:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [_clickButtonList addObject:button];
    
}


- (void)buttonClick:(UIButton *)sender
{
    // 代理传出
    
}
     
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat starx = 10;
    CGFloat stary = 5;
    CGFloat endY = 10;
    
//    CGFloat space =  (self.width - starx*2) / _clickButtonList.count;
//    300 - （50*30） /2
//    (self.width - 40 - (kButtonWitdh * _clickButtonList.count)) / (_clickButtonList.count - 1)

    

    
    for (int i = 0; i<_clickButtonList.count; i ++) {
        UIButton *button = _clickButtonList[i];
        button.x = starx;
        button.y = stary;
        button.width = kButtonWitdh;
        button.height = button.titleLabel.font.lineHeight + 1;
        starx = starx + kSpace + button.width;
        endY = stary + button.height;
    }

    // showImage
    _showPraiseImageView.x = 20;
    _showPraiseImageView.y = _showUserView.y = endY + 10 ;
    _showPraiseImageView.width = _showPraiseImageView.height = 30;
    
    // showUser
    _showUserView.x = _showPraiseImageView.x + _showPraiseImageView.width + 5;
    _showUserView.y = _showPraiseImageView.y;
    _showUserView.width = self.width - _showUserView.x;
    _showUserView.height = _showPraiseImageView.height;
    _showUserView.backgroundColor = [UIColor redColor];
    NSString *string =  NSStringFromCGRect(_showUserView.frame);
    NSLog(@"%@",string);


    
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
