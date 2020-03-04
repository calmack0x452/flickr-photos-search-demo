//
//  FlickrPhotoModel.m
//  Flickr PS
//
//  Created by Mack Liu on 2020/2/29.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import "FlickrPhotoModel.h"

@implementation FlickrPhotoModel 

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.farm_id forKey:@"farm_id"];
    [coder encodeObject:self.server_id forKey:@"server_id"];
    [coder encodeObject:self.image_id forKey:@"image_id"];
    [coder encodeObject:self.secret forKey:@"secret"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.farm_id = [coder decodeObjectForKey:@"farm_id"];
        self.server_id = [coder decodeObjectForKey:@"server_id"];
        self.image_id = [coder decodeObjectForKey:@"image_id"];
        self.secret = [coder decodeObjectForKey:@"secret"];
    }
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    
    return YES;
}

@end
