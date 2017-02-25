//
//  CollectionTableViewCell.m
//  TableviewCellConCollection
//
//  Created by Eric Parker on 12/10/14.
//  Copyright (c) 2014 testing. All rights reserved.
//

#import "LatestCatalogueTableCell.h"
#import "LatestCatalogueImageCollectionCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <QuartzCore/CALayer.h>
#import <GBDeviceInfo/GBDeviceInfo.h>

@interface LatestCatalogueTableCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation LatestCatalogueTableCell

#pragma mark - UICollectionView delegate, datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_carosuelImagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    @autoreleasepool {
        static NSString *cellIdentifer = @"LatestCatalogueImageCollectionCell";
        
        LatestCatalogueImageCollectionCell *cell = (LatestCatalogueImageCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
        //        NSDictionary *catalogueImagesDictionary = [[NSDictionary alloc] initWithDictionary:[_carosuelImagesArray objectAtIndex:indexPath.row]];
        //        NSString *imageURL = [NSString stringWithFormat:@"%@", [catalogueImagesDictionary valueForKey:@"link"]];
        //        [cell.carosuelImageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        NSString *imageName = [NSString stringWithFormat:@"%@", [_carosuelImagesArray objectAtIndex:indexPath.row]];
        cell.carosuelImageView.image = [UIImage imageNamed:imageName];
        [cell.carosuelImageView.layer setMasksToBounds:YES];
        [cell.carosuelImageView setContentMode:UIViewContentModeScaleToFill];
        cell.contentView.backgroundColor = [UIColor blackColor];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //I sent an NSNotification for this event since it needed to be handled elsewhere
    LatestCatalogueImageCollectionCell *cell = (LatestCatalogueImageCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [_carosuelCellDelegate itemSelectedAtIndex:cell forImagesArray:_carosuelImagesArray forIndexPath:indexPath tableIndexPath:_tableIndexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    GBDeviceInfo *deviceInfo = [GBDeviceInfo deviceInfo];
    if (deviceInfo.model == GBDeviceModeliPhone6Plus || deviceInfo.model == GBDeviceModeliPhone6S || deviceInfo.model == GBDeviceModeliPhone6SPlus) {
        return CGSizeMake(150, 120);
    }
    else if (deviceInfo.model == GBDeviceModeliPhone4 || deviceInfo.model == GBDeviceModeliPhone4S || deviceInfo.model == GBDeviceModeliPhone5 || deviceInfo.model == GBDeviceModeliPhone5C || deviceInfo.model == GBDeviceModeliPhone5S) {
        return CGSizeMake(130, 90);
    }
    else if (deviceInfo.model == GBDeviceModeliPhone6) {
        return CGSizeMake(110, 110);
    }
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *) collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger) section {
    return 0.0f;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0.0f, 13.0f, 0.0f, 13.0f);
//}

@end
