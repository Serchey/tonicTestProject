//
//  THDataSourceItemsList.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "DataLoader.h"
#import "ImageItemModel.h"
#import "THDataSourceBase+Protected.h"
#import "THDataSourceItemsList.h"
#import "TextItemModel.h"

static NSString *const kDataSourceURLString = @"http://tonicforhealth.esy.es/test.json";
static NSString *const kJSONItemsKey = @"items";

@implementation THDataSourceItemsList

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.supportedItemClasses = [NSMutableArray array];
    }
    return self;
}

- (void)loadDataWithCompletionBlock:(THDataSourceDataLoadCompletionBlock)complete {
    [DataLoader downloadJSONAsDictionaryFromURLString:kDataSourceURLString
                                      completionBlock:^(NSDictionary *_Nullable dictionary, NSString *_Nullable errorTitle, NSString *_Nullable errorDescription) {
                                        if (dictionary == nil) {
                                            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: errorDescription}];
                                            complete(THDataSourceDataLoadStateError, error);
                                        } else {
                                            [self createFlatItemsListFromDataArray:dictionary[kJSONItemsKey]];

                                            // use standard method of parent class
                                            [self createFilteredListFromFlatList];

                                            // may use THDataSourceDataLoadStateFromCache here too
                                            complete(THDataSourceDataLoadStateLoaded, nil);
                                        }
                                      }];
}

- (void)createFlatItemsListFromDataArray:(NSArray *)itemsList {
    [self.flatItemsList removeAllObjects];

    for (NSDictionary *itemDict in itemsList) {
        id<THDataSourceItem> item = nil;

        for (Class itemClass in self.supportedItemClasses) {
            if ([itemClass canBeInitedFromDictionary:itemDict]) {
                item = [[itemClass alloc] initWithDictionary:itemDict];
                break;
            }
        }
        if (item != nil) {
            [self.flatItemsList addObject:item];
        }
    }
}

@end
