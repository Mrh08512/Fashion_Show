//
//  WaterFlowLayout.m
//  WaterFlowDisplay
//
//  Created by B.H.Liu on 12-8-22.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//

#import "WaterFlowLayout.h"

@implementation WaterFlowLayout
{
    NSMutableArray *attributes;
}

- (void)setFlowdatasource:(id<UICollectionViewDataSourceWaterFlowLayout>)flowdatasource
{
    _flowdatasource = flowdatasource;
    //[self initialize];
}

- (void)setFlowdelegate:(id<UICollecitonViewDelegateWaterFlowLayout>)flowdelegate
{
    _flowdelegate = flowdelegate;
    //[self initialize];
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    attributes = [NSMutableArray array];
    
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    
    currentPage = 1;
    
    contentHeight = [self initialize];
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, contentHeight + _startY);
}

- (CGFloat)initialize
{
    
    numberOfColumns = [_flowdatasource numberOfColumnsInFlowLayout:self];
    self.cellHeight = [NSMutableArray arrayWithCapacity:numberOfColumns];
    self.cellIndex = [NSMutableArray arrayWithCapacity:numberOfColumns];
    self.cellPosition = [NSMutableArray arrayWithCapacity:_cellCount];
    
    // 左右距离
    padding = 2;
    cellWidth = (self.collectionView.frame.size.width - (numberOfColumns-1)*padding)/numberOfColumns;
    
    CGFloat minHeight = 0.f;
    
    CGFloat scrollHeight = 0.f;
    
    NSInteger minHeightAtColumn = 0;
    for (int i = 0; i< _cellCount ; i++)
    {
        //the first pics
        if(self.cellHeight.count < numberOfColumns)
        {
            [self.cellHeight addObject:[NSMutableArray arrayWithObject:[NSNumber numberWithFloat:[self.flowdelegate flowLayout:self heightForRowAtIndex:i]]]];
            
            [self.cellIndex addObject:[NSMutableArray arrayWithObject:[NSNumber numberWithInt:i]]];
            minHeight = [self.flowdelegate flowLayout:self heightForRowAtIndex:i];
            
            [self.cellPosition addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:minHeightAtColumn*(cellWidth+padding)],@"x",[NSNumber numberWithFloat:[self.flowdelegate flowLayout:self heightForRowAtIndex:i]],@"y", nil]];
            minHeightAtColumn ++;
            
            NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes* attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
            CGFloat x = [[[self.cellPosition objectAtIndex:path.item] objectForKey:@"x"] floatValue];
            CGFloat y = [[[self.cellPosition objectAtIndex:path.item] objectForKey:@"y"] floatValue] ;
            CGFloat height = [_flowdelegate flowLayout:self heightForRowAtIndex:path.item];
            attribute.size = CGSizeMake(cellWidth, height);
            
            attribute.center = CGPointMake(x + cellWidth/2, (y - height/2) + _startY);
            [attributes addObject:attribute];
            
            continue;
        }
        
        //find the column with the shortest height and insert the cell height into self.cellHeight[column]
        for (int j = 0; j< numberOfColumns; j++)
        {
            NSMutableArray *cellHeightInPresentColumn = [NSMutableArray arrayWithArray:[self.cellHeight objectAtIndex:j]];
            if (floor([[cellHeightInPresentColumn lastObject]floatValue]) <= minHeight)
            {
                minHeight = [[cellHeightInPresentColumn lastObject]floatValue];
                minHeightAtColumn = j ;
            }
        }
        
        [[self.cellHeight objectAtIndex:minHeightAtColumn] addObject:[NSNumber numberWithFloat:minHeight+=[self.flowdelegate flowLayout:self heightForRowAtIndex:i]]];
        [[self.cellIndex objectAtIndex:minHeightAtColumn]addObject:[NSNumber numberWithInt:i]];
        
        [self.cellPosition addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:(cellWidth+padding)*minHeightAtColumn ],@"x",[NSNumber numberWithFloat:minHeight],@"y", nil]];
        
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes* attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        CGFloat x = [[[self.cellPosition objectAtIndex:path.item] objectForKey:@"x"] floatValue];
        CGFloat y = [[[self.cellPosition objectAtIndex:path.item] objectForKey:@"y"] floatValue];
        CGFloat height = [_flowdelegate flowLayout:self heightForRowAtIndex:path.item];
        attribute.size = CGSizeMake(cellWidth, height);
        attribute.center = CGPointMake(x + cellWidth/2, y - height/2 + _startY);
        [attributes addObject:attribute];
    }
    
    for (int j = 0; j < self.cellHeight.count; j++)
    {
        CGFloat columnHeight = [[[self.cellHeight objectAtIndex:j] lastObject] floatValue] ;
        scrollHeight = scrollHeight > columnHeight ? scrollHeight : columnHeight;
    }
    
    return scrollHeight;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    return attributes[path.item];
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [attributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
	return NO;
}

@end
