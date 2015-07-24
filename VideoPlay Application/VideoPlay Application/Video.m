//
//  Video.m
//  VideoPlay Application
//
//  Created by 孙翔宇 on 15/7/10.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "Video.h"

@implementation Video

+(instancetype)videoWithDict:(NSDictionary *)dict
{
    Video *video = [[self alloc] init];
    [video setValuesForKeysWithDictionary:dict];
    return video;
}

@end
