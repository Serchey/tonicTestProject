//
//  THDataSourceBase.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "THDataSourceBase.h"

@interface THDataSourceBase ()

@property(nonatomic, weak, readwrite) UITableView *tableView;

@property(nonatomic, strong, readwrite) NSMutableArray<id<THDataSourceItem>> *flatItemsList;
@property(nonatomic, strong, readwrite) NSMutableArray<id<THDataSourceItem>> *filteredItemsList;
@property(nonatomic, strong, readwrite) NSMutableArray<NSMutableArray<id<THDataSourceItem>> *> *sectionedItemsList;

@property(nonatomic, strong) NSMutableDictionary<NSString *, id<THDataSourceItemCell>> *sizingCells;

@end

@implementation THDataSourceBase

@synthesize delegate;
@synthesize filteringBlock = _filteringBlock;
@synthesize sortingComparator = _sortingComparator;

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self != nil) {
        self.tableView = tableView;

        self.flatItemsList = [NSMutableArray array];
        self.filteredItemsList = [NSMutableArray array];
        self.sectionedItemsList = [NSMutableArray array];
        self.sizingCells = [NSMutableDictionary dictionary];

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

#pragma mark - Setters

- (void)setFilteringBlock:(THDataSourceFilteringBlock)filteringBlock {
    _filteringBlock = [filteringBlock copy];
    [self createSectionedListFromFlatList];
}

- (void)setSortingComparator:(THDataSourceSortingComparatorBlock)sortingComparator {
    _sortingComparator = [sortingComparator copy];
    [self createSectionedListFromFlatList];
}

#pragma mark - Helper methods

- (void)validateCell:(UITableViewCell *)cell reuseIdentifier:(NSString *)reuseIdentifier {
    NSAssert(cell != nil, @"No cell registered for reuse identifier %@", reuseIdentifier);
    NSAssert([cell conformsToProtocol:@protocol(THDataSourceItemCell)], @"Cell must conform to THDataSourceItemCell protocol");
}

- (id<THDataSourceItemCell>)getSizingCellForReuseIdentifier:(NSString *)reuseIdentifier {
    NSAssert(self.tableView != nil, @"TableView must not be nil");
    if (self.sizingCells[reuseIdentifier] == nil) {
        UITableViewCell<THDataSourceItemCell> *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        [self validateCell:cell reuseIdentifier:reuseIdentifier];
        self.sizingCells[reuseIdentifier] = cell;
    }
    return self.sizingCells[reuseIdentifier];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionedItemsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<THDataSourceItem> item = self.sectionedItemsList[indexPath.section][indexPath.row];
    id<THDataSourceItemCell> cell = [self getSizingCellForReuseIdentifier:[item cellReuseIdentifier]];

    [cell fillCellWithDataSourceItem:item];

    return [cell cellHeightForTableWidth:CGRectGetWidth(tableView.bounds)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionedItemsList[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(self.tableView != nil, @"TableView must not be nil");
    id<THDataSourceItem> item = self.sectionedItemsList[indexPath.section][indexPath.row];
    UITableViewCell<THDataSourceItemCell> *cell = [self.tableView dequeueReusableCellWithIdentifier:[item cellReuseIdentifier] forIndexPath:indexPath];
    [self validateCell:cell reuseIdentifier:[item cellReuseIdentifier]];
    [cell fillCellWithDataSourceItem:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    id<THDataSourceItem> item = self.sectionedItemsList[indexPath.section][indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
        [self.delegate didSelectItem:item];
    }
}

#pragma mark - API

- (void)loadDataWithCompletionBlock:(THDataSourceDataLoadCompletionBlock)complete {
    // should be overriden by a child class
}

- (nullable NSIndexPath *)indexPathForItem:(id<THDataSourceItem>)item {
    for (NSUInteger sectionIdx = 0; sectionIdx < self.sectionedItemsList.count; sectionIdx++) {
        NSUInteger rowIdx = [self.sectionedItemsList[sectionIdx] indexOfObject:item];
        if (rowIdx != NSNotFound) {
            return [NSIndexPath indexPathForRow:rowIdx inSection:sectionIdx];
        }
    }
    return nil;
}

#pragma mark - Filtering & Sorting

- (void)createSectionedListFromFlatList {
    // filter first
    if (self.filteringBlock == nil) {
        self.filteredItemsList = [self.flatItemsList mutableCopy];
    } else {
        [self.filteredItemsList removeAllObjects];
        [self.flatItemsList enumerateObjectsUsingBlock:^(id<THDataSourceItem> _Nonnull item, NSUInteger idx, BOOL *_Nonnull stop) {
          if (self.filteringBlock(item)) {
              [self.filteredItemsList addObject:item];
          }
        }];
    }

    // sort items
    if (self.sortingComparator != nil) {
        [self.filteredItemsList sortUsingComparator:self.sortingComparator];
    }

    [self createSectionedListFromFilteredList];
}

- (void)createSectionedListFromFilteredList {
    // may be implemented by a child class, make only one section by default
    [self.sectionedItemsList removeAllObjects];
    [self.sectionedItemsList addObject:[self.filteredItemsList mutableCopy]];
}

@end
