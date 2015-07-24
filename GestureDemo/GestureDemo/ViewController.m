//
//  ViewController.m
//  GestureDemo
//
//  Created by 孙翔宇 on 15/6/23.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"

@interface ViewController ()<LockViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)lockViewDidClick:(LockView *)lockView andPwd:(NSString *)pwd
{
    NSLog(@"%@", pwd);
}


@end
