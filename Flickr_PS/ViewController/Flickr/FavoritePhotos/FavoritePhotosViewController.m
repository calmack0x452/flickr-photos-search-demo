//
//  FavoritePhotosViewController.m
//  Flickr PS
//
//  Created by Mack Liu on 2020/3/1.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import "FavoritePhotosViewController.h"
#import "FavoritPhotosManager.h"
#import "PhotosCollectionViewCell.h"
#import "FlickrPhotoModel.h"

@interface FavoritePhotosViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end

@implementation FavoritePhotosViewController {
    
    NSMutableArray<FlickrPhotoModel *> *favoritPhotos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.photosCollectionView registerNib:[UINib nibWithNibName:@"PhotosCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotosCollectionViewCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.title = @"我的最愛";
    
    favoritPhotos = [FavoritPhotosManager loadingFavoritPhotos];
    [self.photosCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return favoritPhotos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FlickrPhotoModel *flickrPhoto = favoritPhotos[indexPath.row];
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotosCollectionViewCell" forIndexPath:indexPath];
    [cell assignDataModel:flickrPhoto];
    [cell.favoriteButton setHidden:YES];
    
    return cell;
}

#pragma mark - UICollectionViewLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = CGRectGetWidth(self.view.frame) / 2.0f;
    CGFloat cellHeight = cellWidth + 30.0f;
    CGSize cellSize = CGSizeMake(cellWidth - 15.0f, cellHeight);
    
    return cellSize;
}

@end
