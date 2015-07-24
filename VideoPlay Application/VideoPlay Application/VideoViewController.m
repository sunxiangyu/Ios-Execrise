//
//  VideoViewController.m
//  VideoPlay Application
//
//  Created by 孙翔宇 on 15/7/10.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "VideoViewController.h"
#import "Video.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>

#define kUrl(path) [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/MJServer/%@", path]]

@interface VideoViewController ()

@property(nonatomic, strong) NSMutableArray *videos;

@end

@implementation VideoViewController

-(NSMutableArray *)videos
{
    if (_videos == nil) {
        _videos = [[NSMutableArray alloc] init];
    }
    return _videos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL *url = kUrl(@"video");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"网络繁忙"];
            return;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *videoArray = dict[@"videos"];
        
        for (NSDictionary *videoDict in videoArray) {
            Video *video = [Video videoWithDict:videoDict];
            [self.videos addObject:video];
        }
        
        [self.tableView reloadData];
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"video";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Video *video = self.videos[indexPath.row];
    
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长 : %d 分钟", video.length];
    
    NSURL *url = kUrl(video.image);
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]options:SDWebImageRetryFailed];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Video *video = self.videos[indexPath.row];
    
    NSURL *url = kUrl(video.url);
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [self presentViewController:player animated:YES completion:nil];
    
}


@end
