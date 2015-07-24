//
//  DownloadOperation.m
//  Cell Image Demo
//
//  Created by 孙翔宇 on 15/7/9.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation

-(void)main
{
    @autoreleasepool {
        if (self.isCancelled) return;
        
        NSURL *url = [NSURL URLWithString:self.imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        if (self.isCancelled) return;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if ([self.delegate respondsToSelector:@selector(downloadOperation:didFinishDownload:)]) {
                [self.delegate downloadOperation:self didFinishDownload:image];
            }
        }];
    }
}

@end
