//
//  TextItemModel.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import Foundation;

#import "ItemModelProtocol.h"
#import "THDataSourceItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextItemModel : NSObject <THDataSourceItem, ItemModelProtocol>

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
