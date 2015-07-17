//
//  SnsViewController.m
//  Fashion
//
//  Created by MRH-MAC on 15/7/15.
//  Copyright (c) 2015年 MRH-MAC. All rights reserved.
//

#import "SnsViewController.h"
#import "TitleBar.h"
#import "MessageCell.h"
#define kMessage @"消息列表"
#define kFriendList @"好友列表"
#define kUpdate @"动态"
#define kNotification @"通知"

@interface SnsViewController ()<UITableViewDataSource,UITableViewDelegate,TitleBarDelegate>

@property (nonatomic,strong) UITableView    *myTableView;
@property (nonatomic,strong) NSMutableArray *messageData;
@property (nonatomic,strong) NSMutableArray *friendListData;
@property (nonatomic,strong) NSMutableArray *upDateData;
@property (nonatomic,strong) NSMutableArray *notificationData;
@property (nonatomic,strong) NSMutableDictionary *allDataSource;
@property (nonatomic,strong) NSArray * currentData;
@property (nonatomic,strong) NSString *currentCellName;

@end

@implementation SnsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataSource];
    [self initFace];
    
    
}




#pragma mark - praviteFuction


- (void)initDataSource
{
    _messageData      = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",nil];
    _friendListData   = [[NSMutableArray alloc] init];
    _upDateData       = [[NSMutableArray alloc] init];
    _notificationData = [[NSMutableArray alloc] init];
    _allDataSource    = [[NSMutableDictionary alloc] init];
    _currentData      = [[NSArray alloc] init];
    [_allDataSource setValue:_messageData       forKey:kMessage];
    [_allDataSource setValue:_friendListData    forKey:kFriendList];
    [_allDataSource setValue:_upDateData        forKey:kUpdate];
    [_allDataSource setValue:_notificationData  forKey:kNotification];
}

-(void)initFace
{
    UIImageView *imageView    = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image           = [UIImage imageNamed:@"消息列表"];
    UIView *view1             = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 30)];
    view1.backgroundColor     = [UIColor whiteColor];
    view1.alpha               = 0.4;
    TitleBar *tilte           = [[TitleBar alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 30)];
    tilte.titles              = @[kMessage,kFriendList,kUpdate,kNotification];
    tilte.delegate            = self;

    _myTableView              = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, self.view.bounds.size.height - 90 - 46 )];
    [self registeCellClass];
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate     = self;
    _myTableView.dataSource   = self;
    
    
    [self.view addSubview:imageView];
    [self.view addSubview:view1];
    [self.view addSubview:tilte];
    [self.view addSubview:_myTableView];

}

- (void)registeCellClass
{
    [_myTableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
}





#pragma mark TitleBarDelegate

- (void)titleBarClickButto:(UIButton *)button
{
    NSString *title = button.titleLabel.text;
    
    if ([title isEqualToString:kMessage])
    {
        self.currentCellName = kMessage;
        [_myTableView reloadData];

    }
    else if ([title isEqualToString:kFriendList])
    {
        
    }
    else if ([title isEqualToString:kUpdate])
    {
        
    }
    else if ([title isEqualToString:kNotification])
    {
        
    }

    self.currentData = _allDataSource[_currentCellName];

}


- (UITableViewCell *)changeCurrentCellWithIndexpath:(NSIndexPath *)indexPath
{
    if ([self.currentCellName isEqualToString:kMessage])
    {
        MessageCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"MessageCell"];
        cell.dataSource = _currentData[indexPath.row];
        return cell;

    }
    else if ([self.currentCellName isEqualToString:kFriendList])
    {
        return nil;
    }
    else if ([self.currentCellName isEqualToString:kUpdate])
    {
        return nil;
    }
    else if ([self.currentCellName isEqualToString:kNotification])
    {
        return nil;
    }
    else
    {
        return nil;
    }

    
}
#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_allDataSource objectForKey:_currentCellName] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;

    cell = [self changeCurrentCellWithIndexpath:indexPath];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
