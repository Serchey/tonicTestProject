//
//  THTableControllerBase.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/21/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "THDataSourceBase.h"
#import "THTableControllerBase.h"

@interface THTableControllerBase () <THDataSourceBaseDelegate>

@property(nonatomic, strong, nonnull) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<NSMutableArray<id<THTableControllerItem>> *> *sectionedItemsList;
@property(nonatomic, strong) NSMutableDictionary<NSString *, id<THTableControllerItemCell>> *sizingCells;

@end

@implementation THTableControllerBase

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self != nil) {
        self.tableView = tableView;

        self.sectionedItemsList = [NSMutableArray array];
        self.sizingCells = [NSMutableDictionary dictionary];

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (void)createSectionedListFromDataSourceItemsList {
    [self.sectionedItemsList removeAllObjects];
    NSMutableArray<id<THTableControllerItem>> *result = [NSMutableArray array];
    // by default, we have only one section
    NSArray<id<THDataSourceItem>> *items = [self.dataSource itemsList];

    [items enumerateObjectsUsingBlock:^(id<THDataSourceItem> _Nonnull item, NSUInteger idx, BOOL *_Nonnull stop) {
      if ([item conformsToProtocol:@protocol(THTableControllerItem)]) {
          [result addObject:(id<THTableControllerItem>)item];
      }
    }];

    [self.sectionedItemsList addObject:result];
}

#pragma mark - API

- (nullable NSIndexPath *)indexPathForItem:(id<THTableControllerItem>)item {
    for (NSUInteger sectionIdx = 0; sectionIdx < self.sectionedItemsList.count; sectionIdx++) {
        NSUInteger rowIdx = [self.sectionedItemsList[sectionIdx] indexOfObject:item];
        if (rowIdx != NSNotFound) {
            return [NSIndexPath indexPathForRow:rowIdx inSection:sectionIdx];
        }
    }
    return nil;
}

#pragma mark - Setters

- (void)setDataSource:(THDataSourceBase *)dataSource {
    _dataSource = dataSource;
    dataSource.delegate = self;
    [self createSectionedListFromDataSourceItemsList];
}

#pragma mark - Helper methods

- (id<THTableControllerItemCell>)getSizingCellForReuseIdentifier:(NSString *)reuseIdentifier {
    if (self.sizingCells[reuseIdentifier] == nil) {
        UITableViewCell<THTableControllerItemCell> *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        self.sizingCells[reuseIdentifier] = cell;
    }
    return self.sizingCells[reuseIdentifier];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionedItemsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<THTableControllerItem> item = self.sectionedItemsList[indexPath.section][indexPath.row];
    id<THTableControllerItemCell> cell = [self getSizingCellForReuseIdentifier:[item cellReuseIdentifier]];

    [cell fillCellWithDataSourceItem:item];

    return [cell cellHeightForTableWidth:CGRectGetWidth(tableView.bounds)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionedItemsList[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<THTableControllerItem> item = self.sectionedItemsList[indexPath.section][indexPath.row];
    UITableViewCell<THTableControllerItemCell> *cell = [self.tableView dequeueReusableCellWithIdentifier:[item cellReuseIdentifier] forIndexPath:indexPath];
    [cell fillCellWithDataSourceItem:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    id<THTableControllerItem> item = self.sectionedItemsList[indexPath.section][indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
        [self.delegate didSelectItem:item];
    }
}

#pragma mark - THDataSourceBaseDelegate

- (void)dataSourceItemListUpdated {
    [self createSectionedListFromDataSourceItemsList];
}

@end
