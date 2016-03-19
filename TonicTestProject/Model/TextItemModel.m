//
//  TextItemModel.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "TextItemModel.h"

static NSString *const kCellTypeReuseIdentifier = @"TextTableViewCell";

@implementation TextItemModel

+ (BOOL)canBeInitedFromDictionary:(NSDictionary *)dictionary {
    return ([dictionary objectForKey:@"title"] && [dictionary objectForKey:@"text"]);
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self != nil) {
        self.title = dict[@"title"];
        self.text = dict[@"text"];
    }
    return self;
}

+ (NSString *)cellReuseIdentifier {
    return kCellTypeReuseIdentifier;
}

- (NSString *)cellReuseIdentifier {
    return [[self class] cellReuseIdentifier];
}

@end
