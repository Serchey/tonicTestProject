//
//  THDataSourceBase.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "THDataSourceBase+Protected.h"
#import "THDataSourceBase.h"

@interface THDataSourceBase ()

@property(nonatomic, strong) NSMutableArray<id<THDataSourceItem>> *filteredItemsList;

@end

@implementation THDataSourceBase

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.flatItemsList = [NSMutableArray array];
        self.filteredItemsList = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Setters

- (void)setFilteringBlock:(THDataSourceFilteringBlock)filteringBlock {
    _filteringBlock = [filteringBlock copy];
    [self createFilteredListFromFlatList];
}

- (void)setSortingComparator:(THDataSourceSortingComparatorBlock)sortingComparator {
    _sortingComparator = [sortingComparator copy];
    [self createFilteredListFromFlatList];
}

#pragma mark - API

- (void)loadDataWithCompletionBlock:(THDataSourceDataLoadCompletionBlock)complete {
    // should be overriden by a child class
}

- (NSArray<THDataSourceItem> *)itemsList {
    return [self.filteredItemsList copy];
}

#pragma mark - Filtering & Sorting

- (void)createFilteredListFromFlatList {
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

    [self.delegate dataSourceItemListUpdated];
}

@end
