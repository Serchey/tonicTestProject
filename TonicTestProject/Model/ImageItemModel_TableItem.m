//
//  ImageItemModel_TableItem.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/21/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "ImageItemModel_TableItem.h"

static NSString *const kCellTypeReuseIdentifier = @"ImageTableViewCell";

@implementation ImageItemModel (THTableControllerItem)

+ (NSString *)cellReuseIdentifier {
    return kCellTypeReuseIdentifier;
}

- (NSString *)cellReuseIdentifier {
    return [[self class] cellReuseIdentifier];
}
@end
