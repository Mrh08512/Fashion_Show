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
#import "CommentCell.h"


#define kTestContet @"dasio速度丝的就阿f速度进口拉丝的就阿fdasio速度丝的就阿f速度进dasio速度丝的就阿f速度进"
// 基于320寛
#define kHearBaseHeihgt 327
#define kHeardSpaceHeight SCREEN_WIDTH *0.618 - 320 *0.618

@interface AddressDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;
// 要处理的的cell
@property (nonatomic,strong) UITableViewCell *prototypeCell;

@property (nonatomic,strong) UITableViewCell *commentCell;

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


#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
        
        AdressDescriptionCell *cell = (AdressDescriptionCell *)self.prototypeCell;
        cell.translatesAutoresizingMaskIntoConstraints = NO;
        CGFloat defaultHeight = cell.contentView.frame.size.height;
        cell.contentLable.text = kTestContet;
        CGSize  s = [cell.contentLable.text stringContetenSizeWithFount:cell.contentLable.font andSize:CGSizeMake(cell.contentLable.width, 10000)].size;
        CGFloat height =    (s.height - 16) > 0 ?s.height - 16  + defaultHeight : defaultHeight;
        return 1  + height;
    }
    
    else if (indepath.section == 3)
    {
        CommentCell *cell = (CommentCell *)self.commentCell;
        cell.t.text = kTestContet;
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        NSLog(@"h=%f", size.height + 1);
        return 1  + size.height;

        
    }
    else
    {
        return 65;
    }
}



#pragma mark - private

- (void)registerCell
{
    [_myTableView registerNib:[UINib nibWithNibName:@"AdressDescriptionCell" bundle:nil] forCellReuseIdentifier:@"AdressDescriptionCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"AdressDetailHeardCell" bundle:nil] forCellReuseIdentifier:@"AdressDetailHeardCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"PraiseViewCell" bundle:nil] forCellReuseIdentifier:@"PraiseViewCell"];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    
    // 特殊处理的cell
    self.prototypeCell = [_myTableView dequeueReusableCellWithIdentifier:@"AdressDescriptionCell"];
    self.commentCell = [_myTableView dequeueReusableCellWithIdentifier:@"CommentCell"];
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
        cell.contentLable.text = kTestContet;


        return cell;
    }
    else if (indexPath.section == 2)
    {
        PraiseViewCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"PraiseViewCell"];
        return cell;

    }
    else if (indexPath.section == 3)
    {
        CommentCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        cell.t.text = kTestContet;
        return cell;
    }
    else
    {
        return nil;
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
