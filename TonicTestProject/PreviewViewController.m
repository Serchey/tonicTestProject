//
//  PreviewViewController.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "PreviewViewController.h"
#import "UIImageCacher.h"

@interface PreviewViewController ()

@property(weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.iconImage.image = [[UIImageCacher sharedCacher] imageForURLString:self.imageURLString
                                                                  callback:^(NSString *_Nonnull urlString, UIImage *_Nonnull image) {
                                                                    self.iconImage.image = image;
                                                                  }];
}

@end
