//
//  Video.h
//  VideoPlay Application
//
//  Created by 孙翔宇 on 15/7/10.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property(nonatomic, assign) int id;

@property(nonatomic, assign) int length;

@property(nonatomic, copy) NSString *image;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *url;

+(instancetype)videoWithDict:(NSDictionary *)dict;

@end
