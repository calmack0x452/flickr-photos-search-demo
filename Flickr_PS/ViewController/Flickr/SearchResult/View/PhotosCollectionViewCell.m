//
//  PhotosCollectionViewCell.m
//  Flickr PS
//
//  Created by Mack Liu on 2020/2/28.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import "PhotosCollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>

@implementation PhotosCollectionViewCell

- (void)assignDataModel:(FlickrPhotoModel *)dataModel {
    
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_m.jpg"
                                            , dataModel.farm_id
                                            , dataModel.server_id
                                            , dataModel.image_id
                                            , dataModel.secret]];

    _imageViewWidth.constant = self.frame.size.width;
    _imageLabel.text = dataModel.name;
    [_imageView sd_setImageWithURL:imageURL
                  placeholderImage:[UIImage imageNamed:@"image"]];
}

@end


