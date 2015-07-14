//
//  PopContentView.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/14.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "PopContentView.h"

@interface PopContentView ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UILabel *titleLable;
@property (nonatomic , strong) UILabel *contentLable;
@property (nonatomic , strong) UIView   *buyView;
@property (nonatomic , strong) UIButton *closeButton;

@end

@implementation PopContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 1.UIScollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        // 去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        // 去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
//        // 2.pageControl
//        UIPageControl *pageControl = [[UIPageControl alloc] init];
//        // 当只有1页时，自动隐藏pageControl
//        pageControl.hidesForSinglePage = YES;
//        pageControl.userInteractionEnabled = NO;

    }
    return self;
}


- (void)setDetailSource:(id)detailSource
{
    _detailSource         = detailSource;

    UIButton *close       = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setTitle:@"X" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton      = close;


    UILabel *title        = [[UILabel alloc] init];
    title.text            = @"Textures&Backgtouds";
    title.numberOfLines   = 0;
    title.font            = [UIFont systemFontOfSize:14];
    self.titleLable       = title;

    UIView *buy           = [[UIView alloc] init];
    buy.backgroundColor   = [UIColor darkGrayColor];
    self.buyView          = buy;
    UILabel *content      = [[UILabel alloc] init];
    content.text          = @"Mark local variables of type 'id' or pointer-to-ObjC-object-type so that values stored into that local variable are not aggressively released by the compiler during optimization, but are held until either the variable is assigned to again, or the end of the scope (such as a compound statement, or method definition) of the local variable.";
    content.numberOfLines = 0;
    content.font          = [UIFont systemFontOfSize:12];
    self.contentLable     = content;

    [self addSubview:_closeButton];
    [self addSubview:_titleLable];
    [self addSubview:_buyView];
    [self addSubview:_contentLable];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.width = self.width;
    self.scrollView.height = self.height;
    self.scrollView.x = self.scrollView.y = 0;
    
    self.closeButton.width = self.closeButton.height = 30;
    self.closeButton.x = self.width - 45;
    self.closeButton.y = 10;
    
    self.titleLable.x = 10;
    self.titleLable.y = _closeButton.y + 8;
    self.titleLable.width = self.width - 20;
    self.titleLable.height = [self.titleLable.text stringContetenSizeWithFount:self.titleLable.font andSize:CGSizeMake(self.titleLable.width, MAXFLOAT)].size.height;
    
    self.buyView.x = 10;
    self.buyView.y = self.titleLable.y + self.titleLable.height;
    self.buyView.width = self.titleLable.width;
    self.buyView.height = 30;
    
    self.contentLable.x = 10;
    self.contentLable.y = self.buyView.y + self.buyView.height;
    self.contentLable.width = self.titleLable.width;
    self.contentLable.height = [self.contentLable.text stringContetenSizeWithFount:self.contentLable.font andSize:CGSizeMake(self.contentLable.width, MAXFLOAT)].size.height;
    
    self.scrollView.contentSize = CGSizeMake(self.width, self.contentLable.y + self.contentLable.height + 10);
    
}

- (void)close:(UIButton *)sender
{
    if (_closeBlock) {
        _closeBlock();
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
