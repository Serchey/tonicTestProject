//
//  THDataSourceBase.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import Foundation;

#import "THDataSourceProtocol.h"

@interface THDataSourceBase : NSObject <THDataSourceProtocol>

@property(nonatomic, strong, readonly) NSMutableArray<id<THDataSourceItem>> *flatItemsList;
@property(nonatomic, strong, readonly) NSMutableArray<id<THDataSourceItem>> *filteredItemsList;
@property(nonatomic, strong, readonly) NSMutableArray<NSMutableArray<id<THDataSourceItem>> *> *sectionedItemsList;

- (void)createSectionedListFromFlatList;

// this method may be overriden by a child class, do not call it directly
- (void)createSectionedListFromFilteredList;

@end
