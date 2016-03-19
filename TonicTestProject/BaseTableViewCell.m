//
//  BaseTableViewCell.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

#pragma mark - Setters

- (void)fillCellWithDataSourceItem:(id<THDataSourceItem>)item {
    // may be orverriden by a child class
}

- (CGFloat)cellHeightForTableWidth:(CGFloat)width {
    CGSize fittingSize = UILayoutFittingCompressedSize;

    fittingSize.width = (self.superview == nil) ? width : CGRectGetWidth(self.superview.frame);

    CGSize computedSize = [self systemLayoutSizeFittingSize:fittingSize withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];

    return computedSize.height;
}

@end
