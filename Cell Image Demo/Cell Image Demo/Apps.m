//
//  Apps.m
//  Cell Image Demo
//
//  Created by 孙翔宇 on 15/7/1.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "Apps.h"

@implementation Apps

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)appsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
