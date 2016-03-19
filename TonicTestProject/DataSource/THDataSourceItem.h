//
//  THDataSourceItem.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import UIKit;

@protocol THDataSourceItem <NSObject>

+ (NSString *)cellReuseIdentifier;
- (NSString *)cellReuseIdentifier;

@end

@protocol THDataSourceItemCell <NSObject>

- (void)fillCellWithDataSourceItem:(id<THDataSourceItem>)item;
- (CGFloat)cellHeightForTableWidth:(CGFloat)width;

@end
