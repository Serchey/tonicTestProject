//
//  THDataSourceBase+Protected.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/20/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "THDataSourceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface THDataSourceBase () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<id<THDataSourceItem>> *flatItemsList;
@property(nonatomic, strong) NSMutableArray<id<THDataSourceItem>> *filteredItemsList;
@property(nonatomic, strong) NSMutableArray<NSMutableArray<id<THDataSourceItem>> *> *sectionedItemsList;

/// call this method from a child class every time you updated flatItemsList
- (void)createSectionedListFromFlatList;

/// this method may be overriden by a child class, but do not call it directly
- (void)createSectionedListFromFilteredList;

@end

NS_ASSUME_NONNULL_END
