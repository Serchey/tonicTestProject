//
//  ImageItemModel.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "ImageItemModel.h"

static NSString *const kCellTypeReuseIdentifier = @"ImageTableViewCell";

@implementation ImageItemModel

+ (BOOL)canBeInitedFromDictionary:(NSDictionary *)dictionary {
    return ([dictionary objectForKey:@"title"] && [dictionary objectForKey:@"image"] && [dictionary objectForKey:@"preview"]);
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self != nil) {
        self.title = dict[@"title"];
        self.imageURLString = dict[@"image"];
        self.previewURLString = dict[@"preview"];
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
