//
//  ItemModelProtocol.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@protocol ItemModelProtocol <NSObject>

+ (BOOL)canBeInitedFromDictionary:(NSDictionary *)dictionary;

- (instancetype)init __attribute__((unavailable("Use -initWithDictionary: instead")));
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
