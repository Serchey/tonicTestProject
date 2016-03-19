//
//  THDataSourceBase.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "THDataSourceBase.h"

@interface THDataSourceBase ()

@property(nonatomic, strong, readwrite) NSMutableArray<id<THDataSourceItem>> *flatItemsList;
@property(nonatomic, strong, readwrite) NSMutableArray<NSMutableArray<id<THDataSourceItem>> *> *sectionedItemsList;

@property(nonatomic, strong) NSMutableDictionary<NSString *, id<THDataSourceItemCell>> *sizingCells;

@end

@implementation THDataSourceBase

@synthesize delegate = _delegate;

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.flatItemsList = [NSMutableArray array];
        self.sectionedItemsList = [NSMutableArray array];
        self.sizingCells = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)loadData {
    // should be overriden by a child class
}

#pragma mark - Setters

- (void)setDelegate:(id<THDataSourceDelegate>)delegate {
    _delegate = delegate;

    _delegate.tableView.delegate = self;
    _delegate.tableView.dataSource = self;
}

#pragma mark - Helper methods

- (void)validateCell:(UITableViewCell *)cell reuseIdentifier:(NSString *)reuseIdentifier {
    NSAssert(cell != nil, @"No cell registered for reuse identifier %@", reuseIdentifier);
    NSAssert([cell conformsToProtocol:@protocol(THDataSourceItemCell)], @"Cell must conform to THDataSourceItemCell protocol");
}

- (id<THDataSourceItemCell>)getSizingCellForReuseIdentifier:(NSString *)reuseIdentifier {
    if (self.sizingCells[reuseIdentifier] == nil) {
        UITableViewCell<THDataSourceItemCell> *cell = [self.delegate.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
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
    id<THDataSourceItem> item = self.sectionedItemsList[indexPath.section][indexPath.row];
    UITableViewCell<THDataSourceItemCell> *cell = [self.delegate.tableView dequeueReusableCellWithIdentifier:[item cellReuseIdentifier] forIndexPath:indexPath];
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

@end
