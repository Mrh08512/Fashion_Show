//
//  AddressDetailViewController.m
//  Fashion
//
//  Created by TangJR on 7/17/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "AddressDetailViewController.h"
#import "AdressDetailHeardCell.h"
#import "AdressDescriptionCell.h"
#import "PraiseViewCell.h"
// 基于320寛
#define kHearBaseHeihgt 327
#define kHeardSpaceHeight SCREEN_WIDTH *0.618 - 320 *0.618

@interface AddressDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@end

@implementation AddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址详情";
    [self initBaseHeight];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)initBaseHeight
{
   
}

- (void)setupUI
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    UIImageView *bkView = [[UIImageView alloc] initWithFrame:tableview.bounds];
    bkView.image = [UIImage imageNamed:@"悬赏详情背景"];
    
//    tableview.backgroundView = bkView;
    tableview.backgroundColor = COLOR_CUSTOM(147, 144, 137, 0.7);
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView = tableview;
    [self registerCell];
    [self.view addSubview:_myTableView];
}

#pragma mark - private

- (void)registerCell
{
    [_myTableView registerNib:[UINib nibWithNibName:@"AdressDescriptionCell" bundle:nil] forCellReuseIdentifier:@"AdressDescriptionCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"AdressDetailHeardCell" bundle:nil] forCellReuseIdentifier:@"AdressDetailHeardCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"PraiseViewCell" bundle:nil] forCellReuseIdentifier:@"PraiseViewCell"];
}

- (UITableViewCell *)configTableViewCell:(NSIndexPath *)indexPath
{
    UITableViewCell *currentCell;
    if (indexPath.section == 0 ) {
        AdressDetailHeardCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"AdressDetailHeardCell"];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        AdressDescriptionCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"AdressDescriptionCell"];
        return cell;
    }
    else if (indexPath.section == 2)
    {
        PraiseViewCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"PraiseViewCell"];
        return cell;

    }
    {
        return currentCell;
    }
    
}


#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self configTableViewCell:indexPath];

    return cell;

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self getCurrentHeiht:indexPath];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat )getCurrentHeiht:(NSIndexPath *)indepath
{
    
    if (indepath.section == 0) {
        return kHearBaseHeihgt + kHeardSpaceHeight ;
    }
    else if (indepath.section == 1)
    {
        return 106;
    }
    else
    {
        return 65;
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
