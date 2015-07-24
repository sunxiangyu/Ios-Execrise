//
//  Apps.h
//  Cell Image Demo
//
//  Created by 孙翔宇 on 15/7/1.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apps : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *download;

+(instancetype)appsWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
