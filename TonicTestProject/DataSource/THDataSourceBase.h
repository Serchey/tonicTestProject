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

@protocol THDataSourceDelegate <NSObject>
@optional

// will call this method when user taps a row
- (void)didSelectItem:(id<THDataSourceItem>)item;

@end

typedef NS_ENUM(NSInteger, THDataSourceDataLoadState) { THDataSourceDataLoadStateNotAvailable, THDataSourceDataLoadStateFromCache, THDataSourceDataLoadStateLoaded, THDataSourceDataLoadStateError };

typedef void (^THDataSourceDataLoadCompletionBlock)(THDataSourceDataLoadState state, NSError *_Nullable error);
typedef BOOL (^THDataSourceFilteringBlock)(id<THDataSourceItem> item); // return true if item matches requirements
typedef NSComparisonResult (^THDataSourceSortingComparatorBlock)(id<THDataSourceItem> item1, id<THDataSourceItem> item2);

@interface THDataSourceBase : NSObject

@property(nonatomic, weak) id<THDataSourceDelegate> delegate;
@property(nonatomic, copy, nullable) THDataSourceFilteringBlock filteringBlock;
@property(nonatomic, copy, nullable) THDataSourceSortingComparatorBlock sortingComparator;

- (instancetype)init __attribute__((unavailable("Use -initWithTable instead.")));
- (instancetype)initWithTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;

- (void)loadDataWithCompletionBlock:(THDataSourceDataLoadCompletionBlock)complete;
/// returns indexPath or nil if the item is either not exists of filtered(i.e. not on sectionedList)
- (nullable NSIndexPath *)indexPathForItem:(id<THDataSourceItem>)item;

@end

NS_ASSUME_NONNULL_END
