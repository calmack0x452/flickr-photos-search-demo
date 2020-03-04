//
//  FavoritPhotosManager.h
//  Flickr PS
//
//  Created by Mack Liu on 2020/3/1.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoritPhotosManager : NSObject

+ (NSMutableArray<FlickrPhotoModel *> *)loadingFavoritPhotos;
+ (void)saveFavoritPhotos:(NSMutableArray<FlickrPhotoModel *> *)favoritPhotos;
+ (BOOL)isAddToFavorit:(NSMutableArray<FlickrPhotoModel *> *)favoritPhotos imageID:(NSString *)imageID;

@end

NS_ASSUME_NONNULL_END
