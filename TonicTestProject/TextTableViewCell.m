//
//  TextTableViewCell.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "TextItemModel.h"
#import "TextTableViewCell.h"

@interface TextTableViewCell ()

@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation TextTableViewCell

- (void)fillCellWithDataSourceItem:(id<THDataSourceItem>)item {
    TextItemModel *model = (TextItemModel *)item;

    self.titleLabel.text = model.title;
    self.descriptionLabel.text = model.text;
}

@end
