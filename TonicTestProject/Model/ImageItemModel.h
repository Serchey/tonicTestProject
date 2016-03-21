//
//  ImageItemModel.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 3/19/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import Foundation;

#import "ItemModelProtocol.h"
#import "THTableControllerBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageItemModel : NSObject <ItemModelProtocol>

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *imageURLString;
@property(nonatomic, copy) NSString *previewURLString;

@end

NS_ASSUME_NONNULL_END
