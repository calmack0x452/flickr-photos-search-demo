//
//  SearchResultViewController.m
//  Flickr PS
//
//  Created by Mack Liu on 2020/2/28.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchConditionModel.h"
#import "PhotosCollectionViewCell.h"
#import "FlickrPhotoModel.h"
#import "FavoritPhotosManager.h"
#import <objectiveflickr/ObjectiveFlickr.h>
#import <MJRefresh/MJRefresh.h>

@interface SearchResultViewController () <OFFlickrAPIRequestDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end

@implementation SearchResultViewController {
    
    NSInteger photosPage;
    SearchConditionModel *searchCondition;
    OFFlickrAPIContext *flickrContext;
    OFFlickrAPIRequest *flickrRequest;
    
    NSMutableArray<FlickrPhotoModel *> *flickrPhotos;
    NSMutableArray<FlickrPhotoModel *> *favoritPhotos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    photosPage = 1;
    flickrPhotos = [NSMutableArray new];
    searchCondition = [SearchConditionModel sharedInstance];
    favoritPhotos = [FavoritPhotosManager loadingFavoritPhotos];
    
    self.photosCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(searchPhotosFromFlickr)];
    [self.photosCollectionView registerNib:[UINib nibWithNibName:@"PhotosCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotosCollectionViewCell"];
    
    [self searchPhotosFromFlickr];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.title = [NSString stringWithFormat:@"搜尋結果 %@", searchCondition.keyword];
}

#pragma mark - Application with Logic

- (void)displayHint:(BOOL)display content:(NSString *)content {
    
    if (display) {
        _hintLabel.hidden = NO;
        _hintLabel.text = content;
    }
    else {
        _hintLabel.hidden = NO;
        _hintLabel.text = @"";
    }
}

- (IBAction)favoritButtonTaped:(UIButton *)sender {
    
    FlickrPhotoModel *flickrPhoto = flickrPhotos[sender.tag];
    
    if (![FavoritPhotosManager isAddToFavorit:favoritPhotos imageID:flickrPhoto.image_id]) {
        [favoritPhotos addObject:flickrPhoto];
        [FavoritPhotosManager saveFavoritPhotos:favoritPhotos];
        [sender setImage:[UIImage imageNamed:@"favorit.check"] forState:UIControlStateNormal];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return flickrPhotos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FlickrPhotoModel *flickrPhoto = flickrPhotos[indexPath.row];
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotosCollectionViewCell" forIndexPath:indexPath];
    [cell assignDataModel:flickrPhoto];
    [cell.favoriteButton setTag:indexPath.row];
    [cell.favoriteButton addTarget:self action:@selector(favoritButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([FavoritPhotosManager isAddToFavorit:favoritPhotos imageID:flickrPhoto.image_id]) {
        [cell.favoriteButton setImage:[UIImage imageNamed:@"favorit.check"] forState:UIControlStateNormal];
    }
    else {
        [cell.favoriteButton setImage:[UIImage imageNamed:@"favorit.add"] forState:UIControlStateNormal];
    }
    
    return cell;
}

#pragma mark - UICollectionViewLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = CGRectGetWidth(self.view.frame) / 2.0f;
    CGFloat cellHeight = cellWidth + 30.0f;
    CGSize cellSize = CGSizeMake(cellWidth - 15.0f, cellHeight);
    
    return cellSize;
}

#pragma mark - Flickr API with ObjectiveFlickr

- (void)searchPhotosFromFlickr {
    
    flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:@"a8a3e93361034c6da4f2e64ec3b8bab1" sharedSecret:@"081f9142a8b33637"];
    flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:flickrContext];
    
    [flickrRequest setDelegate:self];
    [flickrRequest callAPIMethodWithGET:@"flickr.photos.search" arguments:@{@"page": @(photosPage).stringValue,
                                                                            @"per_page": searchCondition.photosPerPage,
                                                                            @"text": searchCondition.keyword}];
    
    [self displayHint:NO content:nil];
}

#pragma mark - Flickr API with OFFlickrAPIRequestDelegate

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary {
    
    if ([inResponseDictionary[@"stat"] isEqualToString:@"ok"]) {
        NSArray<NSDictionary *> *photosInfo = inResponseDictionary[@"photos"][@"photo"];
        
        for (NSDictionary *photoDict in photosInfo) {
            FlickrPhotoModel *flickrPhoto = [FlickrPhotoModel new];
            flickrPhoto.name = photoDict[@"title"];
            flickrPhoto.farm_id = photoDict[@"farm"];
            flickrPhoto.server_id = photoDict[@"server"];
            flickrPhoto.image_id = photoDict[@"id"];
            flickrPhoto.secret = photoDict[@"secret"];
            
            [flickrPhotos addObject:flickrPhoto];
        }
        
        photosPage++;
        [_photosCollectionView reloadData];
        [_photosCollectionView.mj_footer endRefreshing];
    }
    else {
        [self displayHint:YES content:@"啊喔～搜尋時不小心出錯了，再重試一次吧！"];
    }
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError {
    
    [self displayHint:YES content:@"啊喔～搜尋時不小心出錯了，再重試一次吧！"];
}

@end
