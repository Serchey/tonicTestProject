//
//  DataLoader.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/14/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "DataLoader.h"

@implementation DataLoader

+ (void)downloadJSONAsDictionaryFromURLString:(NSString *)urlString completionBlock:(DataLoaderCompletionBlock)completion {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      NSData *dataRaw = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];

      dispatch_async(dispatch_get_main_queue(), ^{
        if (dataRaw == nil) {
            completion(nil, @"Network error", @"Error loading data");
            return;
        }

        [self prepareDataSourceFromData:dataRaw completionBlock:completion];
      });
    });
}

+ (void)prepareDataSourceFromData:(NSData *)data completionBlock:(nonnull DataLoaderCompletionBlock)completion {
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    if (error != nil) {
        completion(nil, @"Invalid JSON format", @"Downloaded file is of wrong format or has been corrupted");
        return;
    }

    completion(json, nil, nil);
}

@end
