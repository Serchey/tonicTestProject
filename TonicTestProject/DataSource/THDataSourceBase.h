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
@property(nonatomic, strong, readonly) NSMutableArray<NSMutableArray<id<THDataSourceItem>> *> *sectionedItemsList;

@end
