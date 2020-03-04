//
//  FlickrPhotoModel.h
//  Flickr PS
//
//  Created by Mack Liu on 2020/2/29.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlickrPhotoModel : NSObject <NSSecureCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *farm_id;
@property (nonatomic, copy) NSString *server_id;
@property (nonatomic, copy) NSString *image_id;
@property (nonatomic, copy) NSString *secret;

@end

NS_ASSUME_NONNULL_END
