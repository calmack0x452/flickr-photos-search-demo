//
//  PhotosCollectionViewCell.h
//  Flickr PS
//
//  Created by Mack Liu on 2020/2/28.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;


- (void)assignDataModel:(FlickrPhotoModel *)dataModel;

@end

NS_ASSUME_NONNULL_END
