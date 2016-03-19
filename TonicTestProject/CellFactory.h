//
//  CellFactory.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/14/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import UIKit;
@import Foundation;

#import "BaseTableViewCell.h"

@class BaseTableViewCell;

NS_ASSUME_NONNULL_BEGIN

typedef BOOL (^CellFactoryItemMatchBlock)(NSDictionary *item);

@interface CellFactory : NSObject

- (instancetype)init __attribute__((unavailable("Use -initWithTableView: instead")));
- (instancetype)initWithTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;

- (void)registerCellTypeWithReusableID:(NSString *)reuseID nibName:(NSString *)nibName itemMatchBlock:(CellFactoryItemMatchBlock)matchBlock;
- (BaseTableViewCell *)cellForItem:(NSDictionary *)item indexPath:(NSIndexPath *)indexPath forHeightCalculation:(BOOL)heightCalculation;

@end

NS_ASSUME_NONNULL_END
