//
//  BSJ_ModelViewController.m
//  BangBang
//
//  Created by Joe Chen on 9/12/13.
//  Copyright (c) 2013 卡莱博尔. All rights reserved.
//

#import "ModelViewController.h"

@interface ModelViewController ()

@end

@implementation ModelViewController
@synthesize myLeftButton                = _myLeftButton;
@synthesize myRightButton               = _myRightButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        /*左边按钮*/
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setFrame:CGRectMake(0, 0, 44.0f, 44.0f)];  //40.0f, 44.0f
        [leftButton setTitle:@"" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [leftButton setExclusiveTouch:YES];
        [leftButton setBackgroundColor:[UIColor clearColor]];
        [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIEdgeInsets leftEdge = leftButton.imageEdgeInsets;
        leftEdge.right = 17;
        [leftButton setImageEdgeInsets:leftEdge];
        self.myLeftButton = leftButton;
        [leftButton setHidden:YES];
        
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        [self.navigationItem setLeftBarButtonItem:leftButtonItem];
//        [leftButtonItem release];
        
        /*右边按钮*/
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
        [rightButton setTitle:@"" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        UIEdgeInsets rightEdge = rightButton.imageEdgeInsets;
        rightEdge.left = 17;
        [rightButton setImageEdgeInsets:rightEdge];
        [rightButton setExclusiveTouch:YES];
        [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setHidden:YES];
        self.myRightButton = rightButton;
        
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        [self.navigationItem setRightBarButtonItem:rightButtonItem];
//        [rightButtonItem release];
        
        self.automaticallyAdjustsScrollViewInsets = YES;

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

#pragma mark - PrivateMethods
#pragma mark leftItem Action
- (void)leftButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark rightItem Action
- (void)rightButtonAction:(UIButton *)sender
{
    
}


// 使用了automaticallyAdjustsScrollViewInsets(只对ScrollView启用) 自动计算控制器高度 无需调用此方法
- (void)screenHeihtTabNar
{
    CGFloat height = SCREEN_HIGHT -kDockHeight ;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
}

#pragma mark - MemoryManager

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
