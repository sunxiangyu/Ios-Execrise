//
//  DownloadOperation.h
//  Cell Image Demo
//
//  Created by 孙翔宇 on 15/7/9.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DownloadOperation;

@protocol DownloadOperationDelegate <NSObject>

-(void)downloadOperation:(DownloadOperation *)operation didFinishDownload:(UIImage *)image;

@end

@interface DownloadOperation : NSOperation

@property(nonatomic,copy) NSString *imageUrl;
@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,weak) id<DownloadOperationDelegate> delegate;

@end
