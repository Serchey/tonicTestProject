//
//  ListViewController.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "ImageItemModel.h"
#import "ListViewController.h"
#import "PreviewViewController.h"
#import "THDataSourceItemsList.h"
#import "TextItemModel.h"

static NSString *const kCellTypeImageNib = @"ImageTableViewCell";
static NSString *const kCellTypeTextNib = @"TextTableViewCell";

@interface ListViewController () <THDataSourceDelegate>

@property(nonatomic, strong, nonnull) THDataSourceItemsList *dataSource;

@property(nonatomic, weak, readwrite) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Items";

    [self registerCellNibs];

    self.dataSource = [THDataSourceItemsList new];
    [self.dataSource.supportedItemClasses addObject:[ImageItemModel class]];
    [self.dataSource.supportedItemClasses addObject:[TextItemModel class]];
    self.dataSource.delegate = self;
    [self.dataSource loadData];
}

#pragma mark - Initial Setup

- (void)registerCellNibs {
    [self.tableView registerNib:[UINib nibWithNibName:kCellTypeImageNib bundle:nil] forCellReuseIdentifier:[ImageItemModel cellReuseIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:kCellTypeTextNib bundle:nil] forCellReuseIdentifier:[TextItemModel cellReuseIdentifier]];
}

#pragma mark - THDataSourceDelegate

- (void)didSelectItem:(id<THDataSourceItem>)item {
    if ([[item cellReuseIdentifier] isEqualToString:kCellTypeImageNib]) {
        PreviewViewController *previewController = [[PreviewViewController alloc] initWithNibName:@"PreviewViewController" bundle:nil];

        previewController.model = (ImageItemModel *)item;

        [self.navigationController pushViewController:previewController animated:YES];
    }
}

@end
