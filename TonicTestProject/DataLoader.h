//
//  DataLoader.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/14/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DataLoaderCompletionBlock)(NSDictionary *_Nullable dictionary, NSString *_Nullable errorTitle, NSString *_Nullable errorDescription);

@interface DataLoader : NSObject

+ (void)downloadJSONAsDictionaryFromURLString:(NSString *)urlString completionBlock:(nonnull DataLoaderCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
