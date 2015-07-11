//
//  FashionPiazzaViewController.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/7.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "FashionPiazzaViewController.h"
#import "FashionPiazzaCell.h"
#import "ConmetsCellTableViewCell.h"
#import "PlazaPublishViewController.h"

@interface FashionPiazzaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *myTableView;
@property (nonatomic, strong)  NSMutableArray *detailDto;
@property (nonatomic, strong)  UIButton *relaseButton;

@end

@implementation FashionPiazzaViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title = @"一拼天下";
    self.navigationItem.leftBarButtonItem = nil;
   
    [self initDataSource];
    
    [self initFace];
    _relaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _relaseButton.center = CGPointMake(SCREEN_WIDTH/2, self.view.bounds.size.height - 50);
    [_relaseButton setImage:[UIImage imageNamed:@"发布按钮"] forState:UIControlStateNormal];
    [_relaseButton addTarget:self action:@selector(relaseProduct:) forControlEvents:UIControlEventTouchUpInside];
    _relaseButton.bounds = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:_relaseButton];

}

- (void)initDataSource
{
    _detailDto = [[NSMutableArray alloc] init];
}

- (void)initFace
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    UIImageView *bkView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bkView.image = [UIImage imageNamed:@"广场背景"];
    tableView.backgroundView = bkView;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate     = self;
    tableView.dataSource   = self;
    self.myTableView       = tableView;
    [_myTableView registerNib:[UINib nibWithNibName:@"FashionPiazzaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FashionPiazzaCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"ConmetsCellTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ConmetsCellTableViewCell"];
    [self.view addSubview:_myTableView];
    
   
}

- (void)relaseProduct:(UIButton *)button
{
    PlazaPublishViewController *plazaPublishVC = [PlazaPublishViewController new];
    [self.navigationController pushViewController:plazaPublishVC animated:YES];
}

#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return [_detailDto count];
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // 评论数
    return 1 + 3 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FashionPiazzaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FashionPiazzaCell"];
        
        return cell;
    } else {
        ConmetsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConmetsCellTableViewCell"];
        return cell;
    }
    
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 502;
    } else {
        return 50;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float newY = 0;
    static float oldY = 0;
    newY = scrollView.contentOffset.y;
    if (ABS(newY - oldY) > 30) {
        if (newY > oldY && newY > 1) {
            _relaseButton.hidden = NO;
        } else if (newY < oldY ){
            _relaseButton.hidden = YES;
        }
        oldY = newY;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
