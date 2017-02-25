//
//  ImageCollectionCell.m
//  TableviewCellConCollection
//
//  Created by Gizbo UAE on 11/7/15.
//  Copyright © 2015 testing. All rights reserved.
//

#import "LatestCatalogueImageCollectionCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@implementation LatestCatalogueImageCollectionCell

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.carosuelImageView sd_cancelCurrentImageLoad];
}

@end

