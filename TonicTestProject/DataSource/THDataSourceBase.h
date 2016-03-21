//
//  THDataSourceBase.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import Foundation;

#import "THDataSourceItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, THDataSourceDataLoadState) { THDataSourceDataLoadStateNotAvailable, THDataSourceDataLoadStateFromCache, THDataSourceDataLoadStateLoaded, THDataSourceDataLoadStateError };

typedef void (^THDataSourceDataLoadCompletionBlock)(THDataSourceDataLoadState state, NSError *_Nullable error);
typedef BOOL (^THDataSourceFilteringBlock)(id<THDataSourceItem> item); // return true if item matches requirements
typedef NSComparisonResult (^THDataSourceSortingComparatorBlock)(id<THDataSourceItem> item1, id<THDataSourceItem> item2);

@protocol THDataSourceBaseDelegate <NSObject>

- (void)dataSourceItemListUpdated;

@end

@interface THDataSourceBase : NSObject

@property(nonatomic, weak) id<THDataSourceBaseDelegate> delegate;
@property(nonatomic, copy, nullable) THDataSourceFilteringBlock filteringBlock;
@property(nonatomic, copy, nullable) THDataSourceSortingComparatorBlock sortingComparator;

/// this method must be overriden by a child class
- (void)loadDataWithCompletionBlock:(THDataSourceDataLoadCompletionBlock)complete;

/// call this method from a child class every time you updated flatItemsList
- (void)createFilteredListFromFlatList;

/// filtered and sorted items list
- (NSArray<THDataSourceItem> *)itemsList;

@end

NS_ASSUME_NONNULL_END
