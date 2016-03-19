//
//  THDataSourceItemsList.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "DataLoader.h"
#import "ImageItemModel.h"
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

- (void)loadData {
    [DataLoader downloadJSONAsDictionaryFromURLString:kDataSourceURLString
                                      completionBlock:^(NSDictionary *_Nullable dictionary, NSString *_Nullable errorTitle, NSString *_Nullable errorDescription) {
                                        if (dictionary != nil) {
                                            [self createFlatItemsListFromDataArray:dictionary[kJSONItemsKey]];
                                            [self createSectionedListFromFlatList];
                                            [self.delegate.tableView reloadData];
                                        } else {
                                            [self showErrorWithTitle:errorTitle description:errorDescription];
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

        [self.flatItemsList addObject:item];
    }
}

- (void)createSectionedListFromFlatList {
    [self.sectionedItemsList removeAllObjects];
    // TODO: may need to implement this logic
    [self.sectionedItemsList addObject:self.flatItemsList];
}

#pragma mark - Helpers

- (void)showErrorWithTitle:(NSString *)title description:(NSString *)description {
    // TODO: error reporting should be moved to UI through delegate
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
