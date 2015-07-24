//
//  AddViewController.h
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/15.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact, AddViewController;

@protocol AddViewControllerDelegate <NSObject>

- (void)addViewControllerDidAddBtn:(AddViewController *)addViewController contact:(Contact *)contact;

@end

@interface AddViewController : UIViewController

@property(nonatomic, weak) id<AddViewControllerDelegate> delegate;

@end
