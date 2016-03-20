//
//  THDataSourceItem.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import UIKit;

// every item DataSource manages should have a reuse id for cell that will be created for it
@protocol THDataSourceItem <NSObject>

+ (NSString *)cellReuseIdentifier;
- (NSString *)cellReuseIdentifier;

@end

/// registered cell for use by DataSource must conform to this protocol
@protocol THDataSourceItemCell <NSObject>

- (void)fillCellWithDataSourceItem:(id<THDataSourceItem>)item;
- (CGFloat)cellHeightForTableWidth:(CGFloat)width;

@end
