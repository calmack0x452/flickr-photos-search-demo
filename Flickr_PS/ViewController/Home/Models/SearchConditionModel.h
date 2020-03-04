//
//  SearchConditionModel.h
//  Flickr PS
//
//  Created by Mack Liu on 2020/2/28.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchConditionModel : NSObject

@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *photosPerPage;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
