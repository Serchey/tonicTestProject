//
//  PreviewViewController.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "ImageItemModel.h"
#import "PreviewViewController.h"
#import "UIImageCacher.h"

@interface PreviewViewController ()

@property(weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.model.title;

    self.iconImage.image = [[UIImageCacher sharedCacher] imageForURLString:self.model.imageURLString
                                                                  callback:^(NSString *_Nonnull urlString, UIImage *_Nonnull image) {
                                                                    self.iconImage.image = image;
                                                                  }];
}

@end
