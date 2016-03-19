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

@protocol THDataSourceDelegate <NSObject>

@property(nonatomic, weak, readonly) UITableView *tableView;

@optional

- (void)didSelectItem:(id<THDataSourceItem>)item;

@end

@protocol THDataSourceProtocol <UITableViewDataSource, UITableViewDelegate>

- (void)loadData;

@property(nonatomic, weak) id<THDataSourceDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
