//
//  LockView.h
//  GestureDemo
//
//  Created by 孙翔宇 on 15/6/23.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LockView;

@protocol LockViewDelegate <NSObject>

-(void)lockViewDidClick:(LockView *)lockView andPwd:(NSString *)pwd;

@end

@interface LockView : UIView

@property(nonatomic, weak) IBOutlet id<LockViewDelegate> delegate;

@end
