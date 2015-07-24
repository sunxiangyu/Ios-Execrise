//
//  ContactCell.h
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/16.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@interface ContactCell : UITableViewCell

@property(nonatomic, strong) Contact *contact;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
