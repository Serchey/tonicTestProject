//
//  BaseTableViewCell.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

- (void)setCellItem:(NSDictionary *)item;
- (CGFloat)cellHeightForTableWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END