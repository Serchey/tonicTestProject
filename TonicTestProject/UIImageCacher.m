//
//  UIImageCacher.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "UIImageCacher.h"
#import <pthread.h>

@interface UIImageCacher ()

@property(nonatomic, strong, nonnull) NSMutableDictionary *images;
@property(nonatomic, strong, nonnull) dispatch_queue_t downloadQueue;
@property(nonatomic, assign) pthread_mutex_t imagesLock;

@end

@implementation UIImageCacher

+ (UIImageCacher *)sharedCacher {
    static dispatch_once_t onceToken;
    static UIImageCacher *cacher = nil;

    dispatch_once(&onceToken, ^{
      cacher = [self new];
    });

    return cacher;
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        pthread_mutex_init(&_imagesLock, NULL);
        self.downloadQueue = dispatch_queue_create("Download Queue", DISPATCH_QUEUE_CONCURRENT);
        self.images = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)clearCache {
    [self.images removeAllObjects];
}

- (void)lockImages {
    pthread_mutex_lock(&_imagesLock);
}

- (void)unlockImages {
    pthread_mutex_unlock(&_imagesLock);
}

- (UIImage *)imageForURLString:(NSString *)urlString callback:(UIImageCacherCallbackBlock)callback {
    [self lockImages];
    if ([self.images objectForKey:urlString] != nil) {
        UIImage *image = [UIImage imageWithData:self.images[urlString]];
        [self unlockImages];
        return image;
    }
    [self unlockImages];

    dispatch_async(self.downloadQueue, ^{
      NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];

      if (imageData != nil) {
          [self lockImages];
          self.images[urlString] = imageData;
          [self unlockImages];

          UIImage *image = [UIImage imageWithData:imageData];
          dispatch_async(dispatch_get_main_queue(), ^{
            callback(urlString, image);
          });
      }
    });

    return nil;
}

@end
