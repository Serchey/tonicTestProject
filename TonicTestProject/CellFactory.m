//
//  CellFactory.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/14/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CellFactory.h"

@interface CellFactory ()

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<NSString *> *cellReuseIDs;
@property(nonatomic, strong) NSMutableArray<NSString *> *cellNibNames;
@property(nonatomic, strong) NSMutableArray<CellFactoryItemMatchBlock> *cellMatchBlocks;
@property(nonatomic, strong) NSMutableArray<BaseTableViewCell *> *sizingCells;

@end

@implementation CellFactory

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self != nil) {
        self.tableView = tableView;
        self.cellReuseIDs = [NSMutableArray array];
        self.cellNibNames = [NSMutableArray array];
        self.cellMatchBlocks = [NSMutableArray array];
        self.sizingCells = [NSMutableArray array];
    }
    return self;
}

- (void)registerCellTypeWithReusableID:(NSString *)reuseID nibName:(NSString *)nibName itemMatchBlock:(CellFactoryItemMatchBlock)matchBlock {
    [self.cellReuseIDs addObject:reuseID];
    [self.cellNibNames addObject:nibName];
    [self.cellMatchBlocks addObject:matchBlock];

    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseID];

    [self.sizingCells addObject:[self.tableView dequeueReusableCellWithIdentifier:reuseID]];
}

- (BaseTableViewCell *)cellForItem:(NSDictionary *)item indexPath:(NSIndexPath *)indexPath forHeightCalculation:(BOOL)heightCalculation {
    NSInteger idx = [self cellTypeIndexForItem:item];

    BaseTableViewCell *cell = nil;

    if (idx == NSNotFound) {
        return [BaseTableViewCell new]; // fallback
    }

    if (heightCalculation) {
        cell = self.sizingCells[idx];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:self.cellReuseIDs[idx] forIndexPath:indexPath];
    }

    return cell;
}

- (NSInteger)cellTypeIndexForItem:(nonnull NSDictionary *)item {
    for (NSInteger i = 0; i < self.cellMatchBlocks.count; i++) {
        if (self.cellMatchBlocks[i](item)) {
            return i;
        }
    }
    return NSNotFound;
}

@end
