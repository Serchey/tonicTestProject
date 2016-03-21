//
//  THDataSourceBase+Protected.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/21/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "THDataSourceBase.h"

@interface THDataSourceBase ()

@property(nonatomic, strong) NSMutableArray<id<THDataSourceItem>> *flatItemsList;

@end
