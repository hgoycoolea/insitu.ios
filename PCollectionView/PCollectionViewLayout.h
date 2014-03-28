//
//  PCollectionViewLayout.h
//  insitu
//
//  Created by Hector Goycoolea on 3/28/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//
#import <UIKit/UICollectionViewLayout.h>
#import <UIKit/UICollectionView.h>
#import <UIKit/UIKitDefines.h>
#import <Foundation/Foundation.h>
/// protocol to extend and deletegate the 
@protocol UICollectionViewDelegateJSPintLayout <UICollectionViewDelegate>
@optional

- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath*)indexPath;
- (CGFloat)columnWidthForCollectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;
- (NSUInteger)maximumNumberOfColumnsForCollectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;

@end


NS_CLASS_AVAILABLE_IOS(6_0) @interface PCollectionViewLayout : UICollectionViewLayout

- (id)init;

@property (nonatomic) CGFloat lineSpacing;
@property (nonatomic) CGFloat interitemSpacing;
@property (nonatomic) CGFloat itemHeight;
@property (nonatomic) CGFloat columnWidth;
@property (nonatomic) NSUInteger numberOfColumns;

@end