//
//  ImageItemModel.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "ImageItemModel.h"

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

@end
