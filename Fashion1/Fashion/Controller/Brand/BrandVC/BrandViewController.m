//
//  BrandViewController.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/13.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandViewCell.h"
#import "OfferRewardControllerViewController.h"

@interface BrandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initContentView];

    // Do any additional setup after loading the view.
}

#pragma mark - privateFuction

- (void)initData
{
    _data = [[NSArray alloc] initWithObjects:@"轮播0",@"轮播1",@"轮播2",@"品牌_03",@"品牌_06",@"品牌_07",@"品牌_08",nil];
    
}


- (void)initContentView
{
    
    self.navigationItem.title                               = @"品牌";
    self.navigationController.navigationBar.backgroundColor = [UIColor darkGrayColor];
    UITableView * tableView                                 = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle                                = UITableViewCellSeparatorStyleNone;
    tableView.delegate                                      = self;
    tableView.dataSource                                    = self;
    tableView.backgroundColor                               = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator                  = NO;
    self.myTableView                                        = tableView;
    
    [_myTableView registerNib:[UINib nibWithNibName:@"BrandViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BrandViewCell"];
   
    
    [self.view addSubview:_myTableView];
    
}



#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"BrandViewCell";
    BrandViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    [cell setDataSource:_data[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OfferRewardControllerViewController *vc = [[OfferRewardControllerViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
