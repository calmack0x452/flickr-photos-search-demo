//
//  FavoritPhotosManager.m
//  Flickr PS
//
//  Created by Mack Liu on 2020/3/1.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import "FavoritPhotosManager.h"

@implementation FavoritPhotosManager

+ (BOOL)isAddToFavorit:(NSMutableArray<FlickrPhotoModel *> *)favoritPhotos imageID:(NSString *)imageID {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"image_id == %@", imageID];
    if ([favoritPhotos filteredArrayUsingPredicate:predicate].count == 0) {
        return NO;
    }
    
    return YES;
}

+ (NSMutableArray<FlickrPhotoModel *> *)loadingFavoritPhotos {
    
    NSData *favoritPhotosData = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritPhotos"];
    NSMutableArray<FlickrPhotoModel *> *favoritPhotos = [NSKeyedUnarchiver unarchiveObjectWithData:favoritPhotosData];
    
    if (!favoritPhotos) {
        favoritPhotos = [NSMutableArray new];
    }
    
    return favoritPhotos;
}

+ (void)saveFavoritPhotos:(NSMutableArray<FlickrPhotoModel *> *)favoritPhotos {
    
    NSData *favoritPhotosData = [NSKeyedArchiver archivedDataWithRootObject:favoritPhotos];
    [[NSUserDefaults standardUserDefaults] setObject:favoritPhotosData forKey:@"favoritPhotos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
