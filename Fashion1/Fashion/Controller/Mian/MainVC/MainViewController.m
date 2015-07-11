//
//  MainViewController.m
//  Fashion
//
//  Created by MRH-MAC on 15/6/22.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "MainViewController.h"
#import "MainHeardViewCell.h"
#import "MainRankingCell.h"
#import "MainDownCell.h"
#import "FashionPiazzaViewController.h"

#define  kHeardCell1 @"MainHeardViewCell"
#define  kHeardCellRanking @"MainRankingCell"
#define  kHeardCellDown @"MainDownCell"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 控制ControlView 大小
//    [self screenHeihtTabNar];

    [self initData];
    [self initContentView];
    

}

- (void)initData
{
    _data = [[NSArray alloc] initWithObjects:@"夜店",@"夜跑",@"夜店",nil];
    
}

#pragma mark - privateFuction

- (void)initContentView
{

    self.navigationItem.title                               = @"首页";
    self.navigationController.navigationBar.backgroundColor = [UIColor darkGrayColor];
    UITableView * tableView                                 = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle                                = UITableViewCellSeparatorStyleNone;
    tableView.delegate                                      = self;
    tableView.dataSource                                    = self;
    tableView.showsVerticalScrollIndicator                  = NO;
    self.myTableView                                        = tableView;
    
    [_myTableView registerNib:[UINib nibWithNibName:@"MainHeardViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeardCell1];
    [_myTableView registerNib:[UINib nibWithNibName:@"MainRankingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeardCellRanking];
      [_myTableView registerNib:[UINib nibWithNibName:@"MainDownCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHeardCellDown];

    [self.view addSubview:_myTableView];
    
}


- (UITableViewCell *)congfigCell:(NSIndexPath *)indexpath withTable:(UITableView *) tableView
{
    switch (indexpath.section) {
        case 0:
        {
            MainHeardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHeardCell1];

            // 广场
            cell.fashionPiaBlock    = ^()
            {
                FashionPiazzaViewController *vc = [[FashionPiazzaViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            };


            // 拼吧
            cell.pullzeBlock        = ^()
            {

            };

            // 排序
            cell.rankingBlock       = ^()
            {

            };
            
            return cell;
        }
            
            break;
        case 1:
        {
            MainRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:kHeardCellRanking];
            return cell;
        }
            
            
            break;
        case 2:
        {
            MainDownCell *cell               = [tableView dequeueReusableCellWithIdentifier:kHeardCellDown];
            cell.contentView.backgroundColor = [UIColor orangeColor];
            [cell setDataSource:_data[indexpath.row]];
            return cell;
        }

        default:
            break;
    }
    return nil;
}


#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else
    {
        return 3;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    cell = [self congfigCell:indexPath withTable:tableView];
    return cell;
   

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 265;
    }
    else if (indexPath.section == 1)
    {
        return 255;
    }
    else
    {
        return SCREEN_WIDTH * 0.618;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
