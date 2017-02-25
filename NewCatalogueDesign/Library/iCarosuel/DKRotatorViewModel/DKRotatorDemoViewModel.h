//
//  DKRotatorDemoViewModel.h
//  DKRotatorView
//
//  Created by drinking on 15/5/26.
//  Copyright (c) 2015年 drinking. All rights reserved.
//

#import <PXRotatorView/PXRotatorBaseViewModel.h>

@interface DKRotatorDemoViewModel : PXRotatorBaseViewModel

@property (nonatomic, strong) UILabel *winnerNameLabel;
@property (nonatomic, strong) UIImageView *winnerImageView;

@property (nonatomic, assign) id rotatorDemoDelegate;

@end

@protocol DKRotatorDemoViewModelDelegate <NSObject>

-(void)indexForTheSelectedItem:(NSInteger)selectedIndex;

@end
