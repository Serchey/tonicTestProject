//
//  TextTableViewCell.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "TextTableViewCell.h"

@interface TextTableViewCell ()

@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation TextTableViewCell

- (void)setCellItem:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    self.descriptionLabel.text = item[@"text"];
}

@end
