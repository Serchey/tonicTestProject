//
//  ImageTableViewCell.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "UIImageCacher.h"

static CGFloat const kImageCellDefaultHeight = 128.0;

@interface ImageTableViewCell ()

@property(strong, nonnull) NSString *previewImageURLString;

@property(weak, nonatomic) IBOutlet UIImageView *iconImage;
@property(weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ImageTableViewCell

- (void)setCellItem:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    self.previewImageURLString = item[@"preview"];

    if (self.superview != nil) { // do not request heavy objects for unattached cells
        self.iconImage.image = [[UIImageCacher sharedCacher] imageForURLString:self.previewImageURLString
                                                                      callback:^(NSString *_Nonnull urlString, UIImage *_Nonnull image) {
                                                                        if (![self.previewImageURLString isEqualToString:urlString]) {
                                                                            return; // probably the cell was reused with another image
                                                                        }
                                                                        self.iconImage.image = image;
                                                                      }];
    }
}

- (CGFloat)cellHeightForTableWidth:(CGFloat)width {
    return kImageCellDefaultHeight;
}

@end
