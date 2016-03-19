//
//  UIImageCacher.h
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef void (^UIImageCacherCallbackBlock)(NSString *urlString, UIImage *image);

@interface UIImageCacher : NSObject

+ (UIImageCacher *)sharedCacher;

- (UIImage *)imageForURLString:(NSString *)urlString callback:(UIImageCacherCallbackBlock)callback;

@end

NS_ASSUME_NONNULL_END
