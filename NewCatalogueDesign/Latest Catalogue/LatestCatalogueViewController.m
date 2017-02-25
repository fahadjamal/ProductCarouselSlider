//
//  LatestCatalogueViewController.m
//  NewCatalogueDesign
//
//  Created by Gizbo UAE on 1/25/16.
//  Copyright © 2016 Gizbo UAE. All rights reserved.
//

#import "LatestCatalogueViewController.h"
#import "DKRotatorDemoViewModel.h"
#import "PXRotatorView+StyledPageControl.h"

#import <PXRotatorView/PXRotatorView.h>
#import <PureLayout/ALView+PureLayout.h>
#import <GBDeviceInfo/GBDeviceInfo.h>

#import "BWMCoverView.h"
#import "PXRotatorChaoMoViewModel.h"
#import "LatestCatalogueImageCollectionCell.h"
#import "LatestCatalogueTableCell.h"
#import "LatestNewsTableCell.h"
#import "CatalougeDetailTextTableCell.h"

#import "UITableView+FDTemplateLayoutCell.h"

@interface LatestCatalogueViewController () <UITableViewDelegate, UITableViewDataSource> {
    DKRotatorDemoViewModel  *_viewModel;
    PXRotatorView           *_rotatorView;
    BWMCoverView            *_coverView;
    
    CGFloat                 tableHeaderHeight;
    CGFloat                 tableRowHeight;
}

@property (nonatomic, strong) IBOutlet UIButton *nextImageButton;
@property (nonatomic, strong) IBOutlet UIButton *previousImageButton;

@property (nonatomic, strong) IBOutlet UITableView *catalogueTableView;

@property (nonatomic, strong) IBOutlet UIView *tableHeaderView;

@property (nonatomic, strong) NSMutableArray *catalogueDetailArray;

-(IBAction)nextImageButtonTapped:(id)sender;
-(IBAction)previousImageButton:(id)sender;

@end

@implementation LatestCatalogueViewController

#pragma mark - Default Init Method -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    GBDeviceInfo *deviceInfo = [GBDeviceInfo deviceInfo];
    if (deviceInfo.model == GBDeviceModeliPhone6Plus || deviceInfo.model == GBDeviceModeliPhone6S || deviceInfo.model == GBDeviceModeliPhone6SPlus) {
        tableHeaderHeight = 250;
        tableRowHeight = 125.0f;
    }
    else if (deviceInfo.model == GBDeviceModeliPhone4 || deviceInfo.model == GBDeviceModeliPhone4S || deviceInfo.model == GBDeviceModeliPhone5 || deviceInfo.model == GBDeviceModeliPhone5C || deviceInfo.model == GBDeviceModeliPhone5S) {
        tableHeaderHeight = 180;
        tableRowHeight = 95.0f;
    }
    else if (deviceInfo.model == GBDeviceModeliPhone6) {
        tableHeaderHeight = 200;
        tableRowHeight = 120.0f;
    }
    
    [self setUpTableHeaderView];
    
    [self.tableHeaderView bringSubviewToFront:_nextImageButton];
    [self.tableHeaderView bringSubviewToFront:_previousImageButton];
    
    NSDictionary *item1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Price: ", @"Item_Title", @"795,000", @"Item_Description", nil];
    NSDictionary *item2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Type: ", @"Item_Title", @"Apartment", @"Item_Description", nil];
    NSDictionary *item3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Reference: ", @"Item_Title", @"Ap4250", @"Item_Description", nil];
    NSDictionary *item4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Bed Rooms: ", @"Item_Title", @"1", @"Item_Description", nil];
    NSDictionary *item5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Bath Rooms: ", @"Item_Title", @"1", @"Item_Description", nil];
    NSDictionary *item6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Area: ", @"Item_Title", @"950 sqft", @"Item_Description", nil];
    NSDictionary *item7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Price/Sqft: ", @"Item_Title", @"837 AED", @"Item_Description", nil];
    
    self.catalogueDetailArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self.catalogueDetailArray addObject:item1];
    [self.catalogueDetailArray addObject:item2];
    [self.catalogueDetailArray addObject:item3];
    [self.catalogueDetailArray addObject:item4];
    [self.catalogueDetailArray addObject:item5];
    [self.catalogueDetailArray addObject:item6];
    [self.catalogueDetailArray addObject:item7];
    
}

#pragma mark - UITableViewDataSource Method -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return [self.catalogueDetailArray count];
    }
    else if (section == 2) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"LatestCatalogueTableCell";
        LatestCatalogueTableCell *cell = (LatestCatalogueTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [cell setCarosuelCellDelegate:self];
        cell.tableIndexPath = indexPath;
        [cell setCarosuelImagesArray:[@[@"pic1.jpg", @"pic2.jpg", @"pic3.jpg", @"pic4.jpg"] mutableCopy]];
        [cell.collectionView reloadData];
        [cell setAccessoryView:nil];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 1) {
        static NSString *cellIdentifier = @"LatestNewsTableCell";
        LatestNewsTableCell *cell = (LatestNewsTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        NSDictionary *newsDictionary = [self.catalogueDetailArray objectAtIndex:indexPath.row];
        NSLog(@"newsDictionary is %@ \n", newsDictionary);
        
        [cell.catalogueTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        cell.catalogueTitleLabel.text = [NSString stringWithFormat:@"%@", [newsDictionary valueForKey:@"Item_Title"]];
        cell.catalogueTitleLabel.textColor = [UIColor colorWithRed:220.0f/255.0f green:154.0f/255.0f blue:39.0f/255.0f alpha:1.0];
        
        cell.catalogueDescriptionLabel.text = [NSString stringWithFormat:@"%@", [newsDictionary valueForKey:@"Item_Description"]];
        cell.catalogueDescriptionLabel.textColor = [UIColor whiteColor];
        [cell.catalogueDescriptionLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    else if (indexPath.section == 2) {
        static NSString *cellIdentifier = @"CatalougeDetailTextTableCell";
        CatalougeDetailTextTableCell *cell = (CatalougeDetailTextTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.catalogueDetailTextLabel.text = @"Fully furnished 1 bedroom apartment for sale in a new Building Elite 10 in Dubai Sports City. Enquire Now ! ";
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate Method -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return tableRowHeight;
    }
    else if (indexPath.section == 1) {
        return 50.0f;
    }
    else if (indexPath.section == 2) {
        return [tableView fd_heightForCellWithIdentifier:@"CatalougeDetailTextTableCell" configuration:^(CatalougeDetailTextTableCell *cell) {
            cell.catalogueDetailTextLabel.text = @"Fully furnished 1 bedroom apartment for sale in a new Building Elite 10 in Dubai Sports City. Enquire Now ! ";
        }];
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        @autoreleasepool {
            UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15.0f)];
            [sectionHeaderView setBackgroundColor:[UIColor clearColor]];
            return sectionHeaderView;
        }
    }
    else if (section == 1) {
        @autoreleasepool {
            UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
            [sectionHeaderView setBackgroundColor:[UIColor clearColor]];
            
            UIImageView *sectionHeaderImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
            [sectionHeaderImage setImage:[UIImage imageNamed:@"heading_banner.png"]];
            [sectionHeaderImage setContentMode:UIViewContentModeScaleToFill];
            //
            UILabel *headerViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width/2, 30)];
            NSString *headerTitleString = @"Details";
            [headerViewLabel setText:headerTitleString];
            [headerViewLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
            [headerViewLabel setTextColor:[UIColor whiteColor]];
            [headerViewLabel setBackgroundColor:[UIColor clearColor]];
            //
            [sectionHeaderView addSubview:sectionHeaderImage];
            [sectionHeaderView addSubview:headerViewLabel];
            return sectionHeaderView;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15.0f;
    }
    else if (section == 1) {
        return 30.0f;
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        @autoreleasepool {
            UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10.0f)];
            [sectionFooterView setBackgroundColor:[UIColor clearColor]];
            return sectionFooterView;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10.0f;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (indexPath.section == 1) {
    //        [cell setBackgroundColor:[UIColor colorWithRed:24.0f/255.0f green:35.0f/255.0f blue:49.0f/255.0f alpha:1.0f]];
    //    }
    //    else {
    //        [cell setBackgroundColor:[UIColor clearColor]];
    //    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - UITableViewDelegate Method -

-(void)itemSelectedAtIndex:(LatestCatalogueImageCollectionCell *)cell forImagesArray:(NSArray *)imagesArray forIndexPath:(NSIndexPath *)indexPath tableIndexPath:(NSIndexPath *)tableIndexPath {
    [_rotatorView scrollToSpecificPage:indexPath.row];
}

#pragma mark - Action Button Method -

-(IBAction)nextImageButtonTapped:(id)sender {
    if (_rotatorView) {
        [_rotatorView scrollToNextPage];
    }
}

-(IBAction)previousImageButton:(id)sender {
    if (_rotatorView) {
        [_rotatorView scrollToPreviousPage];
    }
}

#pragma mark - Class Instance Method -

-(void) setUpTableHeaderView {
    PXRotatorChaoMoViewModel *viewModel = [PXRotatorChaoMoViewModel new];
    viewModel.displayItems = [@[@"pic1.jpg", @"pic2.jpg", @"pic3.jpg", @"pic4.jpg"] mutableCopy];
    PXRotatorView *rotatorView = [[PXRotatorView alloc] init];
    rotatorView.carousel.type = iCarouselTypeLinear;
    rotatorView.layer.masksToBounds = NO;
    rotatorView.frame = CGRectMake(0, 0, self.view.frame.size.width, tableHeaderHeight -3);
    [self.tableHeaderView setBackgroundColor:[UIColor colorWithRed:220.0/255.0f green:154.0/255.0f blue:39.0/255.0f alpha:1.0]];
    [self.tableHeaderView addSubview:rotatorView];
    [rotatorView bindViewModel:viewModel];
    _rotatorView = rotatorView;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect oldFrame = _tableHeaderView.frame;
        _tableHeaderView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, tableHeaderHeight);
        [self.catalogueTableView setTableHeaderView:_tableHeaderView];
        self.catalogueTableView.tableHeaderView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, tableHeaderHeight);
        [_tableHeaderView layoutIfNeeded];
    }];
    
}

#pragma mark - Default De-Init Method -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    _catalogueTableView = nil;
    
    _nextImageButton     = nil;
    _previousImageButton = nil;
    
    _catalogueTableView = nil;
    _tableHeaderView    = nil;
    
    _catalogueDetailArray = nil;
    
    _viewModel   = nil;
    _rotatorView = nil;
    _coverView   = nil;
}

@end
