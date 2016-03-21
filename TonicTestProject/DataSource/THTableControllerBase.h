//
//  THTableControllerBase.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/21/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import UIKit;

@class THDataSourceBase;
@protocol THDataSourceItem;

NS_ASSUME_NONNULL_BEGIN

@protocol THTableControllerItem <THDataSourceItem>

+ (NSString *)cellReuseIdentifier;
- (NSString *)cellReuseIdentifier;

@end

/// registered cell for use by DataSource must conform to this protocol, they will be dequied with respective -cellReuseIdentifier of corresponding THTableControllerItem object
@protocol THTableControllerItemCell <NSObject>

- (void)fillCellWithDataSourceItem:(id<THTableControllerItem>)item;
- (CGFloat)cellHeightForTableWidth:(CGFloat)width;

@end

@protocol THTableControllerBaseDelegate <NSObject>
@optional

// will call this method when user taps a row
- (void)didSelectItem:(id<THTableControllerItem>)item;

@end

@interface THTableControllerBase : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)init __attribute__((unavailable("Use -initWithTable instead.")));
- (instancetype)initWithTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;

// a delegate for table events
@property(nonatomic, weak) id<THTableControllerBaseDelegate> delegate;

/// data source for a table controller
@property(nonatomic, strong) THDataSourceBase *dataSource;

/// returns indexPath or nil if the item is either not exists of filtered(i.e. not on sectionedList)
- (nullable NSIndexPath *)indexPathForItem:(id<THDataSourceItem>)item;

@end

NS_ASSUME_NONNULL_END
