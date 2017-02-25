//
//  CollectionTableViewCell.h
//  TableviewCellConCollection
//
//  Created by Eric Parker on 12/10/14.
//  Copyright (c) 2014 testing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LatestCatalogueImageCollectionCell.h"

@interface LatestCatalogueTableCell : UITableViewCell

@property (nonatomic, strong) NSArray *carosuelImagesArray;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) id carosuelCellDelegate;

@property (nonatomic, strong) NSIndexPath *tableIndexPath;

@end

@protocol LatestCatalogueTableCellDelegate <NSObject>

-(void)itemSelectedAtIndex:(LatestCatalogueImageCollectionCell *)cell forImagesArray:(NSArray *)imagesArray forIndexPath:(NSIndexPath *)indexPath tableIndexPath:(NSIndexPath *)tableIndexPath;

@end
