//
//  ListViewController.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "ImageItemModel.h"
#import "ImageItemModel_TableItem.h"
#import "ListViewController.h"
#import "PreviewViewController.h"
#import "THDataSourceItemsList.h"
#import "THTableControllerBase.h"
#import "TextItemModel.h"

static NSString *const kCellTypeImageNib = @"ImageTableViewCell";
static NSString *const kCellTypeTextNib = @"TextTableViewCell";

@interface ListViewController () <THTableControllerBaseDelegate>

@property(nonatomic, strong, nonnull) THDataSourceItemsList *dataSource;
@property(nonatomic, strong, nonnull) THTableControllerBase *tableController;

@property(nonatomic, weak, readwrite) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Items";

    [self registerCellNibs];

    self.dataSource = [THDataSourceItemsList new];
    self.tableController = [[THTableControllerBase alloc] initWithTableView:self.tableView];
    self.tableController.dataSource = self.dataSource;
    self.tableController.delegate = self;

    [self.dataSource.supportedItemClasses addObject:[ImageItemModel class]];
    [self.dataSource.supportedItemClasses addObject:[TextItemModel class]];

    __weak typeof(self) weakSELF = self;
    [self.dataSource loadDataWithCompletionBlock:^(THDataSourceDataLoadState state, NSError *_Nullable error) {
      if (error != nil) {
          [weakSELF showErrorWithTitle:@"Error downloading data" description:error.localizedDescription];
      } else {
          [weakSELF.tableView reloadData];
      }
    }];

    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

      self.dataSource.filteringBlock = ^(id<THDataSourceItem> item) {
        if ([item isKindOfClass:[ImageItemModel class]]) {
            ImageItemModel *imageModel = (ImageItemModel *)item;
            if ([imageModel.title rangeOfString:@"pic1"].location != NSNotFound) {
                return YES;
            } else {
                return NO;
            }
        }
        return NO;
      };

      [self.tableView reloadData];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      self.dataSource.sortingComparator = ^(id<THDataSourceItem> item1, id<THDataSourceItem> item2) {
        return [[(ImageItemModel *)item2 title] compare:[(ImageItemModel *)item1 title] options:(NSNumericSearch | NSBackwardsSearch)];
      };

      [self.tableView reloadData];
    });
    */
}

#pragma mark - Initial Setup

- (void)registerCellNibs {
    [self.tableView registerNib:[UINib nibWithNibName:kCellTypeImageNib bundle:nil] forCellReuseIdentifier:[ImageItemModel cellReuseIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:kCellTypeTextNib bundle:nil] forCellReuseIdentifier:[TextItemModel cellReuseIdentifier]];
}

#pragma mark - THDataSourceDelegate

- (void)didSelectItem:(id<THDataSourceItem>)item {
    if ([item isKindOfClass:[ImageItemModel class]]) {
        PreviewViewController *previewController = [[PreviewViewController alloc] initWithNibName:@"PreviewViewController" bundle:nil];

        previewController.model = (ImageItemModel *)item;

        [self.navigationController pushViewController:previewController animated:YES];
    }
}

#pragma mark - Helpers

- (void)showErrorWithTitle:(NSString *)title description:(NSString *)description {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
