//
//  THDataSourceProtocol.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import UIKit;

#import "THDataSourceItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, THDataSourceDataLoadState) { THDataSourceDataLoadStateNotAvailable, THDataSourceDataLoadStateFromCache, THDataSourceDataLoadStateLoaded, THDataSourceDataLoadStateError };

typedef void (^THDataSourceDataLoadCompletionBlock)(THDataSourceDataLoadState state, NSError *_Nullable error);
typedef BOOL (^THDataSourceFilteringBlock)(id<THDataSourceItem> item); // return true if item matches requirements
typedef NSComparisonResult (^THDataSourceSortingComparatorBlock)(id<THDataSourceItem> item1, id<THDataSourceItem> item2);

@protocol THDataSourceDelegate <NSObject>
@optional

// will call this method when user taps a row
- (void)didSelectItem:(id<THDataSourceItem>)item;

@end

@protocol THDataSourceProtocol <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) id<THDataSourceDelegate> delegate;
@property(nonatomic, copy, nullable) THDataSourceFilteringBlock filteringBlock;
@property(nonatomic, copy, nullable) THDataSourceSortingComparatorBlock sortingComparator;

- (instancetype)initWithTableView:(UITableView *)tableView;
- (void)loadDataWithCompletionBlock:(THDataSourceDataLoadCompletionBlock)complete;
/// returns indexPath or nil if the item is either not exists of filtered(i.e. not on sectionedList)
- (nullable NSIndexPath *)indexPathForItem:(id<THDataSourceItem>)item;

@optional

@end

NS_ASSUME_NONNULL_END
