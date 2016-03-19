//
//  THDataSourceItemsList.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "THDataSourceBase.h"

@interface THDataSourceItemsList : THDataSourceBase

@property(nonatomic, strong) NSMutableArray<Class<ItemModelProtocol>> *supportedItemClasses;

@end
