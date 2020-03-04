//
//  SearchConditionModel.m
//  Flickr PS
//
//  Created by Mack Liu on 2020/2/28.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import "SearchConditionModel.h"

@implementation SearchConditionModel

+ (instancetype)sharedInstance {
    
    static SearchConditionModel *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[SearchConditionModel alloc] init];
    });
    
    return instance;
}

@end
