//
//  ActivityDetailCommentsBigCell.m
//  Fashion
//
//  Created by TangJR on 7/19/15.
//  Copyright (c) 2015 MRH-MAC. All rights reserved.
//

#import "ActivityDetailCommentsBigCell.h"
#import "ActivityDetailCommentsLittleCell.h"

static NSString * const identifier = @"ActivityDetailCommentsLittleCell";

@interface ActivityDetailCommentsBigCell () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) ActivityDetailCommentsLittleCell *currentConfigCell;

@end

@implementation ActivityDetailCommentsBigCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityDetailCommentsLittleCell" bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self configCellWithIndexPath:indexPath];
}

- (ActivityDetailCommentsLittleCell *)configCellWithIndexPath:(NSIndexPath *)indexPath {
    
    ActivityDetailCommentsLittleCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    self.currentConfigCell = cell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.currentConfigCell) {
        
        ActivityDetailCommentsLittleCell *cell = self.currentConfigCell;
        cell.translatesAutoresizingMaskIntoConstraints = NO;
        CGFloat defaultHeight = CGRectGetHeight(cell.frame);
        CGSize size = [cell.commentLabel.text stringContetenSizeWithFount:cell.commentLabel.font andSize:CGSizeMake(cell.commentLabel.width, 10000)].size;
        CGFloat height =    (size.height - 16) > 0 ? size.height - 16  + defaultHeight : defaultHeight;
        return 1 + height;
    }
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

@end