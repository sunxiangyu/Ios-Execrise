//
//  AppsViewController.m
//  Cell Image Demo
//
//  Created by 孙翔宇 on 15/7/1.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "AppsViewController.h"
#import "Apps.h"
#import "DownloadOperation.h"

#define kAppImageFile(url) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]]

@interface AppsViewController ()<DownloadOperationDelegate>

@property(nonatomic,strong) NSMutableArray *apps;

@property(nonatomic, strong) NSMutableDictionary *operations;

@property(nonatomic, strong) NSMutableDictionary *images;

@property(nonatomic, strong) NSOperationQueue *queue;

@end

@implementation AppsViewController

-(NSMutableArray *)apps
{
    if (_apps == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [arrM addObject:[Apps appsWithDict:dict]];
        }
        _apps = arrM;
    }
    return _apps;
}

-(NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

-(NSMutableDictionary *)images
{
    if (_images == nil) {
        _images = [[NSMutableDictionary alloc] init];
    }
    return _images;
}

-(NSMutableDictionary *)operations
{
    if (_operations == nil) {
        _operations = [[NSMutableDictionary alloc] init];
    }
    return _operations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)didReceiveMemoryWarning
{
    [self.queue cancelAllOperations];
    [self.operations removeAllObjects];
    [self.images removeAllObjects];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Apps *app = self.apps[indexPath.row];
    cell.textLabel.text =app.name;
    cell.detailTextLabel.text = app.download;
    
    UIImage *image = self.images[app.icon];
    if (image) {
        cell.imageView.image = image;
    } else {
        
        NSString *file = kAppImageFile(app.icon);
        NSData *data = [NSData dataWithContentsOfFile:file];
        if (data) {
            cell.imageView.image = [UIImage imageWithData:data];
        } else {
            cell.imageView.image = [UIImage imageNamed:@"placeholder"];
            
            [self download:app.icon indexPath:indexPath];
        }
    }
    
    return cell;
    
}

-(void)download:(NSString *)imageUrl indexPath:(NSIndexPath *)indexPath
{
    DownloadOperation *operation = self.operations[imageUrl];
    if (operation) return;
    
    operation = [[DownloadOperation alloc] init];
    operation.imageUrl = imageUrl;
    operation.indexPath = indexPath;
    
    operation.delegate = self;
    
    [self.queue addOperation:operation];
    
    self.operations[imageUrl] = operation;
}

#pragma mark - DownloadOperationDelegate

-(void)downloadOperation:(DownloadOperation *)operation didFinishDownload:(UIImage *)image
{
    if (image) {
        self.images[operation.imageUrl] = image;
        
        NSData *data = UIImagePNGRepresentation(image);
        
        [data writeToFile:kAppImageFile(operation.imageUrl) atomically:YES];
    }
    
    [self.operations removeObjectForKey:operation.imageUrl];
    
    [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.queue setSuspended:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.queue setSuspended:NO];
}


@end
