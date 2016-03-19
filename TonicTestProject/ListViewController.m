//
//  ListViewController.m
//  TonicTestProject
//
//  Created by Serhiy Medvedyev on 2/13/16.
//  Copyright © 2016 MevaSoft. All rights reserved.
//

#import "CellFactory.h"
#import "DataLoader.h"
#import "ListViewController.h"
#import "PreviewViewController.h"

static NSString *const kDataSourceURLString = @"http://tonicforhealth.esy.es/test.json";
static NSString *const kJSONItemsKey = @"items";

static NSString *const kCellTypeImageNib = @"ImageTableViewCell";
static NSString *const kCellTypeImageReuseID = @"imageCell";

static NSString *const kCellTypeTextNib = @"TextTableViewCell";
static NSString *const kCellTypeTextReuseID = @"textCell";

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, nonnull) NSArray *items;
@property(nonatomic, strong, nonnull) CellFactory *cellFactory;

@property(nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Items";

    [self setupCellFactory];

    [DataLoader downloadJSONAsDictionaryFromURLString:kDataSourceURLString
                                      completionBlock:^(NSDictionary *_Nullable dictionary, NSString *_Nullable errorTitle, NSString *_Nullable errorDescription) {
                                        if (dictionary != nil) {
                                            self.items = dictionary[kJSONItemsKey];
                                            [self.tableView reloadData];
                                        } else {
                                            [self showErrorWithTitle:errorTitle description:errorDescription];
                                        }
                                      }];
}

#pragma mark - Initial Setup

- (void)setupCellFactory {
    __weak typeof(self) weakSELF = self;

    self.cellFactory = [[CellFactory alloc] initWithTableView:self.tableView];

    [self.cellFactory registerCellTypeWithReusableID:kCellTypeImageReuseID
                                             nibName:kCellTypeImageNib
                                      itemMatchBlock:^BOOL(NSDictionary *_Nonnull item) {
                                        return [weakSELF isItemOfImageType:item];
                                      }];

    [self.cellFactory registerCellTypeWithReusableID:kCellTypeTextReuseID
                                             nibName:kCellTypeTextNib
                                      itemMatchBlock:^BOOL(NSDictionary *_Nonnull item) {
                                        return [weakSELF isItemOfTextType:item];
                                      }];
}

#pragma mark - Helpers

- (void)showErrorWithTitle:(NSString *)title description:(NSString *)description {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (BOOL)isItemOfTextType:(NSDictionary *)dict {
    return ([dict objectForKey:@"title"] && [dict objectForKey:@"text"]);
}

- (BOOL)isItemOfImageType:(NSDictionary *)dict {
    return ([dict objectForKey:@"title"] && [dict objectForKey:@"image"] && [dict objectForKey:@"preview"]);
}

- (BaseTableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView forHeightCalculation:(BOOL)heightCalculation {
    NSDictionary *item = self.items[indexPath.row];

    BaseTableViewCell *cell = [self.cellFactory cellForItem:item indexPath:indexPath forHeightCalculation:heightCalculation];

    [cell setCellItem:item];

    return cell;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [self cellForIndexPath:indexPath tableView:tableView forHeightCalculation:YES];
    return [cell cellHeightForTableWidth:CGRectGetWidth(tableView.bounds)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellForIndexPath:indexPath tableView:tableView forHeightCalculation:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSDictionary *item = self.items[indexPath.row];

    if ([self isItemOfImageType:item]) {
        PreviewViewController *previewController = [[PreviewViewController alloc] initWithNibName:@"PreviewViewController" bundle:nil];
        previewController.imageURLString = item[@"image"];
        previewController.title = item[@"title"];

        [self.navigationController pushViewController:previewController animated:YES];
    }
}

@end
