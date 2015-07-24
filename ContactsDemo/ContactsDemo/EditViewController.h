//
//  EditViewController.h
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/15.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact, EditViewController;

@protocol EditViewControllerDelegate <NSObject>

- (void)editViewControllerDidClickSaveBtn:(EditViewController *)editViewController contact:(Contact *)contact;

@end

@interface EditViewController : UIViewController

@property(nonatomic, strong) Contact *contact;

@property(nonatomic, weak) id<EditViewControllerDelegate> delegate;

@end
