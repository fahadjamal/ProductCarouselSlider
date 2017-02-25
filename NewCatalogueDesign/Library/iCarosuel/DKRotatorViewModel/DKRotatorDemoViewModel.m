//
//  DKRotatorDemoViewModel.m
//  DKRotatorView
//
//  Created by drinking on 15/5/26.
//  Copyright (c) 2015年 drinking. All rights reserved.
//

#import "DKRotatorDemoViewModel.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@implementation DKRotatorDemoViewModel

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _winnerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 160)];
    _winnerImageView.layer.masksToBounds = YES;
    _winnerImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSDictionary *winnerDict = [self.displayItems objectAtIndex:carousel.currentItemIndex];
    NSString *imageURL = [NSString stringWithFormat:@"%@", [winnerDict objectForKey:@"Image_link"]];
    NSString *winnerName = [NSString stringWithFormat:@"%@", [winnerDict objectForKey:@"Winner_name"]];
    
    NSLog(@"imageURL is %@", imageURL);
    [_winnerImageView setImageWithURL:[NSURL URLWithString:imageURL] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_winnerNameLabel setText:winnerName];
    
    return _winnerImageView;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    [super carouselCurrentItemIndexDidChange:carousel];
    //[carousel setPageConrolCurrentPage:carousel.currentItemIndex];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    // TODO: handle your click action here
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}
@end
