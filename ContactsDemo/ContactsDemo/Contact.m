//
//  Contact.m
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/15.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    
    [aCoder encodeObject:self.phone forKey:@"phone"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}

@end
