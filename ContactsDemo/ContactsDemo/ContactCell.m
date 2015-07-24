//
//  ContactCell.m
//  ContactsDemo
//
//  Created by 孙翔宇 on 15/6/16.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "ContactCell.h"
#import "Contact.h"

@interface ContactCell ()

@property(nonatomic, weak) UIView *divider;

@end

@implementation ContactCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"contacts";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

-(void)setContact:(Contact *)contact
{
    _contact = contact;
    
    self.textLabel.text = _contact.name;
    self.detailTextLabel.text = _contact.phone;
}

- (void)awakeFromNib {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    self.divider = view;
    [self.contentView addSubview:view];
   
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"initWithStyle");
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat h = 1;
    CGFloat w = self.frame.size.width;
    CGFloat y = self.frame.size.height - h;
    
    self.divider.frame = CGRectMake(x, y, w, h);
}


@end
